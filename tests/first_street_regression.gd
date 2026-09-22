extends SceneTree

var failures := 0
var world: Node3D
var street: Node3D
var player: CharacterBody3D
var camera_rig: Node3D

func _initialize() -> void:
    call_deferred("run_checks")

func expect(condition: bool, message: String) -> void:
    if not condition:
        failures += 1
        push_error(message)

func frames(count: int) -> void:
    for frame in range(count):
        await physics_frame

func settle_at(position_value: Vector3) -> void:
    player.global_position = position_value
    player.velocity = Vector3.ZERO
    await frames(240)

func run_checks() -> void:
    var main: Node = load("res://scenes/main.tscn").instantiate()
    root.add_child(main)
    world = main.get_node("MountainPath")
    street = world.get_node("FirstStreet")
    player = world.get_node("Player")
    camera_rig = player.get_node("CameraPivot")
    await frames(5)

    expect(street.get_node("Houses").get_child_count() == 6, "Expected six house blockouts")
    expect(street.get_node("NPCSlots").get_child_count() == 6, "Expected six villager slots")
    expect(street.get_node("Lanterns").get_child_count() == 4, "Expected four street lanterns")
    expect(street.has_node("StreetSurface/LeftAlley"), "Left alley is missing")
    expect(street.has_node("StreetSurface/RightAlley"), "Right alley is missing")
    expect(street.has_node("MiyakoMeeting/MiyakoMarker"), "Miyako meeting marker is missing")
    expect(street.get_node("Ground") is StaticBody3D, "Street ground has no static collision")
    for house in street.get_node("Houses").get_children():
        expect(house is StaticBody3D and house.has_node("CollisionShape3D"), "%s has no collision" % house.name)

    await settle_at(Vector3(0, 0.2, -38))
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(10.0))) < 0.002, "Street entry camera did not settle")
    expect(root.get_node("GameState").has_flag("entered_first_street"), "Street entry trigger did not set its flag")
    await settle_at(Vector3(0, 0.2, -58))
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(-15.0))) < 0.002, "Main street camera did not settle")
    await settle_at(Vector3(0, 0.2, -84))
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(18.0))) < 0.002, "Miyako court camera did not settle")
    expect(root.get_node("GameState").has_flag("reached_miyako_meeting_space"), "Miyako meeting trigger did not set its flag")
    expect(street.meeting_reached, "Miyako meeting did not latch")
    expect(world.get_node("HUD/Margin/VBox/Status").text.contains("Miyako"), "Miyako meeting status was not shown")
    expect(player.rotation.is_zero_approx(), "Street camera changed the player root rotation")

    print("First street regression: %s" % ("PASS" if failures == 0 else "%s failures" % failures))
    quit(0 if failures == 0 else 1)
