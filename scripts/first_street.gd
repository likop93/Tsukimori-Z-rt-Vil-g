extends Node3D

const CameraZoneScript = preload("res://scripts/camera_zone.gd")
const VillagerProxyScript = preload("res://scripts/villager_proxy.gd")
const StreetAmbientScript = preload("res://scripts/street_ambient.gd")

var meeting_reached := false
var _encounter_state := 0
var _encounter_player: CharacterBody3D

func _ready() -> void:
    var ground := _mat("VillageGround", Color(0.105, 0.115, 0.105))
    var street := _mat("PackedEarth", Color(0.265, 0.245, 0.205))
    var wall := _mat("HouseWall", Color(0.31, 0.235, 0.17))
    var roof := _mat("DarkRoof", Color(0.075, 0.085, 0.09))
    var wood := _mat("DarkWood", Color(0.16, 0.105, 0.07))
    var glow := _mat("LanternGlow", Color(0.87, 0.61, 0.31), Color(0.95, 0.48, 0.16))
    var cloth := _mat("HangingCloth", Color(0.42, 0.16, 0.12))
    var paper := _mat("PetalPaper", Color(0.88, 0.75, 0.77))
    var plant := _mat("VillagePlant", Color(0.11, 0.23, 0.13))
    var water := _mat("StreamWater", Color(0.075, 0.25, 0.28), Color(0.015, 0.07, 0.08))
    var bank := _mat("StreamBank", Color(0.20, 0.23, 0.20))
    var bark := _mat("CedarBark", Color(0.13, 0.085, 0.055))
    var needles := _mat("CedarNeedles", Color(0.075, 0.14, 0.105))

    # The village is crossed first. The stream marks its quiet, far edge.
    _static_box(self, "Ground", Vector3(0, -0.2, -45), Vector3(34, 0.4, 102), ground)
    _static_box(self, "FarBankGround", Vector3(0, -0.2, -152.5), Vector3(52, 0.4, 105), ground)

    var streambed := _node("Stream", self)
    _mesh_box(streambed, "Water", Vector3(0, -0.27, -98), Vector3(34, 0.08, 4), water)
    _static_box(streambed, "NearBankLeft", Vector3(-10.075, 0.33, -95.9), Vector3(13.85, 0.66, 0.26), bank)
    _static_box(streambed, "NearBankRight", Vector3(10.075, 0.33, -95.9), Vector3(13.85, 0.66, 0.26), bank)
    _static_box(streambed, "FarBankLeft", Vector3(-10.075, 0.33, -100.1), Vector3(13.85, 0.66, 0.26), bank)
    _static_box(streambed, "FarBankRight", Vector3(10.075, 0.33, -100.1), Vector3(13.85, 0.66, 0.26), bank)
    _static_box(streambed, "Bridge", Vector3(0, -0.14, -98), Vector3(6.4, 0.28, 4.8), wood)
    _static_box(streambed, "BridgeRailLeft", Vector3(-3.15, 0.42, -98), Vector3(0.12, 0.84, 4.2), wood)
    _static_box(streambed, "BridgeRailRight", Vector3(3.15, 0.42, -98), Vector3(0.12, 0.84, 4.2), wood)

    var surfaces := _node("StreetSurface", self)
    _mesh_box(surfaces, "MainStreet", Vector3(0, 0.025, -47), Vector3(8.2, 0.08, 94), street)
    _mesh_box(surfaces, "FarBankPath", Vector3(0, 0.025, -120), Vector3(7, 0.08, 40), street)
    _mesh_box(surfaces, "ForestRoad", Vector3(0, 0.025, -167), Vector3(6.4, 0.08, 54), street)
    _mesh_box(surfaces, "AkiraLane", Vector3(-5.7, 0.03, -126), Vector3(10, 0.08, 3.2), street)
    _mesh_box(surfaces, "ForestWestLane", Vector3(-8, 0.03, -156), Vector3(16, 0.08, 3.4), street)
    _mesh_box(surfaces, "ForestEastLane", Vector3(8, 0.03, -176), Vector3(16, 0.08, 3.4), street)
    _mesh_box(surfaces, "ForestDeepLane", Vector3(-8, 0.03, -190), Vector3(16, 0.08, 3.4), street)
    _mesh_box(surfaces, "LeftAlley", Vector3(-6, 0.03, -18), Vector3(10, 0.08, 3.2), street)
    _mesh_box(surfaces, "RightAlley", Vector3(6, 0.03, -34), Vector3(10, 0.08, 3.2), street)
    _mesh_box(surfaces, "UpperLeftAlley", Vector3(-6.5, 0.03, -54), Vector3(11, 0.08, 3.2), street)
    _mesh_box(surfaces, "UpperRightAlley", Vector3(6.5, 0.03, -80), Vector3(11, 0.08, 3.2), street)
    _mesh_box(surfaces, "HouseApproach", Vector3(3.8, 0.03, -89), Vector3(4.4, 0.08, 3.2), street)

    var houses := _node("Houses", self)
    var house_layout := [
        [Vector3(-7.1, 1.8, -8), -4.0], [Vector3(7.3, 1.8, -12), 5.0],
        [Vector3(-7.4, 1.8, -27), 6.0], [Vector3(7.0, 1.8, -107), -5.0],
        [Vector3(-7.2, 1.8, -45), -6.0], [Vector3(7.4, 1.8, -47), 4.0],
        [Vector3(-7.4, 1.8, -61), 5.0], [Vector3(7.2, 1.8, -70), 4.0],
        [Vector3(-7.3, 1.8, -82), -5.0], [Vector3(7.3, 1.8, -89), 6.0],
        [Vector3(-13.1, 1.8, -18), 3.0], [Vector3(13.1, 1.8, -34), -4.0],
        [Vector3(-13.1, 1.8, -54), 5.0], [Vector3(13.1, 1.8, -88), -3.0],
        [Vector3(-8.0, 1.8, -126), 3.0]
    ]
    for index in house_layout.size():
        var home_name := "House%02d" % (index + 1)
        match index:
            9:
                home_name = "KatsuroMiyakoHome"
            3:
                home_name = "ShionHome"
            13:
                home_name = "HanaHome"
            14:
                home_name = "AkiraHome"
        var house := _static_box(
            houses,
            home_name,
            house_layout[index][0],
            Vector3(4.8, 3.6, 6),
            wall,
            house_layout[index][1]
        )
        var cap := _mesh_box(house, "Roof", Vector3(0, 2.15, 0), Vector3(5.4, 0.55, 6.6), roof)
        cap.rotation.z = deg_to_rad(5.0 if index % 2 == 0 else -5.0)
        if index == 9:
            # The entrance faces the street so Miyako is visible; the porch faces Shion across the stream.
            _mesh_box(house, "KatsuroDoor", Vector3(-2.48, -0.55, -0.7), Vector3(0.08, 2.30, 1.28), wood)
            _mesh_box(house, "DoorInset", Vector3(-2.53, -0.55, -0.7), Vector3(0.035, 2.12, 1.09), roof)
            _mesh_box(house, "StreamPorch", Vector3(0, -1.68, -3.35), Vector3(2.6, 0.16, 0.75), wood)
        elif index == 3:
            _mesh_box(house, "ShionDoor", Vector3(0, -0.55, 3.08), Vector3(1.28, 2.30, 0.08), wood)
            _mesh_box(house, "DoorInset", Vector3(0, -0.55, 3.13), Vector3(1.09, 2.12, 0.035), roof)
        elif index == 14:
            _mesh_box(house, "AkiraDoor", Vector3(2.48, -0.55, -0.25), Vector3(0.08, 2.30, 1.28), wood)
            _mesh_box(house, "DoorInset", Vector3(2.53, -0.55, -0.25), Vector3(0.035, 2.12, 1.09), roof)

    _build_forest(wall, roof, bark, needles)

    var fences := _node("Fences", self)
    _static_box(fences, "LeftFence", Vector3(-4.1, 0.575, -10), Vector3(0.18, 1.15, 11), wood)
    _static_box(fences, "RightFence", Vector3(4.1, 0.575, -60), Vector3(0.18, 1.15, 11), wood)

    var lanterns := _node("Lanterns", self)
    var lantern_positions := [
        Vector3(-3.8, 0, -5),
        Vector3(3.8, 0, -25),
        Vector3(-3.8, 0, -36),
        Vector3(3.8, 0, -50),
        Vector3(-3.8, 0, -67),
        Vector3(3.8, 0, -86)
    ]
    for index in lantern_positions.size():
        _lantern(lanterns, index + 1, lantern_positions[index], wood, glow)

    _build_wind_details(cloth, paper, plant)

    var slots := _node("NPCSlots", self)
    var npc_positions := [
        Vector3(-2.8, 0, -12), Vector3(-3.1, 0, -14),
        Vector3(2.9, 0, -30), Vector3(3.2, 0, -32),
        Vector3(-2.8, 0, -50), Vector3(-3.1, 0, -52),
        Vector3(2.9, 0, -69), Vector3(3.1, 0, -71)
    ]
    var npc_yaws: Array[float] = [32.0, -52.0, 122.0, -36.0, 66.0, -78.0, 48.0, -64.0]
    for index in npc_positions.size():
        _villager(
            slots,
            "Villager%02d" % (index + 1),
            npc_positions[index],
            index,
            index % 4,
            float(index) * 0.63,
            false,
            npc_yaws[index]
        )
    var player := get_node_or_null("../Player") as Node3D
    for index in range(0, npc_positions.size(), 2):
        var first := slots.get_child(index) as Node3D
        var second := slots.get_child(index + 1) as Node3D
        first.set("observer", player)
        second.set("observer", player)
        first.set("whisper_partner", second)
        second.set("whisper_partner", first)

    var meeting := _node("MiyakoMeeting", self)
    meeting.position = Vector3(0, 0, -89)
    _villager(meeting, "MiyakoMarker", Vector3(2.9, 0, 0.8), 3, 0, 1.4, true, 48.0)

    var trigger := _area("MiyakoMeetTrigger", Vector3(0.7, 1.5, 0), Vector3(6.4, 3, 5.0), meeting)
    trigger.body_entered.connect(_on_miyako_meet_trigger_body_entered)

    var witness_trigger := _area("VillagersNoticeTrigger", Vector3(0, 1.5, -12), Vector3(8, 3, 5), self)
    witness_trigger.body_entered.connect(_on_villagers_notice_trigger_body_entered)
    var whisper_trigger := _area("VillagersWhisperTrigger", Vector3(0, 1.5, -50), Vector3(8, 3, 5), self)
    whisper_trigger.body_entered.connect(_on_villagers_whisper_trigger_body_entered)

    var entry_trigger := _area("StreetEntryTrigger", Vector3(0, 1.5, -6), Vector3(8, 3, 5), self)
    entry_trigger.body_entered.connect(_on_street_entry_trigger_body_entered)

    var zones := _node("CameraZones", self)
    _camera_zone(zones, "StreetEntry", Vector3(0, 3, -6), Vector3(18, 12, 16), 40, 10.0, Vector3(0.6, 6.1, 9.0), -29.0)
    _camera_zone(zones, "MainStreet", Vector3(0, 3, -34), Vector3(20, 12, 44), 50, -15.0, Vector3(-0.8, 6.2, 8.8), -27.0)
    _camera_zone(zones, "InnerStreet", Vector3(0, 3, -67), Vector3(22, 12, 34), 55, -8.0, Vector3(0.7, 5.9, 8.5), -25.0)
    _camera_zone(zones, "MiyakoCourt", Vector3(0, 3, -89), Vector3(19, 12, 14), 60, -12.0, Vector3(0, 5.8, 8.8), -23.0, Vector3(0.6, 0, -0.3))
    _camera_zone(zones, "StreamBridge", Vector3(0, 3, -98), Vector3(20, 12, 11), 45, -4.0, Vector3(0, 6.0, 8.8), -25.0)
    _camera_zone(zones, "VillageBeyond", Vector3(0, 3, -121), Vector3(44, 12, 42), 55, 5.0, Vector3(0.4, 6.0, 8.8), -26.0)
    _camera_zone(zones, "ForestRoad", Vector3(0, 3, -168), Vector3(52, 12, 76), 52, -6.0, Vector3(0, 6.9, 9.8), -29.0)
    _camera_zone(zones, "MiyakoFocus", Vector3(0, 3, -89), Vector3(14, 12, 12), 80, -20.0, Vector3(-1.5, 5.4, 8.8), -20.0, Vector3(1.6, 0, -0.4), false)
    (zones.get_node("MiyakoFocus") as Area3D).remove_from_group("camera_zones")

    var ambient := Node.new()
    ambient.name = "AmbientMotion"
    ambient.set_script(StreetAmbientScript)
    add_child(ambient)

