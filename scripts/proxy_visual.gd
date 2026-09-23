extends Node3D

@export_file("*.glb") var proxy_scene_path: String = "res://assets/characters/akira/proxy/akira_proxy.glb"
@export var walk_reference_speed: float = 2.8
@export var locomotion_blend: float = 0.18
@export var body_lean_degrees: float = 2.2

@onready var motion_layer: Node3D = $MotionLayer
@onready var placeholder_body: MeshInstance3D = $MotionLayer/PlaceholderBody

var animation_player: AnimationPlayer
var proxy_instance: Node
var _last_animation := ""
var _was_moving := false
var _transition_until_msec := 0
var _one_shot_until_msec := 0
var _one_shot_token := ""

var _fallback_active := false
var _fallback_phase := 0.0
var _fallback_root: Node3D
var _fallback_torso: Node3D
var _fallback_head: Node3D
var _fallback_arm_l: Node3D
var _fallback_arm_r: Node3D
var _fallback_leg_l: Node3D
var _fallback_leg_r: Node3D
var _fallback_knee_l: Node3D
var _fallback_knee_r: Node3D
var _fallback_coat_l: Node3D
var _fallback_coat_r: Node3D
var _fallback_coat_back: Node3D

func _ready() -> void:
    if not ResourceLoader.exists(proxy_scene_path):
        _build_procedural_fallback()
        return

    var packed := load(proxy_scene_path) as PackedScene
    if packed == null:
        push_warning("Akira proxy GLB exists but could not be loaded: %s" % proxy_scene_path)
        _build_procedural_fallback()
        return

    proxy_instance = packed.instantiate()
    proxy_instance.name = "AkiraProxy"
    motion_layer.add_child(proxy_instance)
    placeholder_body.visible = false
    animation_player = _find_animation_player(proxy_instance)
    _play_token("idle", true, locomotion_blend, 1.0)

func _process(delta: float) -> void:
    var player := get_parent() as CharacterBody3D
    if player == null:
        return

    _update_body_lean(player, delta)

    var speed := Vector2(player.velocity.x, player.velocity.z).length()

    if _fallback_active:
        _animate_fallback(delta, speed)
        return

    if animation_player == null:
        return

    var now := Time.get_ticks_msec()
    if now < _one_shot_until_msec:
        return
    elif not _one_shot_token.is_empty():
        _one_shot_token = ""
        _last_animation = ""

    var moving := speed > 0.16

    if moving and not _was_moving:
        if _has_token("walkstart"):
            _play_token("walkstart", false, 0.10, 1.0)
            _transition_until_msec = now + 260
        else:
            _transition_until_msec = now
    elif not moving and _was_moving:
        if _has_token("walkstop"):
            _play_token("walkstop", false, 0.10, 1.0)
            _transition_until_msec = now + 300
        else:
            _transition_until_msec = now

    if moving:
        if now >= _transition_until_msec:
            var rate := clampf(speed / maxf(walk_reference_speed, 0.1), 0.82, 1.52)
            _play_token("walk", true, locomotion_blend, rate)
        else:
            animation_player.speed_scale = 1.0
    elif now >= _transition_until_msec:
        _play_token("idle", true, locomotion_blend, 1.0)

    _was_moving = moving

func play_gate_react() -> void:
    if _fallback_active:
        var tween := create_tween()
        tween.tween_property(_fallback_head, "rotation:y", deg_to_rad(12.0), 0.18)
        tween.tween_property(_fallback_head, "rotation:y", deg_to_rad(-8.0), 0.26)
        tween.tween_property(_fallback_head, "rotation:y", 0.0, 0.30)
        return
    _play_one_shot("gatereact", 0.95)

func play_lookout_react() -> void:
    if _fallback_active:
        var tween := create_tween()
        tween.tween_property(_fallback_head, "rotation:y", deg_to_rad(-9.0), 0.35)
        tween.tween_interval(0.35)
        tween.tween_property(_fallback_head, "rotation:y", 0.0, 0.45)
        return
    _play_one_shot("lookout", 1.15)

func _play_one_shot(token: String, fallback_seconds: float) -> void:
    if animation_player == null or not _has_token(token):
        return

    var wanted := _find_matching(token)
    var duration := fallback_seconds
    var animation := animation_player.get_animation(wanted)
    if animation != null:
        duration = maxf(animation.length, 0.2)

    _one_shot_token = token
    _one_shot_until_msec = Time.get_ticks_msec() + int(duration * 1000.0)
    _play_token(token, false, 0.12, 1.0)

