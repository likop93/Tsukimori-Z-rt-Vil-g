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

func _ready() -> void:
    if not ResourceLoader.exists(proxy_scene_path):
        return

    var packed := load(proxy_scene_path) as PackedScene
    if packed == null:
        push_warning("Akira proxy GLB exists but could not be loaded: %s" % proxy_scene_path)
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

    if animation_player == null:
        return

    var now := Time.get_ticks_msec()
    if now < _one_shot_until_msec:
        return
    elif not _one_shot_token.is_empty():
        _one_shot_token = ""
        _last_animation = ""

    var speed := Vector2(player.velocity.x, player.velocity.z).length()
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
    _play_one_shot("gatereact", 0.95)

func play_lookout_react() -> void:
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
    var speed_ratio := clampf(horizontal_speed / maxf(player.move_speed, 0.1), 0.0, 1.0)
    var target_pitch := deg_to_rad(-body_lean_degrees) * speed_ratio

    var local_velocity := global_basis.inverse() * Vector3(player.velocity.x, 0.0, player.velocity.z)
    var target_roll := clampf(-local_velocity.x * 0.012, deg_to_rad(-1.8), deg_to_rad(1.8))

    var weight := 1.0 - exp(-7.0 * delta)
    motion_layer.rotation.x = lerp_angle(motion_layer.rotation.x, target_pitch, weight)
    motion_layer.rotation.z = lerp_angle(motion_layer.rotation.z, target_roll, weight)

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
