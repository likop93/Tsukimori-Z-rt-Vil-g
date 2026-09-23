extends Node3D

# The exterior is a small wing of Miyako and Akira's home. The open-roof
# interior sits apart from the street for the existing three-quarter camera.
const INTERIOR_OFFSET := Vector3(112.0, 0.0, 0.0)
const ENTER_OFFSET := Vector3(0.0, 0.2, 2.85)
const EXIT_OFFSET := Vector3(-3.45, 0.2, 0.0)

var _world: Node3D
var _player: CharacterBody3D
var _inside := false
var _prompt := ""
var _camera_zone: Area3D

func _ready() -> void:
    _world = get_node("../../../..") as Node3D
    _player = _world.get_node("Player") as CharacterBody3D
    _build_exterior()
    _build_interior()

func _process(_delta: float) -> void:
    if not is_instance_valid(_player):
        return
    var next_prompt := ""
    if _inside:
        if _near("Interior/Entrance", 2.1):
            next_prompt = "RENDELŐ • E: vissza a ház udvarára"
        elif _near("Interior/Examination", 2.25):
            next_prompt = "RENDELŐ • E: vizsgálótér megtekintése"
        elif _near("Interior/WaitingArea", 2.0):
            next_prompt = "RENDELŐ • E: váró megtekintése"
    elif _near("Exterior/Entrance", 2.4) and GameState.has_flag("met_miyako"):
        next_prompt = "RENDELŐ • E: belépés"
    if next_prompt != _prompt:
        _prompt = next_prompt
        var status := _world.get_node_or_null("HUD/Margin/VBox/Status") as Label
        if status and (next_prompt != "" or status.text.begins_with("RENDELŐ")):
            status.text = next_prompt if next_prompt != "" else ("RENDELŐ • váró és vizsgáló" if _inside else "KÖZÖS HÁZ • rendelő a híd felőli oldalon")

func _unhandled_input(event: InputEvent) -> void:
    if not event is InputEventKey:
        return
    var key := event as InputEventKey
    if not key.pressed or key.echo or key.keycode != KEY_E or not is_instance_valid(_player):
        return
    if _inside:
        if _near("Interior/Entrance", 2.1):
            _leave_clinic()
        elif _near("Interior/Examination", 2.25):
            GameState.set_flag("inspected_clinic_exam_room")
            _world.call("_show_subtitle", "A vizsgáló készen áll. Az első páciensek még váratnak magukra.", 2.6)
        elif _near("Interior/WaitingArea", 2.0):
            GameState.set_flag("inspected_clinic_waiting_room")
            _world.call("_show_subtitle", "A váróban néhány üres szék áll. Odakint elhalkul a falu.", 2.6)
    elif GameState.has_flag("met_miyako") and _near("Exterior/Entrance", 2.4):
        _enter_clinic()

func _enter_clinic() -> void:
    _inside = true
    GameState.set_flag("entered_clinic")
    _player.velocity = Vector3.ZERO
    _player.global_position = (get_node("Interior") as Node3D).to_global(ENTER_OFFSET)
    _snap_camera()
    _camera_zone.add_to_group("camera_zones")
    _prompt = ""
    _world.call("_show_subtitle", "A rendelőben a váró és a vizsgáló várja Akirát.", 2.5)

func _leave_clinic() -> void:
    _inside = false
    _camera_zone.remove_from_group("camera_zones")
    _player.velocity = Vector3.ZERO
    _player.global_position = (get_node("Exterior") as Node3D).to_global(EXIT_OFFSET)
    _snap_camera()
    _prompt = ""

func _snap_camera() -> void:
    var pivot := _player.get_node("CameraPivot") as Node3D
    pivot.global_position = _player.global_position + Vector3(0, 1.0, 0)

func _near(node_path: String, radius: float) -> bool:
    var anchor := get_node(node_path) as Node3D
    var distance := _player.global_position - anchor.global_position
    distance.y = 0.0
    return distance.length() < radius

