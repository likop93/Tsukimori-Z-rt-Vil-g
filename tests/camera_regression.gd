extends SceneTree

# Run: godot --headless --path . --script res://tests/camera_regression.gd
var failures: int = 0
var world: Node3D
var player: CharacterBody3D
var rig: Node3D
var camera: Camera3D

func _initialize() -> void:
    call_deferred("run_checks")

func expect(condition: bool, message: String) -> void:
    if not condition:
        failures += 1
        push_error(message)

func frames(count: int) -> void:
    for frame in range(count):
        await physics_frame

func set_key(key: Key, pressed: bool) -> void:
    var event := InputEventKey.new()
    event.keycode = key
    event.pressed = pressed
    Input.parse_input_event(event)

func settle_at(z: float) -> void:
    player.global_position = Vector3(0.0, 0.1, z)
    player.velocity = Vector3.ZERO
    await frames(240)

func check_shot(z: float, yaw: float, offset: Vector3, pitch: float) -> void:
    player.global_position = Vector3(0.0, 0.1, z)
    player.velocity = Vector3.ZERO
    var previous_yaw := rig.rotation.y
    for frame in range(240):
        await physics_frame
        var step := absf(angle_difference(previous_yaw, rig.rotation.y))
        expect(step < deg_to_rad(2.0), "Camera snapped during a zone transition")
        previous_yaw = rig.rotation.y
    expect(absf(angle_difference(rig.rotation.y, deg_to_rad(yaw))) < 0.001, "Incorrect zone yaw at z=%s" % z)
    expect(camera.position.distance_to(offset) < 0.01, "Incorrect zone offset at z=%s" % z)
    expect(absf(camera.rotation.x - deg_to_rad(pitch)) < 0.001, "Incorrect zone pitch at z=%s" % z)
    expect(not camera.is_position_behind(player.global_position), "Player behind camera")

func check_controls(z: float) -> void:
    await settle_at(z)
    for keys in [[KEY_W], [KEY_S], [KEY_A], [KEY_D], [KEY_W, KEY_D]]:
        player.global_position.x = 0.0
        player.global_position.z = z
        player.velocity = Vector3.ZERO
        await frames(20)
        var start := player.global_position
        for key in keys:
            set_key(key, true)
        await frames(35)
        for key in keys:
            set_key(key, false)
        var displacement := player.global_position - start
        var expected := Vector3.ZERO
        if KEY_W in keys: expected += Vector3.FORWARD
        if KEY_S in keys: expected += Vector3.BACK
        if KEY_A in keys: expected += Vector3.LEFT
        if KEY_D in keys: expected += Vector3.RIGHT
        displacement.y = 0.0
        expect(displacement.normalized().distance_to(expected.normalized()) < 0.001, "WASD world direction changed with camera at z=%s" % z)
        expect(absf(Vector2(player.velocity.x, player.velocity.z).length() - player.move_speed) < 0.01, "Cardinal/diagonal speed differs")
        var facing := player.get_node("VisualRoot").global_basis.z as Vector3
        var motion := Vector3(player.velocity.x, 0.0, player.velocity.z).normalized()
        expect(facing.dot(motion) > 0.98, "Visual body does not face actual motion")
        expect(player.rotation.is_zero_approx(), "Movement rotated the player root")
        await frames(25)
        expect(Vector2(player.velocity.x, player.velocity.z).length() < 0.001, "Player failed to stop on key release")

