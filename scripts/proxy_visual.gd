extends Node3D

@export_file("*.glb") var proxy_scene_path: String = "res://assets/characters/akira/proxy/akira_proxy.glb"

@onready var placeholder_body: MeshInstance3D = $PlaceholderBody

var animation_player: AnimationPlayer
var _last_animation := ""

func _ready() -> void:
    if not ResourceLoader.exists(proxy_scene_path):
        return

    var packed := load(proxy_scene_path) as PackedScene
    if packed == null:
        push_warning("Akira proxy GLB exists but could not be loaded: %s" % proxy_scene_path)
        return

    var proxy := packed.instantiate()
    proxy.name = "AkiraProxy"
    add_child(proxy)
    placeholder_body.visible = false
    animation_player = _find_animation_player(proxy)
    _play_matching("idle")

func _process(_delta: float) -> void:
    if animation_player == null:
        return

    var player := get_parent() as CharacterBody3D
    if player == null:
        return

    var speed := Vector2(player.velocity.x, player.velocity.z).length()
    if speed > 0.15:
        _play_matching("walk")
    else:
        _play_matching("idle")

func _find_animation_player(node: Node) -> AnimationPlayer:
    if node is AnimationPlayer:
        return node as AnimationPlayer

    for child in node.get_children():
        var found := _find_animation_player(child)
        if found != null:
            return found
    return null

func _play_matching(token: String) -> void:
    if animation_player == null:
        return

    var wanted := ""
    for animation_name in animation_player.get_animation_list():
        if token in String(animation_name).to_lower():
            wanted = String(animation_name)
            break

    if wanted.is_empty() or wanted == _last_animation:
        return

    var animation := animation_player.get_animation(wanted)
    if animation != null:
        animation.loop_mode = Animation.LOOP_LINEAR

    animation_player.play(wanted, 0.15)
    _last_animation = wanted
