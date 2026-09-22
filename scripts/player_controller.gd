extends CharacterBody3D

@export var move_speed: float = 4.2
@export var acceleration: float = 18.0
@export var gravity: float = 24.0
@export var rotation_speed: float = 10.0

@onready var visual_body: MeshInstance3D = $PlaceholderBody
@onready var camera: Camera3D = $CameraPivot/Camera3D

var _movement_basis_locked := false
var _movement_right := Vector3.RIGHT
var _movement_back := Vector3.BACK

func _ready() -> void:
    add_to_group("player")

func _movement_keys_pressed() -> bool:
    return Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_A) \
        or Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_D)

func _input(event: InputEvent) -> void:
    # Catch a full release even if a new press arrives before the next physics tick.
    if event is InputEventKey and not event.pressed:
        if event.keycode in [KEY_W, KEY_A, KEY_S, KEY_D] and not _movement_keys_pressed():
            _movement_basis_locked = false

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

    # Keep the input frame until all movement keys are released. Camera animation
    # must not steer a held direction, including when adding/removing diagonal keys.
    if not _movement_keys_pressed():
        _movement_basis_locked = false
    elif not _movement_basis_locked and not input_axis.is_zero_approx():
        _movement_right = camera.global_basis.x
        _movement_back = camera.global_basis.z
        _movement_right.y = 0.0
        _movement_back.y = 0.0
        _movement_right = _movement_right.normalized()
        _movement_back = _movement_back.normalized()
        _movement_basis_locked = true
    var direction := _movement_right * input_axis.x + _movement_back * input_axis.y
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