func _build_exterior() -> void:
    var root := _node("Exterior", self, Vector3.ZERO)
    var wall := _mat(Color(0.31, 0.30, 0.27))
    var timber := _mat(Color(0.13, 0.09, 0.072))
    var roof := _mat(Color(0.074, 0.085, 0.105))
    var stone := _mat(Color(0.20, 0.22, 0.22))
    var paper := _mat(Color(0.60, 0.45, 0.30), Color(0.23, 0.105, 0.038))
    _solid(root, "ClinicYard", Vector3(-0.5, -0.17, 0.2), Vector3(7.8, 0.34, 6.7), stone)
    _solid(root, "Building", Vector3(0, 1.4, 0), Vector3(3.9, 2.8, 5.2), wall)
    _mesh(root, "Foundation", Vector3(0, 0.15, 0), Vector3(4.05, 0.30, 5.3), stone)
    for side in [-1.0, 1.0]:
        var slope := _mesh(root, "RoofLeft" if side < 0 else "RoofRight", Vector3(side * 1.04, 3.08, 0), Vector3(2.48, 0.22, 5.75), roof)
        slope.rotation.z = deg_to_rad(-23.0 * side)
    _mesh(root, "RoofRidge", Vector3(0, 3.55, 0), Vector3(0.22, 0.18, 5.75), timber)
    for z in [-2.17, 2.17]:
        _mesh(root, "SideFrame%02d" % (0 if z < 0 else 1), Vector3(-2.03, 1.4, z), Vector3(0.16, 2.7, 0.15), timber)
    _mesh(root, "SideLintel", Vector3(-2.04, 2.6, 0), Vector3(0.16, 0.15, 4.55), timber)
    _mesh(root, "ClinicSideDoor", Vector3(-2.05, 1.06, 0), Vector3(0.10, 2.12, 1.22), timber)
    _mesh(root, "DoorSill", Vector3(-2.29, 0.12, 0), Vector3(0.53, 0.24, 1.5), stone)
    for index in range(2):
        var z := -1.72 if index == 0 else 1.72
        _mesh(root, "PaperWindow%02d" % index, Vector3(-2.05, 1.67, z), Vector3(0.045, 0.83, 0.65), paper)
        _mesh(root, "WindowCross%02d" % index, Vector3(-2.08, 1.67, z), Vector3(0.06, 0.07, 0.69), timber)
    var sign := Label3D.new()
    sign.name = "ClinicSign"
    sign.text = "診療所  •  RENDELŐ"
    sign.position = Vector3(-2.12, 2.49, 0)
    sign.rotation.y = -PI * 0.5
    sign.font_size = 40
    sign.pixel_size = 0.005
    sign.modulate = Color(0.83, 0.78, 0.67)
    root.add_child(sign)
    _node("Entrance", root, Vector3(-3.4, 0, 0))
    _mesh(root, "LaneToStreet", Vector3(-5.25, 0.025, 0), Vector3(4.6, 0.05, 1.8), stone)
    for index in range(3):
        _mesh(root, "PathStone%02d" % index, Vector3(-3.4 - float(index) * 1.55, 0.065, 0), Vector3(0.92, 0.035, 1.15), stone)

    # The home and clinic share a roofline; the separate side door is marked at the road.
    var marker := _node("RoadsideMarker", root, Vector3(-3.8, 0, 2.0))
    var lantern_glow := _mat(Color(0.75, 0.47, 0.21), Color(0.48, 0.20, 0.055))
    _mesh(marker, "Post", Vector3(0, 1.35, 0), Vector3(0.15, 2.7, 0.15), timber)
    _mesh(marker, "SignBoard", Vector3(0, 2.48, 0), Vector3(2.8, 0.83, 0.14), timber)
    _mesh(marker, "Lantern", Vector3(0, 3.19, 0), Vector3(0.52, 0.58, 0.52), lantern_glow)
    for side in [-1, 1]:
        var direction_sign := Label3D.new()
        direction_sign.name = "ClinicDirectionNearBank" if side > 0 else "ClinicDirectionVillage"
        direction_sign.text = "RENDELŐ →" if side > 0 else "← RENDELŐ"
        direction_sign.position = Vector3(0, 2.48, float(side) * 0.085)
        direction_sign.rotation.y = 0.0 if side > 0 else PI
        direction_sign.font_size = 64
        direction_sign.pixel_size = 0.006
        direction_sign.modulate = Color(0.98, 0.84, 0.60)
        marker.add_child(direction_sign)
    var marker_light := OmniLight3D.new()
    marker_light.name = "RoadsideLight"
    marker_light.position = Vector3(0, 3.15, 0)
    marker_light.light_color = Color(1.0, 0.62, 0.33)
    marker_light.light_energy = 1.2
    marker_light.omni_range = 7.5
    marker.add_child(marker_light)
    var lamp := OmniLight3D.new()
    lamp.name = "ClinicLamp"
    lamp.position = Vector3(-2.45, 2.3, -0.9)
    lamp.light_color = Color(1.0, 0.67, 0.40)
    lamp.light_energy = 0.7
    lamp.omni_range = 4.5
    root.add_child(lamp)

