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

func settle_at(x: float, z: float) -> void:
    player.global_position = Vector3(x, 0.2, z)
    player.velocity = Vector3.ZERO
    await frames(220)

func check_shot(x: float, z: float, yaw: float, offset: Vector3, pitch: float) -> void:
    await settle_at(x, z)
    expect(absf(angle_difference(rig.rotation.y, deg_to_rad(yaw))) < 0.002, "Incorrect zone yaw at %s,%s" % [x, z])
    expect(camera.position.distance_to(offset) < 0.02, "Incorrect zone offset at %s,%s" % [x, z])
    expect(absf(camera.rotation.x - deg_to_rad(pitch)) < 0.002, "Incorrect zone pitch at %s,%s" % [x, z])
    expect(not camera.is_position_behind(player.global_position), "Player behind camera")

func check_control(keys: Array, expected: Vector3, x: float, z: float) -> void:
    await settle_at(x, z)
    var start := player.global_position
    for key in keys:
        set_key(key, true)
    await frames(35)
    for key in keys:
        set_key(key, false)

    var displacement := player.global_position - start
    displacement.y = 0.0
    expect(displacement.normalized().distance_to(expected.normalized()) < 0.001, "WASD world direction changed")
    expect(absf(Vector2(player.velocity.x, player.velocity.z).length() - player.move_speed) < 0.01, "Cardinal/diagonal speed differs")

    var facing := player.get_node("VisualRoot").global_basis.z as Vector3
    var motion := Vector3(player.velocity.x, 0.0, player.velocity.z).normalized()
    expect(facing.dot(motion) > 0.98, "Visual root does not face actual movement")

    await frames(25)
    expect(Vector2(player.velocity.x, player.velocity.z).length() < 0.001, "Player failed to stop")

func run_checks() -> void:
    var main := load("res://scenes/main.tscn").instantiate() as Node
    root.add_child(main)
    world = main.get_node("MountainPath")
    player = world.get_node("Player")
    rig = player.get_node("CameraPivot")
    camera = rig.get_node("Camera3D")
    await frames(60)

    expect(rig.top_level, "Camera still inherits player transforms")

    await check_shot(0.0, 22.0, 0.0, Vector3(0, 7.2, 8.8), -34.0)
    await check_shot(0.0, 8.0, 18.0, Vector3(0.4, 6.7, 9.2), -30.0)
    await check_shot(-3.0, -3.0, -28.0, Vector3(1.8, 7.0, 9.8), -27.0)
    await check_shot(0.0, -20.0, -10.0, Vector3(0, 4.9, 8.3), -19.0)
    await check_shot(0.0, 22.0, 0.0, Vector3(0, 7.2, 8.8), -34.0)

    for point in [Vector2(0, 22), Vector2(0, 8), Vector2(-3, -3), Vector2(0, -20)]:
        await check_control([KEY_W], Vector3.FORWARD, point.x, point.y)
        await check_control([KEY_D], Vector3.RIGHT, point.x, point.y)
        await check_control([KEY_W, KEY_D], (Vector3.FORWARD + Vector3.RIGHT).normalized(), point.x, point.y)

    # The camera may turn through a zone, but holding W must remain world-forward.
    await settle_at(0.0, 15.0)
    set_key(KEY_W, true)
    var start_x := player.global_position.x
    var max_direction_error := 0.0
    for frame in range(120):
        await physics_frame
        var motion := Vector3(player.velocity.x, 0.0, player.velocity.z)
        if motion.length() > 0.01:
            max_direction_error = maxf(max_direction_error, motion.normalized().distance_to(Vector3.FORWARD))
    set_key(KEY_W, false)
    expect(max_direction_error < 0.001, "Camera transition steered held W")
    expect(absf(player.global_position.x - start_x) < 0.02, "Held W drifted sideways")
    expect(absf(rig.rotation.y) > deg_to_rad(8.0), "Traversal did not activate a directed shot")
    await frames(30)

    await settle_at(0.0, -27.0)
    expect(root.get_node("GameState").has_flag("entered_tsukimori"), "Gate trigger failed")
    expect(world.gate_triggered, "Gate did not latch")
    expect(world.get_node("HUD/Margin/VBox/Status").text.contains("entered_tsukimori = true"), "Gate HUD failed")
    expect(is_equal_approx(camera.fov, 40.0), "Gate FOV effect did not recover")

    print("Camera regression: %s" % ("PASS" if failures == 0 else "%s failures" % failures))
    quit(0 if failures == 0 else 1)