func _update_body_lean(player: CharacterBody3D, delta: float) -> void:
    var horizontal_speed := Vector2(player.velocity.x, player.velocity.z).length()
    var configured_speed = player.get("move_speed")
    var max_speed := 4.2
    if configured_speed != null:
        max_speed = float(configured_speed)
    var speed_ratio := clampf(horizontal_speed / maxf(max_speed, 0.1), 0.0, 1.0)
    var target_pitch := deg_to_rad(-body_lean_degrees) * speed_ratio

    var local_velocity := global_basis.inverse() * Vector3(player.velocity.x, 0.0, player.velocity.z)
    var target_roll := clampf(-local_velocity.x * 0.012, deg_to_rad(-1.8), deg_to_rad(1.8))

    var weight := 1.0 - exp(-7.0 * delta)
    motion_layer.rotation.x = lerp_angle(motion_layer.rotation.x, target_pitch, weight)
    motion_layer.rotation.z = lerp_angle(motion_layer.rotation.z, target_roll, weight)

func _build_procedural_fallback() -> void:
    _fallback_active = true
    placeholder_body.visible = false

    var skin := _fallback_material(Color(0.46, 0.43, 0.42))
    var cloth := _fallback_material(Color(0.065, 0.075, 0.08))
    var coat := _fallback_material(Color(0.09, 0.10, 0.105))
    var hair := _fallback_material(Color(0.012, 0.014, 0.016))
    var accent := _fallback_material(Color(0.035, 0.18, 0.13))
    var shoes := _fallback_material(Color(0.025, 0.025, 0.03))

    _fallback_root = Node3D.new()
    _fallback_root.name = "ProceduralAkiraFallback"
    motion_layer.add_child(_fallback_root)

    _fallback_box(_fallback_root, "Pelvis", Vector3(0, 0.96, 0), Vector3(0.34, 0.18, 0.23), cloth)

    _fallback_torso = Node3D.new()
    _fallback_torso.name = "TorsoPivot"
    _fallback_torso.position = Vector3(0, 1.30, 0)
    _fallback_root.add_child(_fallback_torso)
    _fallback_box(_fallback_torso, "Torso", Vector3.ZERO, Vector3(0.44, 0.50, 0.24), coat)
    _fallback_box(_fallback_torso, "EmeraldAccent", Vector3(0, 0.02, -0.126), Vector3(0.055, 0.24, 0.018), accent)

    _fallback_head = Node3D.new()
    _fallback_head.name = "HeadPivot"
    _fallback_head.position = Vector3(0, 1.68, 0)
    _fallback_root.add_child(_fallback_head)
    _fallback_sphere(_fallback_head, "Head", Vector3(0, 0.05, 0), 0.115, skin)
    _fallback_sphere(_fallback_head, "HairMass", Vector3(0, 0.11, 0.015), 0.124, hair)
    _fallback_box(_fallback_head, "HairFringe", Vector3(0, 0.07, -0.105), Vector3(0.18, 0.09, 0.045), hair)

    _fallback_arm_l = _fallback_limb(_fallback_root, "ArmL", Vector3(-0.27, 1.47, 0), Vector3(0.10, 0.46, 0.11), coat, -0.21)
    _fallback_arm_r = _fallback_limb(_fallback_root, "ArmR", Vector3(0.27, 1.47, 0), Vector3(0.10, 0.46, 0.11), coat, -0.21)

    _fallback_leg_l = _fallback_limb(_fallback_root, "LegL", Vector3(-0.105, 0.92, 0), Vector3(0.14, 0.40, 0.16), cloth, -0.19)
    _fallback_leg_r = _fallback_limb(_fallback_root, "LegR", Vector3(0.105, 0.92, 0), Vector3(0.14, 0.40, 0.16), cloth, -0.19)

    _fallback_knee_l = _fallback_limb(_fallback_leg_l, "ShinL", Vector3(0, -0.39, 0), Vector3(0.12, 0.38, 0.14), cloth, -0.18)
    _fallback_knee_r = _fallback_limb(_fallback_leg_r, "ShinR", Vector3(0, -0.39, 0), Vector3(0.12, 0.38, 0.14), cloth, -0.18)

    _fallback_box(_fallback_knee_l, "FootL", Vector3(0, -0.38, -0.075), Vector3(0.17, 0.10, 0.30), shoes)
    _fallback_box(_fallback_knee_r, "FootR", Vector3(0, -0.38, -0.075), Vector3(0.17, 0.10, 0.30), shoes)

    _fallback_coat_back = Node3D.new()
    _fallback_coat_back.name = "CoatBackPivot"
    _fallback_coat_back.position = Vector3(0, 1.22, 0.10)
    _fallback_root.add_child(_fallback_coat_back)
    _fallback_box(_fallback_coat_back, "CoatBack", Vector3(0, -0.30, 0), Vector3(0.44, 0.62, 0.08), cloth)

    _fallback_coat_l = Node3D.new()
    _fallback_coat_l.name = "CoatLPivot"
    _fallback_coat_l.position = Vector3(-0.14, 1.20, -0.02)
    _fallback_root.add_child(_fallback_coat_l)
    _fallback_box(_fallback_coat_l, "CoatL", Vector3(0, -0.29, 0), Vector3(0.14, 0.58, 0.12), cloth)

    _fallback_coat_r = Node3D.new()
    _fallback_coat_r.name = "CoatRPivot"
    _fallback_coat_r.position = Vector3(0.14, 1.20, -0.02)
    _fallback_root.add_child(_fallback_coat_r)
    _fallback_box(_fallback_coat_r, "CoatR", Vector3(0, -0.29, 0), Vector3(0.14, 0.58, 0.12), cloth)

