extends Node3D

const CameraZoneScript = preload("res://scripts/camera_zone.gd")

var meeting_reached := false

func _ready() -> void:
    var ground := _mat("VillageGround", Color(0.105, 0.115, 0.105))
    var street := _mat("PackedEarth", Color(0.265, 0.245, 0.205))
    var wall := _mat("HouseWall", Color(0.31, 0.235, 0.17))
    var roof := _mat("DarkRoof", Color(0.075, 0.085, 0.09))
    var wood := _mat("DarkWood", Color(0.16, 0.105, 0.07))
    var glow := _mat("LanternGlow", Color(0.87, 0.61, 0.31), Color(0.95, 0.48, 0.16))
    var villager := _mat("VillagerProxy", Color(0.26, 0.28, 0.30))
    var miyako := _mat("MiyakoProxy", Color(0.36, 0.22, 0.34))

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
        var house := _static_box(houses, "House%02d" % (index + 1), house_layout[index][0], Vector3(4.8, 3.6, 6), wall, house_layout[index][1])
        var cap := _mesh_box(house, "Roof", Vector3(0, 2.15, 0), Vector3(5.4, 0.55, 6.6), roof)
        cap.rotation.z = deg_to_rad(5.0 if index % 2 == 0 else -5.0)

    var fences := _node("Fences", self)
    _static_box(fences, "LeftFence", Vector3(-4.1, 0.575, -10), Vector3(0.18, 1.15, 11), wood)
    _static_box(fences, "RightFence", Vector3(4.1, 0.575, -23), Vector3(0.18, 1.15, 11), wood)

    var lanterns := _node("Lanterns", self)
    var lantern_positions := [Vector3(-3.8, 0, -5), Vector3(3.8, 0, -20), Vector3(-3.8, 0, -36), Vector3(3.8, 0, -50)]
    for index in lantern_positions.size():
        _lantern(lanterns, index + 1, lantern_positions[index], wood, glow)

    var slots := _node("NPCSlots", self)
    var npc_positions := [Vector3(-2.7, 0.84, -11), Vector3(2.8, 0.84, -16), Vector3(-2.9, 0.84, -24), Vector3(2.7, 0.84, -31), Vector3(-2.5, 0.84, -39), Vector3(3.1, 0.84, -45)]
    for index in npc_positions.size():
        _npc(slots, "Villager%02d" % (index + 1), npc_positions[index], villager)

    var meeting := _node("MiyakoMeeting", self)
    meeting.position = Vector3(0, 0, -52)
    _npc(meeting, "MiyakoMarker", Vector3(0, 0.84, -1.5), miyako)
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

func _npc(parent: Node, name_value: String, position_value: Vector3, material: Material) -> void:
    var resource := CapsuleMesh.new()
    resource.radius = 0.28
    resource.height = 1.68
    resource.radial_segments = 12
    resource.rings = 6
    var result := MeshInstance3D.new()
    result.name = name_value
    result.position = position_value
    result.mesh = resource
    result.material_override = material
    parent.add_child(result)

func _on_miyako_meet_trigger_body_entered(body: Node3D) -> void:
    if meeting_reached or body == null or not body.is_in_group("player"):
        return
    meeting_reached = true
    GameState.set_flag("reached_miyako_meeting_space", true)
    var status := get_node_or_null("../HUD/Margin/VBox/Status") as Label
    if status:
        status.text = "ELSŐ UTCA • Miyako találkozási tere — BLOCKOUT"

func _on_street_entry_trigger_body_entered(body: Node3D) -> void:
    if body == null or not body.is_in_group("player") or GameState.has_flag("entered_first_street"):
        return
    GameState.set_flag("entered_first_street", true)
    var status := get_node_or_null("../HUD/Margin/VBox/Status") as Label
    if status:
        status.text = "TSUKIMORI • Első utca — BLOCKOUT 1.0"
