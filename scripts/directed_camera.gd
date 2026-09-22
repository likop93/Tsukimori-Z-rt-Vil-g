extends Node3D

const CameraZone = preload("res://scripts/camera_zone.gd")

@export_range(0.1, 20.0) var follow_speed: float = 7.0
@export_range(0.1, 10.0) var transition_speed: float = 2.0

@onready var player: Node3D = get_parent() as Node3D
@onready var camera: Camera3D = $Camera3D

var _follow_offset: Vector3
var _default_offset: Vector3
var _default_pitch: float
var _default_yaw: float

func _ready() -> void:
    _follow_offset = position
    _default_offset = camera.position
    _default_pitch = camera.rotation.x
    _default_yaw = rotation.y
    # Keep the existing node path for the gate effect, but inherit no player transform.
    top_level = true
    global_position = player.global_position + _follow_offset
    global_rotation = Vector3(0.0, _default_yaw, 0.0)

func _physics_process(delta: float) -> void:
    var active_zone: CameraZone = null
    for node in get_tree().get_nodes_in_group("camera_zones"):
        var zone := node as CameraZone
        if zone.overlaps_body(player):
            if active_zone == null or zone.camera_priority > active_zone.camera_priority:
                active_zone = zone

    var target_offset := _default_offset
    var target_pitch := _default_pitch
    var target_yaw := _default_yaw
    if active_zone != null:
        target_offset = active_zone.camera_offset
        target_pitch = deg_to_rad(active_zone.pitch_degrees)
        target_yaw = deg_to_rad(active_zone.yaw_degrees)

    # Exponential smoothing keeps the response consistent across frame rates.
    var follow_weight := 1.0 - exp(-follow_speed * delta)
    var shot_weight := 1.0 - exp(-transition_speed * delta)
    global_position = global_position.lerp(player.global_position + _follow_offset, follow_weight)
    rotation.y = lerp_angle(rotation.y, target_yaw, shot_weight)
    camera.position = camera.position.lerp(target_offset, shot_weight)
    camera.rotation.x = lerp_angle(camera.rotation.x, target_pitch, shot_weight)
