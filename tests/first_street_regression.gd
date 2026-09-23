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
    await frames(8)

    expect(street.get_node("Houses").get_child_count() == 14, "Expected fourteen house blockouts")
    expect(street.get_node("NPCSlots").get_child_count() == 8, "Expected eight villager slots")
    expect(street.get_node("Lanterns").get_child_count() == 6, "Expected six street lanterns")
    expect(street.has_node("StreetSurface/LeftAlley"), "Left alley is missing")
    expect(street.has_node("StreetSurface/RightAlley"), "Right alley is missing")
    expect(street.has_node("StreetSurface/UpperLeftAlley"), "Upper left alley is missing")
    expect(street.has_node("StreetSurface/UpperRightAlley"), "Upper right alley is missing")
    expect(street.has_node("Houses/KatsuroMiyakoHome/KatsuroDoor"), "Miyako's stream-facing house is missing")
    expect(street.has_node("Houses/ShionHome/ShionDoor"), "Shion's house across the stream is missing")
    expect(street.has_node("Houses/HanaHome"), "Hana's neighboring house is missing")
    expect(street.has_node("Stream/Water"), "Stream water is missing")
    expect(street.has_node("Stream/Bridge/CollisionShape3D"), "Walkable bridge is missing")
    expect(street.has_node("MiyakoMeeting/MiyakoMarker"), "Miyako meeting marker is missing")
    expect(street.has_node("WindDetails/HangingCloth"), "Animated hanging cloth is missing")
    expect(street.has_node("WindDetails/Petals"), "Animated petals are missing")
    expect(street.has_node("WindDetails/Plants"), "Animated plant proxies are missing")
    expect(street.has_node("AmbientMotion"), "First street ambient controller is missing")
    expect(street.get_node("Ground") is StaticBody3D, "Street ground has no static collision")
    expect(street.get_node("FarBankGround") is StaticBody3D, "Far bank ground has no static collision")
    var miyako_home := street.get_node("Houses/KatsuroMiyakoHome") as Node3D
    var shion_home := street.get_node("Houses/ShionHome") as Node3D
    var hana_home := street.get_node("Houses/HanaHome") as Node3D
    var water := street.get_node("Stream/Water") as Node3D
    expect(miyako_home.position.z > water.position.z and shion_home.position.z < water.position.z, "Miyako and Shion must live on opposite banks")
    expect(absf(miyako_home.position.z - hana_home.position.z) < 3.0, "Hana must live next to Miyako")
    for villager in street.get_node("NPCSlots").get_children():
        expect(villager.position.z > miyako_home.position.z + 10.0, "%s is not on Akira's approach through the village" % villager.name)

    for house in street.get_node("Houses").get_children():
        expect(house is StaticBody3D and house.has_node("CollisionShape3D"), "%s has no collision" % house.name)

    for villager in street.get_node("NPCSlots").get_children():
        expect(villager.has_node("BodyRoot"), "%s did not build a humanoid proxy" % villager.name)
        expect(villager.get("observer") == player and villager.get("whisper_partner") != null, "%s cannot react to Akira and a neighbor" % villager.name)

    expect(street.get_node("MiyakoMeeting/MiyakoMarker").has_node("BodyRoot"), "Miyako marker did not build a humanoid proxy")

    await settle_at(Vector3(0, 0.2, -38))
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(10.0))) < 0.002, "Street entry camera did not settle")
    expect(root.get_node("GameState").has_flag("entered_first_street"), "Street entry trigger did not set its flag")
    expect(not street.meeting_reached, "Miyako encounter started before reaching the house")

    await settle_at(Vector3(0, 0.2, -45))
    expect(root.get_node("GameState").has_flag("noticed_by_villagers"), "Villagers did not notice Akira")
    expect(absf(angle_difference(street.get_node("NPCSlots/Villager01").rotation.y, deg_to_rad(32.0))) > 0.1, "Villager did not turn toward Akira")
    expect(not street.meeting_reached, "Miyako appeared before Akira crossed the village")

    await settle_at(Vector3(0, 0.2, -63))
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(-15.0))) < 0.002, "Main street camera did not settle")

    await settle_at(Vector3(0, 0.2, -82))
    expect(root.get_node("GameState").has_flag("heard_village_whispers"), "Villagers did not whisper as Akira passed")
    expect(not street.meeting_reached, "Miyako encounter started in the middle of the village")

    await settle_at(Vector3(0, 0.2, -105))
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(-8.0))) < 0.002, "Inner street camera did not settle")
    expect(not street.meeting_reached, "Miyako encounter started before the far edge of the village")

    await settle_at(Vector3(0, 0.2, -121))
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(27.0))) < 0.002, "Miyako encounter camera did not settle")
    expect(camera_rig.global_position.x - player.global_position.x > 1.0, "Miyako encounter camera did not frame the doorway")
    expect(root.get_node("GameState").has_flag("reached_miyako_meeting_space"), "Miyako meeting trigger did not set its flag")
    expect(street.meeting_reached, "Miyako meeting did not latch")
    expect(player.get("_controls_locked"), "Miyako encounter did not pause movement")
    expect(world.get_node("HUD/Subtitle").text == "Miyako: Dr. Akira. Már vártam.", "Canonical Miyako line is missing")

    var advance := InputEventKey.new()
    advance.keycode = KEY_ENTER
    advance.pressed = true
    street._unhandled_input(advance)
    await frames(240)
    expect(root.get_node("GameState").has_flag("met_miyako"), "Miyako encounter did not complete")
    expect(not player.get("_controls_locked"), "Movement stayed locked after Miyako encounter")
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(18.0))) < 0.002, "Miyako court camera did not return")
    expect(world.get_node("HUD/Margin/VBox/Status").text.contains("Miyako"), "Miyako meeting status was not shown")

    await settle_at(Vector3(0, 0.2, -130))
    expect(player.is_on_floor(), "Bridge has no walkable collision over the stream")
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(-4.0))) < 0.002, "Stream bridge camera did not settle")

    await settle_at(Vector3(0, 0.2, -150))
    expect(player.is_on_floor(), "Far bank ended immediately past Shion's house")
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(5.0))) < 0.002, "Far bank camera did not settle")
    expect(player.rotation.is_zero_approx(), "Street camera changed the player root rotation")

    print("First street regression: %s" % ("PASS" if failures == 0 else "%s failures" % failures))
    quit(0 if failures == 0 else 1)
