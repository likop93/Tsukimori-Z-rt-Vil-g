extends Node3D

const CameraZoneScript = preload("res://scripts/camera_zone.gd")
const VillagerProxyScript = preload("res://scripts/villager_proxy.gd")
const StreetAmbientScript = preload("res://scripts/street_ambient.gd")

var meeting_reached := false

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

    _static_box(self, "Ground", Vector3(0, -0.2, -27), Vector3(20, 0.4, 62), ground)

    var surfaces := _node("StreetSurface", self)
    _mesh_box(surfaces, "MainStreet", Vector3(0, 0.025, -26), Vector3(7.2, 0.08, 55), street)
    _mesh_box(surfaces, "LeftAlley", Vector3(-6, 0.03, -18), Vector3(10, 0.08, 3.2), street)
    _mesh_box(surfaces, "RightAlley", Vector3(6, 0.03, -34), Vector3(10, 0.08, 3.2), street)
    _mesh_box(surfaces, "MeetingPlaza", Vector3(0, 0.035, -51), Vector3(11.5, 0.08, 10), street)

    var houses := _node("Houses", self)
    var house_layout := [
        [Vector3(-7.1, 1.8, -8), -4.0], [Vector3(7.3, 1.8, -12), 5.0],
        [Vector3(-7.4, 1.8, -27), 6.0], [Vector3(7.0, 1.8, -29), -5.0],
        [Vector3(-7.2, 1.8, -45), -6.0], [Vector3(7.4, 1.8, -47), 4.0]
    ]
    for index in house_layout.size():
        var house := _static_box(
            houses,
            "House%02d" % (index + 1),
            house_layout[index][0],
            Vector3(4.8, 3.6, 6),
            wall,
            house_layout[index][1]
        )
        var cap := _mesh_box(house, "Roof", Vector3(0, 2.15, 0), Vector3(5.4, 0.55, 6.6), roof)
        cap.rotation.z = deg_to_rad(5.0 if index % 2 == 0 else -5.0)

    var fences := _node("Fences", self)
    _static_box(fences, "LeftFence", Vector3(-4.1, 0.575, -10), Vector3(0.18, 1.15, 11), wood)
    _static_box(fences, "RightFence", Vector3(4.1, 0.575, -23), Vector3(0.18, 1.15, 11), wood)

    var lanterns := _node("Lanterns", self)
    var lantern_positions := [
        Vector3(-3.8, 0, -5),
        Vector3(3.8, 0, -20),
        Vector3(-3.8, 0, -36),
        Vector3(3.8, 0, -50)
    ]
    for index in lantern_positions.size():
        _lantern(lanterns, index + 1, lantern_positions[index], wood, glow)

    _build_wind_details(cloth, paper, plant)

    var slots := _node("NPCSlots", self)
    var npc_positions := [
        Vector3(-2.7, 0, -11),
        Vector3(2.8, 0, -16),
        Vector3(-2.9, 0, -24),
        Vector3(2.7, 0, -31),
        Vector3(-2.5, 0, -39),
        Vector3(3.1, 0, -45)
    ]
    var npc_yaws: Array[float] = [32.0, -52.0, 122.0, -36.0, 66.0, -78.0]
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

    var meeting := _node("MiyakoMeeting", self)
    meeting.position = Vector3(0, 0, -52)
    _villager(meeting, "MiyakoMarker", Vector3(0, 0, -1.5), 3, 0, 1.4, true)

    var label := Label3D.new()
    label.name = "MiyakoLabel"
    label.position = Vector3(0, 2.15, -1.5)
    label.text = "MIYAKO — TALÁLKOZÁSI HELY"
    label.font_size = 38
    label.outline_size = 6
    label.pixel_size = 0.0025
    label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
    meeting.add_child(label)

    var trigger := _area("MiyakoMeetTrigger", Vector3(0, 1.5, 0), Vector3(9.5, 3, 7.5), meeting)
    trigger.body_entered.connect(_on_miyako_meet_trigger_body_entered)

    var entry_trigger := _area("StreetEntryTrigger", Vector3(0, 1.5, -6), Vector3(8, 3, 5), self)
    entry_trigger.body_entered.connect(_on_street_entry_trigger_body_entered)

    var zones := _node("CameraZones", self)
    _camera_zone(zones, "StreetEntry", Vector3(0, 3, -6), Vector3(18, 12, 16), 40, 10.0, Vector3(0.6, 6.1, 9.0), -29.0)
    _camera_zone(zones, "MainStreet", Vector3(0, 3, -26), Vector3(20, 12, 26), 50, -15.0, Vector3(-0.8, 6.2, 8.8), -27.0)
    _camera_zone(zones, "MiyakoCourt", Vector3(0, 3, -50), Vector3(22, 12, 18), 60, 18.0, Vector3(1.5, 5.6, 8.3), -23.0)

    var ambient := Node.new()
    ambient.name = "AmbientMotion"
    ambient.set_script(StreetAmbientScript)
    add_child(ambient)

func _build_wind_details(cloth: Material, paper: Material, plant: Material) -> void:
    var details := _node("WindDetails", self)

    var hanging := _node("HangingCloth", details)
    _cloth_panel(hanging, "Noren01", Vector3(-4.62, 2.05, -8.0), Vector3(0.06, 0.92, 1.05), cloth)
    _cloth_panel(hanging, "Noren02", Vector3(4.62, 2.12, -12.0), Vector3(0.06, 0.82, 0.92), cloth)
    _cloth_panel(hanging, "Noren03", Vector3(-4.62, 2.00, -27.0), Vector3(0.06, 1.02, 0.80), cloth)
    _cloth_panel(hanging, "Noren04", Vector3(4.62, 2.08, -47.0), Vector3(0.06, 0.88, 1.00), cloth)

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
        Vector3(1.0, 0.60, -52.0)
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
        Vector3(-4.1, 0.18, -22.0),
        Vector3(4.1, 0.18, -35.0),
        Vector3(-4.0, 0.18, -44.0),
        Vector3(4.0, 0.18, -52.0)
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

func _camera_zone(parent: Node, name_value: String, position_value: Vector3, size: Vector3, priority: int, yaw: float, offset: Vector3, pitch: float) -> void:
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
    meeting_reached = true
    GameState.set_flag("reached_miyako_meeting_space", true)
    var status := get_node_or_null("../HUD/Margin/VBox/Status") as Label
    if status:
        status.text = "ELSŐ UTCA • Miyako találkozási tere — AMBIENT PASS"

func _on_street_entry_trigger_body_entered(body: Node3D) -> void:
    if body == null or not body.is_in_group("player") or GameState.has_flag("entered_first_street"):
        return
    GameState.set_flag("entered_first_street", true)
    var status := get_node_or_null("../HUD/Margin/VBox/Status") as Label
    if status:
        status.text = "TSUKIMORI • Első utca — AMBIENT PASS 1"