func _build_forest(wall: Material, roof: Material, bark: Material, needles: Material) -> void:
    var homes := _node("ForestHomes", self)
    var outlying_homes := [
        Vector3(-16, 1.8, -157),
        Vector3(16, 1.8, -176),
        Vector3(-16, 1.8, -190)
    ]
    for index in outlying_homes.size():
        var home := _static_box(homes, "ForestHouse%02d" % (index + 1), outlying_homes[index], Vector3(4.8, 3.6, 6), wall, -4.0 if index % 2 == 0 else 5.0)
        _mesh_box(home, "Roof", Vector3(0, 2.15, 0), Vector3(5.4, 0.55, 6.6), roof)

    var trees := _node("ForestTrees", self)
    var tree_positions := [
        Vector3(-9, 0, -139), Vector3(9, 0, -141), Vector3(-21, 0, -140), Vector3(22, 0, -143),
        Vector3(-9, 0, -149), Vector3(9, 0, -151), Vector3(21, 0, -153),
        Vector3(-22, 0, -168), Vector3(-9, 0, -168), Vector3(9, 0, -165), Vector3(21, 0, -167),
        Vector3(-10, 0, -180), Vector3(-22, 0, -180), Vector3(10, 0, -185), Vector3(22, 0, -186),
        Vector3(-9, 0, -196), Vector3(9, 0, -195), Vector3(22, 0, -197), Vector3(-22, 0, -198)
    ]
    for index in tree_positions.size():
        var tree := _node("Cedar%02d" % (index + 1), trees)
        tree.position = tree_positions[index]
        _static_box(tree, "Trunk", Vector3(0, 2.4, 0), Vector3(0.62, 4.8, 0.62), bark)
        var crown_mesh := CylinderMesh.new()
        crown_mesh.top_radius = 0.2
        crown_mesh.bottom_radius = 1.5
        crown_mesh.height = 4.5
        crown_mesh.radial_segments = 8
        var crown := MeshInstance3D.new()
        crown.name = "Crown"
        crown.mesh = crown_mesh
        crown.position.y = 5.8
        crown.material_override = needles
        tree.add_child(crown)