func _animate_fallback(delta: float, speed: float) -> void:
    if _fallback_root == null:
        return

    var move_amount := clampf(speed / 4.2, 0.0, 1.0)
    _fallback_phase += delta * lerpf(1.4, 7.4, move_amount)

    var stride := sin(_fallback_phase)
    var opposite := sin(_fallback_phase + PI)
    var bob: float = absf(sin(_fallback_phase * 2.0)) * 0.018 * move_amount
    var idle_breath: float = sin(_fallback_phase * 0.75) * 0.006 * (1.0 - move_amount)

    _fallback_root.position.y = bob + idle_breath

    _fallback_leg_l.rotation.x = stride * deg_to_rad(23.0) * move_amount
    _fallback_leg_r.rotation.x = opposite * deg_to_rad(23.0) * move_amount
    _fallback_knee_l.rotation.x = maxf(0.0, -stride) * deg_to_rad(28.0) * move_amount
    _fallback_knee_r.rotation.x = maxf(0.0, -opposite) * deg_to_rad(28.0) * move_amount

    _fallback_arm_l.rotation.x = opposite * deg_to_rad(17.0) * move_amount
    _fallback_arm_r.rotation.x = stride * deg_to_rad(17.0) * move_amount

    _fallback_torso.rotation.y = -stride * deg_to_rad(3.6) * move_amount
    _fallback_torso.rotation.z = stride * deg_to_rad(1.3) * move_amount
    _fallback_head.rotation.y = stride * deg_to_rad(1.0) * move_amount + sin(_fallback_phase * 0.33) * deg_to_rad(1.2) * (1.0 - move_amount)

    var coat_swing := -stride * deg_to_rad(4.0) * move_amount
    _fallback_coat_back.rotation.x = -absf(stride) * deg_to_rad(3.0) * move_amount
    _fallback_coat_l.rotation.x = coat_swing - deg_to_rad(1.5) * move_amount
    _fallback_coat_r.rotation.x = -coat_swing - deg_to_rad(1.5) * move_amount
    _fallback_coat_l.rotation.z = stride * deg_to_rad(2.5) * move_amount
    _fallback_coat_r.rotation.z = opposite * deg_to_rad(2.5) * move_amount

func _fallback_limb(parent: Node3D, name_value: String, position_value: Vector3, size: Vector3, material: Material, mesh_y: float) -> Node3D:
    var pivot := Node3D.new()
    pivot.name = name_value
    pivot.position = position_value
    parent.add_child(pivot)
    _fallback_box(pivot, name_value + "Mesh", Vector3(0, mesh_y, 0), size, material)
    return pivot

func _fallback_box(parent: Node3D, name_value: String, position_value: Vector3, size: Vector3, material: Material) -> MeshInstance3D:
    var mesh := BoxMesh.new()
    mesh.size = size
    var instance := MeshInstance3D.new()
    instance.name = name_value
    instance.position = position_value
    instance.mesh = mesh
    instance.material_override = material
    parent.add_child(instance)
    return instance

func _fallback_sphere(parent: Node3D, name_value: String, position_value: Vector3, radius: float, material: Material) -> MeshInstance3D:
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

func _fallback_material(color: Color) -> StandardMaterial3D:
    var material := StandardMaterial3D.new()
    material.albedo_color = color
    material.roughness = 0.88
    return material

func _find_animation_player(node: Node) -> AnimationPlayer:
    if node is AnimationPlayer:
        return node as AnimationPlayer

    for child in node.get_children():
        var found := _find_animation_player(child)
        if found != null:
            return found
    return null

func _normalize_animation_name(value: String) -> String:
    return value.to_lower().replace("_", "").replace("-", "").replace(" ", "")

func _find_matching(token: String) -> String:
    if animation_player == null:
        return ""

    var normalized_token := _normalize_animation_name(token)
    for animation_name in animation_player.get_animation_list():
        if normalized_token in _normalize_animation_name(String(animation_name)):
            return String(animation_name)
    return ""

func _has_token(token: String) -> bool:
    return not _find_matching(token).is_empty()

func _play_token(token: String, loop: bool, blend: float, speed_scale: float) -> void:
    if animation_player == null:
        return

    var wanted := _find_matching(token)
    if wanted.is_empty():
        return

    if wanted == _last_animation:
        animation_player.speed_scale = speed_scale
        return

    var animation := animation_player.get_animation(wanted)
    if animation != null:
        animation.loop_mode = Animation.LOOP_LINEAR if loop else Animation.LOOP_NONE

    animation_player.speed_scale = speed_scale
    animation_player.play(wanted, blend)
    _last_animation = wanted
