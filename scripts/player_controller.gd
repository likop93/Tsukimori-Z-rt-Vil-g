extends CharacterBody3D

@export var move_speed: float = 4.2
@export var acceleration: float = 18.0
@export var gravity: float = 24.0
@export var rotation_speed: float = 10.0

@onready var visual_body: MeshInstance3D = $PlaceholderBody
@onready var camera: Camera3D = $CameraPivot/Camera3D

func _ready() -> void:
    add_to_group("player")

func _physics_process(delta: float) -> void:
    var input_axis := Vector2.ZERO

    if Input.is_key_pressed(KEY_A):
        input_axis.x -= 1.0
    if Input.is_key_pressed(KEY_D):
        input_axis.x += 1.0
    if Input.is_key_pressed(KEY_W):
        input_axis.y -= 1.0
    if Input.is_key_pressed(KEY_S):
        input_axis.y += 1.0

    input_axis = input_axis.normalized()

    # Use the visible camera's axes on the ground, including during shot transitions.
    var right := camera.global_basis.x
    var back := camera.global_basis.z
    right.y = 0.0
    back.y = 0.0
    var direction := right.normalized() * input_axis.x + back.normalized() * input_axis.y
    var desired := direction.normalized() * move_speed
    var horizontal_velocity := Vector3(velocity.x, 0.0, velocity.z)
    horizontal_velocity = horizontal_velocity.move_toward(desired, acceleration * delta)
    velocity.x = horizontal_velocity.x
    velocity.z = horizontal_velocity.z

    if not is_on_floor():
        velocity.y -= gravity * delta
    else:
        velocity.y = -0.5

    move_and_slide()

    # Face the actual movement after collisions; the player root and camera stay independent.
    if Vector2(velocity.x, velocity.z).length() > 0.01:
        var target_angle := atan2(velocity.x, velocity.z)
        visual_body.global_rotation.y = lerp_angle(
            visual_body.global_rotation.y, target_angle, 1.0 - exp(-rotation_speed * delta)
        )
