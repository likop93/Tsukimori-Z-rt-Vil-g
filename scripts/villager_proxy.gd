extends Node3D

enum Reaction { AMBIENT, WATCH, WHISPER, HUSH }

@export var variant: int = 0
@export var idle_style: int = 0
@export var phase_offset: float = 0.0
@export var is_miyako: bool = false

var observer: Node3D
var whisper_partner: Node3D
var _rest_yaw := 0.0
var _attention := 0.0
var _time := 0.0
var reaction_phase := Reaction.AMBIENT
var _reaction_time_left := 0.0
var _body_root: Node3D
var _torso: Node3D
var _head: Node3D
var _arm_l: Node3D
var _arm_r: Node3D
var _leg_l: Node3D
var _leg_r: Node3D
var _hair_back: Node3D

func _ready() -> void:
    _rest_yaw = rotation.y
    _build_proxy()

func start_reaction(phase: int) -> void:
    if is_miyako:
        return
    reaction_phase = phase
    _reaction_time_left = 1.4 if phase == Reaction.WHISPER else 2.6

func _process(delta: float) -> void:
    _time += delta
    var t := _time + phase_offset

    if _reaction_time_left > 0.0:
        _reaction_time_left -= delta
        if _reaction_time_left <= 0.0:
            if reaction_phase == Reaction.WHISPER:
                reaction_phase = Reaction.HUSH
                _reaction_time_left = 1.5
            else:
                reaction_phase = Reaction.AMBIENT

    if _body_root == null:
        return

    var breath := sin(t * 1.25) * 0.006
    _body_root.position.y = breath
    _torso.rotation.z = sin(t * 0.72) * deg_to_rad(0.65)
    _head.rotation.x = sin(t * 0.58 + 0.8) * deg_to_rad(0.8)

    if is_miyako:
        _head.rotation.y = sin(t * 0.34) * deg_to_rad(4.0)
        _arm_l.rotation.x = sin(t * 0.55) * deg_to_rad(1.5)
        _arm_r.rotation.x = -sin(t * 0.55) * deg_to_rad(1.5)
        if _hair_back:
            _hair_back.rotation.x = sin(t * 0.82) * deg_to_rad(1.6)
        return

    match idle_style % 4:
        0:
            _head.rotation.y = sin(t * 0.45) * deg_to_rad(7.0)
            _arm_l.rotation.x = sin(t * 0.62) * deg_to_rad(2.0)
            _arm_r.rotation.x = -sin(t * 0.62) * deg_to_rad(2.0)
        1:
            _head.rotation.y = sin(t * 0.72) * deg_to_rad(10.0)
            _arm_l.rotation.x = deg_to_rad(-12.0) + sin(t * 1.25) * deg_to_rad(8.0)
            _arm_r.rotation.x = deg_to_rad(-7.0) + cos(t * 1.1) * deg_to_rad(6.0)
        2:
            _head.rotation.y = sin(t * 0.30) * deg_to_rad(18.0)
            _torso.rotation.y = sin(t * 0.30) * deg_to_rad(4.0)
            _arm_l.rotation.z = deg_to_rad(-4.0)
            _arm_r.rotation.z = deg_to_rad(4.0)
        3:
            _torso.rotation.x = deg_to_rad(3.0) + sin(t * 0.9) * deg_to_rad(1.5)
            _arm_r.rotation.x = deg_to_rad(-25.0) + sin(t * 1.35) * deg_to_rad(18.0)
            _arm_l.rotation.x = deg_to_rad(8.0) - sin(t * 1.35) * deg_to_rad(5.0)
            _leg_l.rotation.x = sin(t * 0.9) * deg_to_rad(1.0)
            _leg_r.rotation.x = -sin(t * 0.9) * deg_to_rad(1.0)

    _react_to_passersby(delta, t)

func _react_to_passersby(delta: float, t: float) -> void:
    if observer == null:
        return
    var to_player := observer.global_position - global_position
    to_player.y = 0.0
    var distance := to_player.length()
    var target_attention := clampf((11.0 - distance) / 5.0, 0.0, 1.0)
    _attention = move_toward(_attention, target_attention, delta * 1.8)
    if _attention < 0.001:
        rotation.y = _rest_yaw
        _head.rotation.z = 0.0
        return

    # Each staged pair watches, whispers, then visibly falls quiet as he passes.
    var target := to_player
    var whispering := reaction_phase == Reaction.WHISPER and whisper_partner != null
    if whispering:
        target = whisper_partner.global_position - global_position
        target.y = 0.0
    var target_yaw := atan2(-target.x, -target.z)
    if reaction_phase == Reaction.HUSH:
        target_yaw = _rest_yaw
        _head.rotation.x += deg_to_rad(11.0) * _attention
    var attentive_yaw := lerp_angle(_rest_yaw, target_yaw, _attention * (0.78 if whispering else 0.88))
    rotation.y = lerp_angle(rotation.y, attentive_yaw, 1.0 - exp(-6.0 * delta))
    _head.rotation.y += sin(t * 1.9) * deg_to_rad(5.0) * _attention
    _head.rotation.z = deg_to_rad(7.0) * _attention if whispering else 0.0
    if whispering:
        _arm_r.rotation.x = lerpf(_arm_r.rotation.x, deg_to_rad(-68.0), _attention * 0.75)