func _build_wind_details(cloth: Material, paper: Material, plant: Material) -> void:
    var details := _node("WindDetails", self)

    var hanging := _node("HangingCloth", details)
    _cloth_panel(hanging, "Noren01", Vector3(-4.62, 2.05, -8.0), Vector3(0.06, 0.92, 1.05), cloth)
    _cloth_panel(hanging, "Noren02", Vector3(4.62, 2.12, -12.0), Vector3(0.06, 0.82, 0.92), cloth)
    _cloth_panel(hanging, "Noren03", Vector3(-4.62, 2.00, -27.0), Vector3(0.06, 1.02, 0.80), cloth)
    _cloth_panel(hanging, "Noren04", Vector3(4.62, 2.08, -47.0), Vector3(0.06, 0.88, 1.00), cloth)
    _cloth_panel(hanging, "Noren05", Vector3(-4.62, 2.02, -61.0), Vector3(0.06, 0.94, 0.95), cloth)
    _cloth_panel(hanging, "Noren06", Vector3(4.62, 2.06, -89.0), Vector3(0.06, 0.90, 0.90), cloth)

    var petals := _node("Petals", details)
    var petal_positions := [
        Vector3(-1.7, 0.42, -8.0),
        Vector3(1.3, 0.62, -12.5),
        Vector3(-0.7, 0.36, -17.0),
        Vector3(1.9, 0.76, -21.5),
        Vector3(-1.2, 0.54, -27.0),
        Vector3(0.6, 0.44, -32.0),
        Vector3(-1.8, 0.70, -37.0),
        Vector3(1.4, 0.50, -42.0),
        Vector3(-0.3, 0.82, -47.0),
        Vector3(1.0, 0.60, -52.0),
        Vector3(-1.2, 0.65, -60.0),
        Vector3(0.9, 0.48, -70.0),
        Vector3(-1.4, 0.71, -80.0),
        Vector3(1.1, 0.55, -90.0)
    ]
    for index in petal_positions.size():
        var petal := _mesh_box(
            petals,
            "Petal%02d" % (index + 1),
            petal_positions[index],
            Vector3(0.10, 0.025, 0.16),
            paper
        )
        petal.rotation = Vector3(
            deg_to_rad(float((index * 13) % 30)),
            deg_to_rad(float((index * 37) % 180)),
            deg_to_rad(float((index * 19) % 45))
        )

    var plants := _node("Plants", details)
    var plant_positions := [
        Vector3(-4.0, 0.18, -3.0),
        Vector3(4.0, 0.18, -15.0),
        Vector3(-4.1, 0.18, -25.0),
        Vector3(4.1, 0.18, -35.0),
        Vector3(-4.0, 0.18, -44.0),
        Vector3(4.0, 0.18, -52.0),
        Vector3(-4.1, 0.18, -63.0),
        Vector3(4.1, 0.18, -74.0),
        Vector3(-4.0, 0.18, -85.0),
        Vector3(4.0, 0.18, -94.0)
    ]
    for index in plant_positions.size():
        var cluster := Node3D.new()
        cluster.name = "Plant%02d" % (index + 1)
        cluster.position = plant_positions[index]
        plants.add_child(cluster)
        _mesh_box(cluster, "LeafA", Vector3(-0.08, 0.18, 0), Vector3(0.08, 0.36, 0.06), plant)
        _mesh_box(cluster, "LeafB", Vector3(0.08, 0.16, 0.02), Vector3(0.08, 0.32, 0.06), plant)
        cluster.get_node("LeafA").rotation.z = deg_to_rad(-11.0)
        cluster.get_node("LeafB").rotation.z = deg_to_rad(13.0)

