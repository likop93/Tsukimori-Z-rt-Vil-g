extends CharacterBody3D

@export var move_speed: float = 4.2
@export var acceleration: float = 18.0
@export var gravity: float = 24.0
@export var rotation_speed: float = 8.0

@onready var visual_body: Node3D = $VisualRoot

var _input_lock_remaining := 0.0
var _controls_locked := false
var _held_input_axis := Vector2.ZERO
var _held_forward := Vector3.FORWARD
var _held_right := Vector3.RIGHT

func _ready() -> void:
    add_to_group("player")

func request_soft_stop(duration: float) -> void:
    _input_lock_remaining = maxf(_input_lock_remaining, duration)

func set_controls_locked(locked: bool) -> void:
    _controls_locked = locked

func _physics_process(delta: float) -> void:
    _input_lock_remaining = maxf(0.0, _input_lock_remaining - delta)

    var input_axis := Vector2.ZERO
    if _input_lock_remaining <= 0.0 and not _controls_locked:
        if Input.is_key_pressed(KEY_A):
            input_axis.x -= 1.0
        if Input.is_key_pressed(KEY_D):
            input_axis.x += 1.0
        if Input.is_key_pressed(KEY_W):
            input_axis.y -= 1.0
        if Input.is_key_pressed(KEY_S):
            input_axis.y += 1.0

    input_axis = input_axis.normalized()

    # Sample the screen axes on each new input. Keeping them through the key hold
    # prevents a following camera from feeding its own rotation back into movement.
    if input_axis != _held_input_axis and input_axis != Vector2.ZERO:
        var view_basis := ($CameraPivot as Node3D).global_basis
        _held_forward = -Vector3(view_basis.z.x, 0.0, view_basis.z.z).normalized()
        _held_right = Vector3(view_basis.x.x, 0.0, view_basis.x.z).normalized()
    _held_input_axis = input_axis
    var desired := (_held_right * input_axis.x - _held_forward * input_axis.y) * move_speed
    var horizontal_velocity := Vector3(velocity.x, 0.0, velocity.z)
    horizontal_velocity = horizontal_velocity.move_toward(desired, acceleration * delta)
    velocity.x = horizontal_velocity.x
    velocity.z = horizontal_velocity.z

    if not is_on_floor():
        velocity.y -= gravity * delta
    else:
        velocity.y = -0.5

    move_and_slide()

    # Turn the visible body with eased inertia instead of snapping the whole player root.
    if Vector2(velocity.x, velocity.z).length() > 0.05:
        var target_angle := atan2(velocity.x, velocity.z)
        visual_body.global_rotation.y = lerp_angle(
            visual_body.global_rotation.y,
            target_angle,
            1.0 - exp(-rotation_speed * delta)
        )