func _build_interior() -> void:
    var room := _node("Interior", self, INTERIOR_OFFSET)
    var floor_mat := _mat(Color(0.22, 0.19, 0.16))
    var wood := _mat(Color(0.15, 0.10, 0.075))
    var paper := _mat(Color(0.47, 0.40, 0.31))
    var linen := _mat(Color(0.53, 0.51, 0.44))
    var amber := _mat(Color(0.62, 0.42, 0.22), Color(0.30, 0.14, 0.045))
    _solid(room, "Floor", Vector3(0, -0.16, 0), Vector3(11.8, 0.32, 9.8), floor_mat)
    _solid(room, "BackWall", Vector3(0, 1.6, -4.9), Vector3(11.8, 3.2, 0.22), paper)
    _solid(room, "WestWall", Vector3(-5.9, 1.6, 0), Vector3(0.22, 3.2, 9.8), paper)
    _solid(room, "EastWall", Vector3(5.9, 1.6, 0), Vector3(0.22, 3.2, 9.8), paper)
    # A low front cutaway keeps Akira in view while preserving the room boundary.
    _solid(room, "EntranceWallLeft", Vector3(-3.35, 0.42, 4.9), Vector3(5.1, 0.84, 0.22), paper)
    _solid(room, "EntranceWallRight", Vector3(3.35, 0.42, 4.9), Vector3(5.1, 0.84, 0.22), paper)
    _solid(room, "FrontSlidingDoor", Vector3(0, 0.42, 4.9), Vector3(1.6, 0.84, 0.22), wood)
    _mesh(room, "FrontLintel", Vector3(0, 2.5, 4.9), Vector3(1.65, 0.16, 0.20), wood)
    _mesh(room, "RoomDivider", Vector3(-0.4, 1.5, 0.0), Vector3(0.13, 3.0, 4.8), wood)
    _mesh(room, "PaperScreen", Vector3(-0.4, 1.55, -1.85), Vector3(0.045, 2.70, 1.85), paper)
    _mesh(room, "SlidingScreen", Vector3(-0.4, 1.55, 1.45), Vector3(0.045, 2.70, 1.7), paper)

    var waiting := _node("WaitingArea", room, Vector3(-3.1, 0, 1.6))
    for index in range(2):
        var z := -0.65 if index == 0 else 0.7
        _mesh(waiting, "WaitingBench%02d" % index, Vector3(-0.5, 0.48, z), Vector3(1.55, 0.18, 0.55), wood)
        _mesh(waiting, "BenchBack%02d" % index, Vector3(-1.18, 0.83, z), Vector3(0.12, 0.76, 0.55), wood)
    _mesh(waiting, "LowTable", Vector3(1.16, 0.37, 0), Vector3(0.75, 0.16, 1.05), wood)
    var exam := _node("Examination", room, Vector3(2.5, 0, -1.6))
    _mesh(exam, "ExaminationBed", Vector3(0, 0.62, 0), Vector3(1.25, 0.23, 2.15), linen)
    _mesh(exam, "BedFrame", Vector3(0, 0.38, 0), Vector3(1.32, 0.24, 2.23), wood)
    _mesh(exam, "MedicineCabinet", Vector3(2.45, 1.05, -1.35), Vector3(0.55, 2.10, 1.42), wood)
    _mesh(exam, "InstrumentTray", Vector3(-1.35, 0.87, -1.26), Vector3(0.57, 0.08, 0.66), linen)
    _mesh(exam, "NotesDesk", Vector3(-1.55, 0.60, 1.70), Vector3(1.05, 0.15, 0.78), wood)
    _mesh(exam, "Notes", Vector3(-1.55, 0.70, 1.70), Vector3(0.55, 0.035, 0.38), linen)
    _node("Entrance", room, Vector3(0, 0, 3.92))
    _mesh(room, "HangingLamp", Vector3(0, 2.96, -0.2), Vector3(0.38, 0.12, 0.55), amber)
    var light := OmniLight3D.new()
    light.name = "InteriorLight"
    light.position = Vector3(0, 2.62, -0.3)
    light.light_color = Color(1.0, 0.72, 0.47)
    light.light_energy = 1.15
    light.omni_range = 10.0
    room.add_child(light)

    _camera_zone = Area3D.new()
    _camera_zone.name = "ClinicCamera"
    _camera_zone.position = Vector3(0, 2.0, 0)
    _camera_zone.collision_layer = 0
    _camera_zone.collision_mask = 1
    _camera_zone.monitorable = false
    _camera_zone.set_script(preload("res://scripts/camera_zone.gd"))
    _camera_zone.set("camera_priority", 110)
    _camera_zone.set("camera_offset", Vector3(0, 8.1, 8.9))
    _camera_zone.set("pitch_degrees", -38.0)
    room.add_child(_camera_zone)
    var zone_shape := BoxShape3D.new()
    zone_shape.size = Vector3(14, 8, 12)
    var zone_collision := CollisionShape3D.new()
    zone_collision.name = "CollisionShape3D"
    zone_collision.shape = zone_shape
    _camera_zone.add_child(zone_collision)
    _camera_zone.remove_from_group("camera_zones")

