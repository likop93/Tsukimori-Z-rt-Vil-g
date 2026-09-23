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

func hold_key(key: Key, duration_frames: int) -> void:
    var press := InputEventKey.new()
    press.keycode = key
    press.pressed = true
    Input.parse_input_event(press)
    await frames(duration_frames)
    var release := InputEventKey.new()
    release.keycode = key
    release.pressed = false
    Input.parse_input_event(release)
    await frames(240)

func run_checks() -> void:
    var main: Node = load("res://scenes/main.tscn").instantiate()
    root.add_child(main)
    world = main.get_node("MountainPath")
    street = world.get_node("FirstStreet")
    player = world.get_node("Player")
    camera_rig = player.get_node("CameraPivot")
    await frames(8)

    expect(street.get_node("Houses").get_child_count() == 15, "Expected thirteen village houses and two houses past the stream")
    expect(street.get_node("ForestHomes").get_child_count() == 3, "Expected three scattered forest houses")
    for variant in range(3):
        expect(ResourceLoader.exists("res://assets/buildings/village/kominka_%02d.glb" % variant), "Authored village house model is missing")
    expect(street.has_node("Houses/House01/AuthoredKominka") and street.has_node("Houses/House03/AuthoredKominka"), "Detailed houses did not import")
    expect(street.has_node("ForestHomes/ForestHouse01/AuthoredKominka"), "Forest house did not import its authored model")
    expect(not (street.get_node("Houses/House01/Mesh") as MeshInstance3D).visible, "Old house blockout covers the detailed model")
    expect(street.get_node("ForestTrees").get_child_count() >= 15, "Forest is missing its cedar blockouts")
    expect(street.get_node("ForestUndergrowth").get_child_count() == 44, "Forest floor details are missing")
    expect(street.has_node("ForestTrees/Cedar01/CrownTier03"), "Layered cedar silhouette is missing")
    expect(street.has_node("ForestTrees/Cedar01/TaperedBole") and street.has_node("ForestTrees/Cedar01/CrownTier03/NeedleLobe03"), "Natural cedar silhouette is missing")
    expect(ResourceLoader.exists("res://assets/environment/materials/damp_earth.png") and ResourceLoader.exists("res://assets/environment/materials/slate_roof.png"), "Painted village environment maps are missing")
    var paving_material := (street.get_node("WetPaving/Stone_00_0") as MeshInstance3D).material_override as StandardMaterial3D
    expect(paving_material != null and paving_material.albedo_texture != null, "Wet stones lost their painted surface")
    expect(street.get_node("NPCSlots").get_child_count() == 8, "Expected eight villager slots")
    for index in range(1, 5):
        expect(street.has_node("VillagerBeat%02d" % index), "Missing staged villager reaction %d" % index)
    expect(street.has_node("BridgeQuietBeat"), "Missing quiet approach to the bridge")
    expect(street.get_node("Lanterns").get_child_count() == 6, "Expected six street lanterns")
    expect(street.has_node("StreetSurface/LeftAlley"), "Left alley is missing")
    expect(street.has_node("StreetSurface/RightAlley"), "Right alley is missing")
    expect(street.has_node("StreetSurface/UpperLeftAlley"), "Upper left alley is missing")
    expect(street.has_node("StreetSurface/UpperRightAlley"), "Upper right alley is missing")
    expect(street.has_node("Houses/MiyakoAkiraHome/SharedHomeExterior"), "Miyako and Akira's shared home visual is missing")
    expect(street.has_node("Houses/MiyakoAkiraHome/SharedHomeExterior/KatsuroDoor"), "Miyako and Akira's shared entrance is missing")
    expect(street.has_node("Houses/MiyakoAkiraHome/SharedHomeExterior/LowerRoofLeft"), "Shared home lower roof detail is missing")
    expect(street.has_node("Houses/MiyakoAkiraHome/SharedHomeExterior/UpperRoofRidge"), "Shared home upper roof ridge is missing")
    expect(street.has_node("Houses/MiyakoAkiraHome/SharedHomeExterior/DoorThreshold"), "Shared home entrance step is missing")
    expect(street.has_node("Houses/MiyakoAkiraHome/SharedHomeExterior/PorchLantern"), "Shared home porch lantern is missing")
    expect(street.has_node("Houses/MiyakoAkiraHome/SharedHomeExterior/WindChime"), "Shared home wind chime is missing")
    expect(street.has_node("Houses/MiyakoAkiraHome/SharedHomeExterior/WarmEntryLight"), "Shared home animated entry light is missing")
    expect(street.has_node("Houses/MiyakoAkiraHome/SharedHomeExterior/UnderhouseSecretDoor"), "Shared home under-house detail is missing")
    expect(ResourceLoader.exists("res://assets/buildings/shared_home/tsukimori_shared_home.glb"), "Shared home GLB was not imported")
    expect(street.has_node("Houses/MiyakoAkiraHome/SharedHomeExterior/BlenderSharedHome"), "Shared home did not load its authored GLB")
    expect(street.has_node("Houses/MiyakoAkiraHome/SharedHomeExterior/Atmosphere/Rain00"), "Animated home weather is missing")
    expect(street.has_node("WetPaving/Stone_00_0") and street.has_node("WetPaving/Puddle00"), "Wet village route is missing")
    expect(street.get_node("RoadsideDetails").get_child_count() == 21, "Roadside ground details are missing")
    expect(street.has_node("Houses/ShionHome/ShionDoor"), "Shion's house by the near bank is missing")
    expect(street.has_node("Houses/House04"), "First, unnamed house past the stream is missing")
    expect(street.has_node("Stream/Water"), "Stream water is missing")
    expect(street.has_node("Stream/Bridge/CollisionShape3D"), "Walkable bridge is missing")
    expect(street.has_node("MiyakoMeeting/MiyakoMarker"), "Miyako meeting marker is missing")
    expect(street.has_node("WindDetails/HangingCloth"), "Animated hanging cloth is missing")
    expect(street.has_node("WindDetails/Petals"), "Animated petals are missing")
    expect(street.has_node("WindDetails/Plants"), "Animated plant proxies are missing")
    expect(street.has_node("AmbientMotion"), "First street ambient controller is missing")
    expect(street.get_node("Ground") is StaticBody3D, "Street ground has no static collision")
    expect(world.has_node("MountainGroundDetail/MossyStone01"), "Mountain path ground details are missing")
    expect(street.get_node("FarBankGround") is StaticBody3D, "Far bank ground has no static collision")
    var miyako_home := street.get_node("Houses/MiyakoAkiraHome") as Node3D
    var shion_home := street.get_node("Houses/ShionHome") as Node3D
    var first_far_home := street.get_node("Houses/House04") as Node3D
    var water := street.get_node("Stream/Water") as Node3D
    expect(shion_home.position.z > water.position.z and miyako_home.position.z < water.position.z, "Miyako and Shion must live on opposite banks")
    expect(first_far_home.position.z < water.position.z and miyako_home.position.z < first_far_home.position.z, "Miyako and Akira must share the farther of two houses past the bridge")
    expect(not (miyako_home.get_node("Mesh") as MeshInstance3D).visible, "Shared home blockout mesh still covers the visual prototype")
    expect(miyako_home.get_node("CollisionShape3D") is CollisionShape3D, "Shared home lost its original movement collider")
    for villager in street.get_node("NPCSlots").get_children():
        expect(villager.position.z > miyako_home.position.z + 10.0, "%s is not on Akira's approach through the village" % villager.name)

    for house in street.get_node("Houses").get_children():
        expect(house is StaticBody3D and house.has_node("CollisionShape3D"), "%s has no collision" % house.name)

    for villager in street.get_node("NPCSlots").get_children():
        expect(villager.has_node("BodyRoot"), "%s did not build a humanoid proxy" % villager.name)
        expect(villager.get("observer") == player and villager.get("whisper_partner") != null, "%s cannot react to Akira and a neighbor" % villager.name)

    expect(street.get_node("MiyakoMeeting/MiyakoMarker").has_node("BodyRoot"), "Miyako marker did not build a humanoid proxy")

    await settle_at(Vector3(0, 0.2, -38))
    expect(absf(camera_rig.rotation.y) < 0.002, "Street entry camera did not settle")
    expect(root.get_node("GameState").has_flag("entered_first_street"), "Street entry trigger did not set its flag")
    expect(not street.meeting_reached, "Miyako encounter started before reaching the house")

    await settle_at(Vector3(0, 0.2, -45))
    expect(root.get_node("GameState").has_flag("noticed_by_villagers"), "Villagers did not notice Akira")
    expect(absf(angle_difference(street.get_node("NPCSlots/Villager01").rotation.y, deg_to_rad(32.0))) > 0.1, "Villager did not turn toward Akira")
    expect(not street.meeting_reached, "Miyako appeared before Akira crossed the village")

    await settle_at(Vector3(0, 0.2, -63))
    expect(root.get_node("GameState").has_flag("heard_village_whispers"), "Second pair did not whisper")
    expect(absf(camera_rig.rotation.y) < 0.002, "Main street camera did not settle")

    await settle_at(Vector3(0, 0.2, -82))
    expect(root.get_node("GameState").has_flag("villagers_fall_silent"), "Third pair did not fall quiet")
    expect(not street.meeting_reached, "Miyako encounter started in the middle of the village")

    await settle_at(Vector3(0, 0.2, -105))
    expect(root.get_node("GameState").has_flag("last_village_whispers"), "Last pair did not react at the village edge")
    expect(absf(camera_rig.rotation.y) < 0.002, "Inner street camera did not settle")
    expect(not street.meeting_reached, "Miyako encounter started before the far edge of the village")

    await settle_at(Vector3(0, 0.2, -121))
    expect(not street.meeting_reached, "Miyako appeared before crossing the bridge")
    expect(absf(camera_rig.rotation.y) < 0.002, "Near-bank camera did not settle")

    await settle_at(Vector3(0, 0.2, -130))
    expect(root.get_node("GameState").has_flag("village_bridge_quiet"), "The bridge did not close the village sequence")
    expect(player.is_on_floor(), "Bridge has no walkable collision over the stream")
    expect(not street.meeting_reached, "Miyako appeared on the bridge")
    expect(absf(camera_rig.rotation.y) < 0.002, "Stream bridge camera did not settle")

    await settle_at(Vector3(0, 0.2, -139))
    expect(player.is_on_floor(), "First far-bank house is not reachable")
    expect(not street.meeting_reached, "Miyako appeared before the farther shared home")

    var approach_start := player.global_position
    await hold_key(KEY_W, 240)
    expect(player.global_position.z < approach_start.z - 9.0 and absf(player.global_position.x) < 0.6, "W did not lead from the first far-bank house to the shared home")
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(-20.0))) < 0.002, "Miyako encounter camera did not settle")
    var camera := camera_rig.get_node("Camera3D") as Camera3D
    var miyako := street.get_node("MiyakoMeeting/MiyakoMarker") as Node3D
    var sightline := PhysicsRayQueryParameters3D.create(camera.global_position, miyako.global_position + Vector3(0, 1.6, 0))
    sightline.exclude = [player.get_rid()]
    expect(world.get_world_3d().direct_space_state.intersect_ray(sightline).is_empty(), "Miyako is hidden by the house in the encounter shot")
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
    expect(absf(camera_rig.rotation.y) < 0.002, "Miyako court camera did not return")
    expect(world.get_node("HUD/Margin/VBox/Status").text.contains("RENDELŐ"), "Clinic directions were not shown after meeting Miyako")

    await settle_at(Vector3(0, 0.2, -158))
    expect(player.is_on_floor(), "Miyako and Akira's house is not reachable")

    await settle_at(Vector3(0, 0.2, -182))
    expect(player.is_on_floor(), "Forest road is not walkable")
    expect(absf(camera_rig.rotation.y) < 0.002, "Forest camera did not settle")
    var start_right := player.global_position
    var screen_right := Basis(Vector3.UP, camera_rig.rotation.y) * Vector3.RIGHT
    await hold_key(KEY_D, 80)
    var right_motion := player.global_position - start_right
    right_motion.y = 0.0
    expect(right_motion.normalized().distance_to(screen_right) < 0.03, "Holding D changed world direction while the camera turned")
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(-90.0))) < 0.01, "Camera did not move behind Akira when turning right")
    var start_forward := player.global_position
    var screen_forward := Basis(Vector3.UP, camera_rig.rotation.y) * Vector3.FORWARD
    await hold_key(KEY_W, 80)
    var forward_motion := player.global_position - start_forward
    forward_motion.y = 0.0
    expect(forward_motion.normalized().distance_to(screen_forward) < 0.03, "W did not move Akira toward the top of the rotated view")
    expect(absf(angle_difference(camera_rig.rotation.y, deg_to_rad(-90.0))) < 0.02, "Following the camera caused a control feedback spin")
    expect(player.rotation.is_zero_approx(), "Street camera changed the player root rotation")

    var clinic := street.get_node("Houses/MiyakoAkiraHome/Clinic") as Node3D
    expect(clinic.get_parent() == miyako_home and clinic.position.z > 3.0, "Clinic must be a bridge-side wing of the shared home")
    expect(clinic.has_node("Exterior/Building/CollisionShape3D"), "Clinic exterior has no collider")
    expect(clinic.has_node("Exterior/ClinicSideDoor"), "Clinic wing lost its separate side entrance")
    expect(clinic.has_node("Interior/Floor/CollisionShape3D"), "Clinic interior has no walkable floor")
    expect(clinic.has_node("Interior/WaitingArea") and clinic.has_node("Interior/Examination"), "Clinic rooms are missing")
    expect(clinic.has_node("Exterior/RoadsideMarker/ClinicDirectionNearBank") and clinic.has_node("Exterior/RoadsideMarker/ClinicDirectionVillage"), "Clinic street sign cannot be read in both directions")
    await settle_at((clinic.get_node("Exterior/Entrance") as Node3D).global_position + Vector3(0, 0.2, 0))
    var interact := InputEventKey.new()
    interact.keycode = KEY_E
    interact.pressed = true
    clinic._unhandled_input(interact)
    await frames(12)
    expect(root.get_node("GameState").has_flag("entered_clinic"), "Clinic does not open after meeting Miyako")
    expect(player.is_on_floor(), "Clinic entry did not land on a walkable floor")
    expect(clinic.get_node("Interior/ClinicCamera").is_in_group("camera_zones"), "Clinic camera did not activate indoors")
    await settle_at((clinic.get_node("Interior/WaitingArea") as Node3D).global_position + Vector3(0, 0.2, 0))
    clinic._unhandled_input(interact)
    expect(root.get_node("GameState").has_flag("inspected_clinic_waiting_room"), "Waiting area cannot be inspected")
    await settle_at((clinic.get_node("Interior/Examination") as Node3D).global_position + Vector3(0, 0.2, 0))
    clinic._unhandled_input(interact)
    expect(root.get_node("GameState").has_flag("inspected_clinic_exam_room"), "Examination station cannot be inspected")
    await settle_at((clinic.get_node("Interior/Entrance") as Node3D).global_position + Vector3(0, 0.2, 0))
    clinic._unhandled_input(interact)
    await frames(12)
    expect(player.global_position.distance_to((clinic.get_node("Exterior/Entrance") as Node3D).global_position) < 2.0, "Clinic exit did not return Akira to the shared home yard")
    expect(not clinic.get_node("Interior/ClinicCamera").is_in_group("camera_zones"), "Clinic camera stayed active after exit")

    print("First street regression: %s" % ("PASS" if failures == 0 else "%s failures" % failures))
    quit(0 if failures == 0 else 1)
