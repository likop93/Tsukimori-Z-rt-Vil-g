extends Area3D

## Author a shot in the world scene. Higher priority wins in overlapping zones.
@export var camera_priority: int = 0
@export_range(-180.0, 180.0) var yaw_degrees: float = 0.0
@export var camera_offset := Vector3(0.0, 7.2, 8.8)
@export_range(-80.0, -5.0) var pitch_degrees: float = -34.0

func _ready() -> void:
    add_to_group("camera_zones")
