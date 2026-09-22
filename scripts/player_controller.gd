extends CharacterBody3D

@export var move_speed: float = 4.2
@export var acceleration: float = 18.0
@export var gravity: float = 24.0
@export var rotation_speed: float = 10.0

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

    var desired := Vector3(input_axis.x, 0.0, input_axis.y) * move_speed
    velocity.x = move_toward(velocity.x, desired.x, acceleration * delta)
    velocity.z = move_toward(velocity.z, desired.z, acceleration * delta)

    if not is_on_floor():
        velocity.y -= gravity * delta
    else:
        velocity.y = -0.5

    if input_axis.length() > 0.01:
        var target_angle := atan2(desired.x, desired.z)
        rotation.y = lerp_angle(rotation.y, target_angle, rotation_speed * delta)

    move_and_slide()