func _node(name_value: String, parent: Node) -> Node3D:
    var result := Node3D.new()
    result.name = name_value
    parent.add_child(result)
    return result

func _mat(name_value: String, color: Color, emission := Color(0, 0, 0, 1)) -> StandardMaterial3D:
    var result := StandardMaterial3D.new()
    result.resource_name = name_value
    result.albedo_color = color
    result.roughness = 0.92
    if emission != Color(0, 0, 0, 1):
        result.emission_enabled = true
        result.emission = emission
        result.emission_energy_multiplier = 1.3
    return result

func _mesh_box(parent: Node, name_value: String, position_value: Vector3, size: Vector3, material: Material) -> MeshInstance3D:
    var resource := BoxMesh.new()
    resource.size = size
    var result := MeshInstance3D.new()
    result.name = name_value
    result.position = position_value
    result.mesh = resource
    result.material_override = material
    parent.add_child(result)
    return result

func _cloth_panel(parent: Node, name_value: String, position_value: Vector3, size: Vector3, material: Material) -> void:
    var pivot := Node3D.new()
    pivot.name = name_value
    pivot.position = position_value
    parent.add_child(pivot)
    _mesh_box(pivot, "Cloth", Vector3(0, -size.y * 0.45, 0), size, material)

func _static_box(parent: Node, name_value: String, position_value: Vector3, size: Vector3, material: Material, yaw := 0.0) -> StaticBody3D:
    var result := StaticBody3D.new()
    result.name = name_value
    result.position = position_value
    result.rotation.y = deg_to_rad(yaw)
    parent.add_child(result)
    _mesh_box(result, "Mesh", Vector3.ZERO, size, material)
    var shape := BoxShape3D.new()
    shape.size = size
    var collision := CollisionShape3D.new()
    collision.name = "CollisionShape3D"
    collision.shape = shape
    result.add_child(collision)
    return result