func _node(name_value: String, parent: Node, position_value: Vector3) -> Node3D:
    var result := Node3D.new()
    result.name = name_value
    result.position = position_value
    parent.add_child(result)
    return result

func _mat(color: Color, emission: Color = Color.BLACK) -> StandardMaterial3D:
    var material := StandardMaterial3D.new()
    material.albedo_color = color
    material.roughness = 0.84
    if emission != Color.BLACK:
        material.emission_enabled = true
        material.emission = emission
    return material

func _mesh(parent: Node, name_value: String, position_value: Vector3, size: Vector3, material: Material) -> MeshInstance3D:
    var result := MeshInstance3D.new()
    result.name = name_value
    result.position = position_value
    var mesh := BoxMesh.new()
    mesh.size = size
    result.mesh = mesh
    result.material_override = material
    parent.add_child(result)
    return result

func _solid(parent: Node, name_value: String, position_value: Vector3, size: Vector3, material: Material) -> StaticBody3D:
    var result := StaticBody3D.new()
    result.name = name_value
    result.position = position_value
    parent.add_child(result)
    _mesh(result, "Mesh", Vector3.ZERO, size, material)
    var shape := BoxShape3D.new()
    shape.size = size
    var collider := CollisionShape3D.new()
    collider.name = "CollisionShape3D"
    collider.shape = shape
    result.add_child(collider)
    return result