func run_checks() -> void:
    var main := load("res://scenes/main.tscn").instantiate() as Node
    root.add_child(main)
    world = main.get_node("MountainPath")
    player = world.get_node("Player")
    rig = player.get_node("CameraPivot")
    camera = rig.get_node("Camera3D")
    await frames(60)
    expect(player.get_script().resource_path == "res://scripts/player_controller.gd", "Player script binding changed")
    expect(rig.top_level, "Camera still inherits player transforms")
    var original_basis := camera.global_basis
    player.rotation.y = 1.2
    expect(camera.global_basis.is_equal_approx(original_basis), "Player rotation affects camera")
    player.rotation.y = 0.0

    player.global_position.x += 2.0
    await frames(2)
    var follow_error := absf(rig.global_position.x - player.global_position.x)
    expect(follow_error > 0.1 and follow_error < 2.0, "Follow must ease toward the player")
    await frames(90)
    expect(absf(rig.global_position.x - player.global_position.x) < 0.001, "Follow did not converge")

    # Enter, overlap, exit and reverse traversal, using actual Area3D overlaps.
    await check_shot(20.0, 0.0, Vector3(0, 7.2, 8.8), -34.0)
    await check_shot(0.0, 22.0, Vector3(0, 6.4, 9.6), -30.0)
    await check_shot(-14.0, -12.0, Vector3(0, 4.8, 8.2), -18.0)
    await check_shot(-24.0, -12.0, Vector3(0, 4.8, 8.2), -18.0)
    await check_shot(-14.0, -12.0, Vector3(0, 4.8, 8.2), -18.0)
    await check_shot(-5.0, 22.0, Vector3(0, 6.4, 9.6), -30.0)
    await check_shot(20.0, 0.0, Vector3(0, 7.2, 8.8), -34.0)
    for z in [20.0, 0.0, -24.0]:
        await check_controls(z)

    # Holding W must preserve the world direction while the camera changes shots.
    await settle_at(9.0)
    var held_forward := Vector3.FORWARD
    var start_position := player.global_position
    set_key(KEY_W, true)
    await frames(20)
    var largest_deviation := 0.0
    for frame in range(120):
        await physics_frame
        var motion := Vector3(player.velocity.x, 0.0, player.velocity.z).normalized()
        largest_deviation = maxf(largest_deviation, motion.distance_to(held_forward))
    expect(largest_deviation < 0.001, "Camera steered held W without player input")
    expect(absf(player.global_position.x - start_position.x) < 0.01, "Held W drifted off the original path")
    expect(rig.rotation.y > deg_to_rad(20.0), "Traversal did not activate side shot")

    # Additional held keys steer in the same frame; cancelling keys must not reset it.
    set_key(KEY_S, true)
    await frames(25)
    expect(Vector2(player.velocity.x, player.velocity.z).length() < 0.001, "Opposing keys did not stop movement")
    set_key(KEY_S, false)
    await frames(25)
    expect(Vector3(player.velocity.x, 0, player.velocity.z).normalized().distance_to(held_forward) < 0.001, "Opposing keys unexpectedly reset the held direction")
    set_key(KEY_D, true)
    await frames(25)
    var held_diagonal := (held_forward + held_forward.cross(Vector3.UP)).normalized()
    expect(Vector3(player.velocity.x, 0, player.velocity.z).normalized().distance_to(held_diagonal) < 0.001, "Adding D unexpectedly rebased held movement")
    set_key(KEY_D, false)
    await frames(25)
    expect(Vector3(player.velocity.x, 0, player.velocity.z).normalized().distance_to(held_forward) < 0.001, "Releasing D unexpectedly rebased held W")

    # Full release/re-press must preserve the same world direction in the new view.
    set_key(KEY_W, false)
    set_key(KEY_W, true)
    await frames(30)
    expect(Vector3(player.velocity.x, 0, player.velocity.z).normalized().distance_to(held_forward) < 0.001, "Quick re-press changed the world direction")
    set_key(KEY_W, false)
    await frames(30)
    set_key(KEY_W, true)
    await frames(30)
    expect(Vector3(player.velocity.x, 0, player.velocity.z).normalized().distance_to(held_forward) < 0.001, "Stopping and restarting changed the world direction")
    set_key(KEY_W, false)
    await frames(30)

    # Preserve diagonal input too when crossing back out of the side zone.
    await settle_at(7.0)
    var diagonal := (Vector3.BACK + Vector3.LEFT).normalized()
    set_key(KEY_S, true)
    set_key(KEY_A, true)
    await frames(20)
    largest_deviation = 0.0
    for frame in range(100):
        await physics_frame
        var motion := Vector3(player.velocity.x, 0, player.velocity.z).normalized()
        largest_deviation = maxf(largest_deviation, motion.distance_to(diagonal))
    expect(largest_deviation < 0.001, "Reverse shot transition steered held diagonal input")
    expect(absf(rig.rotation.y) < deg_to_rad(3.0), "Reverse traversal did not leave the side zone")
    set_key(KEY_S, false)
    set_key(KEY_A, false)
    await frames(30)

    await settle_at(-20.0)
    expect(root.get_node("GameState").has_flag("entered_tsukimori"), "Gate trigger failed")
    expect(world.gate_triggered, "Gate did not latch")
    expect(world.get_node("HUD/Margin/VBox/Status").text.contains("entered_tsukimori = true"), "Gate HUD failed")
    expect(is_equal_approx(camera.fov, 40.0), "Gate FOV effect did not recover")
    root.get_node("GameState").set_flag("entered_tsukimori", false)
    await settle_at(-24.0)
    await settle_at(-20.0)
    expect(not root.get_node("GameState").has_flag("entered_tsukimori"), "Gate triggered more than once")

    print("Camera regression: %s" % ("PASS" if failures == 0 else "%s failures" % failures))
    quit(0 if failures == 0 else 1)