func _area(name_value: String, position_value: Vector3, size: Vector3, parent: Node) -> Area3D:
    var result := Area3D.new()
    result.name = name_value
    result.position = position_value
    result.collision_layer = 0
    result.collision_mask = 1
    result.monitorable = false
    parent.add_child(result)
    var shape := BoxShape3D.new()
    shape.size = size
    var collision := CollisionShape3D.new()
    collision.name = "CollisionShape3D"
    collision.shape = shape
    result.add_child(collision)
    return result

func _camera_zone(parent: Node, name_value: String, position_value: Vector3, size: Vector3, priority: int, yaw: float, offset: Vector3, pitch: float, focus_offset: Vector3 = Vector3.ZERO, follow_facing: bool = true) -> void:
    var zone := Area3D.new()
    zone.name = name_value
    zone.position = position_value
    zone.collision_layer = 0
    zone.collision_mask = 1
    zone.monitorable = false
    zone.set_script(CameraZoneScript)
    zone.set("camera_priority", priority)
    zone.set("yaw_degrees", yaw)
    zone.set("camera_offset", offset)
    zone.set("pitch_degrees", pitch)
    zone.set("focus_offset", focus_offset)
    zone.set("follow_facing", follow_facing)
    parent.add_child(zone)
    var shape := BoxShape3D.new()
    shape.size = size
    var collision := CollisionShape3D.new()
    collision.name = "CollisionShape3D"
    collision.shape = shape
    zone.add_child(collision)