func _build_proxy() -> void:
    var skin := _material(Color(0.58, 0.48, 0.42))
    var hair := _material(Color(0.035, 0.03, 0.032))
    var cloth_palette := [
        Color(0.20, 0.24, 0.25),
        Color(0.24, 0.20, 0.18),
        Color(0.18, 0.24, 0.20),
        Color(0.25, 0.21, 0.26),
        Color(0.22, 0.22, 0.28),
        Color(0.28, 0.24, 0.18)
    ]
    var cloth_color: Color = cloth_palette[variant % cloth_palette.size()]
    if is_miyako:
        cloth_color = Color(0.30, 0.16, 0.28)
        skin = _material(Color(0.66, 0.54, 0.49))
    var cloth := _material(cloth_color)
    var dark_cloth := _material(cloth_color.darkened(0.22))
    var shoe := _material(Color(0.055, 0.045, 0.04))

    _body_root = Node3D.new()
    _body_root.name = "BodyRoot"
    add_child(_body_root)

    _box(_body_root, "Pelvis", Vector3(0, 0.91, 0), Vector3(0.34, 0.18, 0.22), dark_cloth)

    _torso = Node3D.new()
    _torso.name = "TorsoPivot"
    _torso.position = Vector3(0, 1.23, 0)
    _body_root.add_child(_torso)
    _box(_torso, "Torso", Vector3.ZERO, Vector3(0.42, 0.50, 0.24), cloth)

    _head = Node3D.new()
    _head.name = "HeadPivot"
    _head.position = Vector3(0, 1.62, 0)
    _body_root.add_child(_head)
    _sphere(_head, "Head", Vector3(0, 0.08, 0), 0.115, skin)
    _sphere(_head, "Hair", Vector3(0, 0.13, 0.015), 0.122, hair)

    if is_miyako:
        _hair_back = Node3D.new()
        _hair_back.name = "HairBackPivot"
        _hair_back.position = Vector3(0, 0.12, 0.07)
        _head.add_child(_hair_back)
        _box(_hair_back, "HairBack", Vector3(0, -0.23, 0.045), Vector3(0.22, 0.48, 0.08), hair)
    else:
        _box(_head, "HairFringe", Vector3(0, 0.08, -0.105), Vector3(0.19, 0.09, 0.045), hair)
        match variant % 3:
            0:
                _box(_head, "ShortHair", Vector3(0, -0.055, 0.07), Vector3(0.23, 0.25, 0.08), hair)
            1:
                _box(_head, "LongHair", Vector3(0, -0.15, 0.07), Vector3(0.23, 0.44, 0.08), hair)
            2:
                _sphere(_head, "HairKnot", Vector3(0, 0.15, 0.10), 0.075, hair)

    _arm_l = _limb_pivot(_body_root, "ArmL", Vector3(-0.27, 1.43, 0), Vector3(0.10, 0.47, 0.11), cloth, -0.22)
    _arm_r = _limb_pivot(_body_root, "ArmR", Vector3(0.27, 1.43, 0), Vector3(0.10, 0.47, 0.11), cloth, -0.22)

    _leg_l = _limb_pivot(_body_root, "LegL", Vector3(-0.105, 0.88, 0), Vector3(0.14, 0.72, 0.16), dark_cloth, -0.34)
    _leg_r = _limb_pivot(_body_root, "LegR", Vector3(0.105, 0.88, 0), Vector3(0.14, 0.72, 0.16), dark_cloth, -0.34)

    _box(_leg_l, "FootL", Vector3(0, -0.69, -0.055), Vector3(0.17, 0.10, 0.28), shoe)
    _box(_leg_r, "FootR", Vector3(0, -0.69, -0.055), Vector3(0.17, 0.10, 0.28), shoe)

    if is_miyako:
        _box(_body_root, "Skirt", Vector3(0, 0.78, 0), Vector3(0.43, 0.42, 0.28), cloth)
    else:
        _box(_body_root, "OuterLayer", Vector3(0, 0.90, 0.075), Vector3(0.39, 0.34, 0.10), cloth)

func _limb_pivot(parent: Node3D, name_value: String, position_value: Vector3, size: Vector3, material: Material, mesh_y: float) -> Node3D:
    var pivot := Node3D.new()
    pivot.name = name_value
    pivot.position = position_value
    parent.add_child(pivot)
    _box(pivot, name_value + "Mesh", Vector3(0, mesh_y, 0), size, material)
    return pivot

func _box(parent: Node3D, name_value: String, position_value: Vector3, size: Vector3, material: Material) -> MeshInstance3D:
    var mesh := BoxMesh.new()
    mesh.size = size
    var instance := MeshInstance3D.new()
    instance.name = name_value
    instance.position = position_value
    instance.mesh = mesh
    instance.material_override = material
    parent.add_child(instance)
    return instance

func _sphere(parent: Node3D, name_value: String, position_value: Vector3, radius: float, material: Material) -> MeshInstance3D:
    var mesh := SphereMesh.new()
    mesh.radius = radius
    mesh.height = radius * 2.0
    mesh.radial_segments = 16
    mesh.rings = 8
    var instance := MeshInstance3D.new()
    instance.name = name_value
    instance.position = position_value
    instance.mesh = mesh
    instance.material_override = material
    parent.add_child(instance)
    return instance

func _material(color: Color) -> StandardMaterial3D:
    var material := StandardMaterial3D.new()
    material.albedo_color = color
    material.roughness = 0.92
    return material