func _lantern(parent: Node, index: int, position_value: Vector3, wood: Material, glow: Material) -> void:
    var root := _node("Lantern%02d" % index, parent)
    root.position = position_value

    var post_resource := CylinderMesh.new()
    post_resource.top_radius = 0.07
    post_resource.bottom_radius = 0.10
    post_resource.height = 2.8
    post_resource.radial_segments = 8

    var post := MeshInstance3D.new()
    post.name = "Post"
    post.position.y = 1.4
    post.mesh = post_resource
    post.material_override = wood
    root.add_child(post)

    _mesh_box(root, "Lamp", Vector3(0, 2.65, 0), Vector3(0.42, 0.58, 0.42), glow)

    var light := OmniLight3D.new()
    light.name = "Light"
    light.position.y = 2.6
    light.light_color = Color(1.0, 0.58, 0.30)
    light.light_energy = 1.4
    light.omni_range = 5.0
    root.add_child(light)

func _villager(parent: Node, name_value: String, position_value: Vector3, variant: int, idle_style: int, phase: float, miyako: bool, yaw_degrees: float = 0.0) -> void:
    var result := Node3D.new()
    result.name = name_value
    result.position = position_value
    result.rotation.y = deg_to_rad(yaw_degrees)
    result.set_script(VillagerProxyScript)
    result.set("variant", variant)
    result.set("idle_style", idle_style)
    result.set("phase_offset", phase)
    result.set("is_miyako", miyako)
    parent.add_child(result)

func _on_miyako_meet_trigger_body_entered(body: Node3D) -> void:
    if meeting_reached or body == null or not body.is_in_group("player"):
        return
    _encounter_player = body as CharacterBody3D
    if _encounter_player == null:
        return
    meeting_reached = true
    GameState.set_flag("reached_miyako_meeting_space", true)
    _encounter_state = 1
    _encounter_player.call("set_controls_locked", true)
    (get_node("CameraZones/MiyakoFocus") as Area3D).add_to_group("camera_zones")

    var miyako := get_node("MiyakoMeeting/MiyakoMarker") as Node3D
    var direction := _encounter_player.global_position - miyako.global_position
    direction.y = 0.0
    if direction.length() > 0.01:
        var turn := create_tween()
        turn.tween_property(miyako, "rotation:y", atan2(-direction.x, -direction.z), 0.72).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

    var beat := create_tween()
    beat.tween_interval(0.85)
    beat.tween_callback(_show_miyako_line)

func _show_miyako_line() -> void:
    if _encounter_state != 1:
        return
    _encounter_state = 2
    var status := get_node_or_null("../HUD/Margin/VBox/Status") as Label
    if status:
        status.text = "Miyako • Enter / Space: tovább"
    var subtitle := get_node_or_null("../HUD/Subtitle") as Label
    if subtitle:
        subtitle.text = "Miyako: Dr. Akira. Már vártam."
        subtitle.modulate.a = 0.0
        create_tween().tween_property(subtitle, "modulate:a", 1.0, 0.24)

func _unhandled_input(event: InputEvent) -> void:
    if _encounter_state != 2 or not event is InputEventKey:
        return
    var key := event as InputEventKey
    if key.pressed and not key.echo and key.keycode in [KEY_ENTER, KEY_KP_ENTER, KEY_SPACE]:
        _complete_miyako_encounter()

func _complete_miyako_encounter() -> void:
    _encounter_state = 3
    GameState.set_flag("met_miyako", true)
    (get_node("CameraZones/MiyakoFocus") as Area3D).remove_from_group("camera_zones")
    _encounter_player.call("set_controls_locked", false)
    var subtitle := get_node_or_null("../HUD/Subtitle") as Label
    if subtitle:
        create_tween().tween_property(subtitle, "modulate:a", 0.0, 0.22)
    var status := get_node_or_null("../HUD/Margin/VBox/Status") as Label
    if status:
        status.text = "ELSŐ UTCA • Miyako első találkozása"

func _on_street_entry_trigger_body_entered(body: Node3D) -> void:
    if body == null or not body.is_in_group("player") or GameState.has_flag("entered_first_street"):
        return
    GameState.set_flag("entered_first_street", true)
    var status := get_node_or_null("../HUD/Margin/VBox/Status") as Label
    if status:
        status.text = "TSUKIMORI • Első utca — AMBIENT PASS 1"

func _on_villagers_notice_trigger_body_entered(body: Node3D) -> void:
    if body == null or not body.is_in_group("player") or GameState.has_flag("noticed_by_villagers"):
        return
    GameState.set_flag("noticed_by_villagers", true)
    get_parent().call("_show_subtitle", "Az utcán minden tekintet Akirát követi.", 2.2)

func _on_villagers_whisper_trigger_body_entered(body: Node3D) -> void:
    if body == null or not body.is_in_group("player") or GameState.has_flag("heard_village_whispers"):
        return
    GameState.set_flag("heard_village_whispers", true)
    get_parent().call("_show_subtitle", "Két falusi összenéz, majd halkan összesúg.", 2.2)
