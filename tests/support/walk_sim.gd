extends RefCounted
# Test-only stand-in for "holding a direction". The game has no free keyboard
# movement (owner decision 2026-10-20); tests drive Akira through the same
# automatic-walk path the game uses, towards a far point in the held direction.
const DIRECTIONS := {
	"walk_left": Vector2.LEFT,
	"walk_right": Vector2.RIGHT,
	"walk_up": Vector2.UP,
	"walk_down": Vector2.DOWN,
}
static var held: Dictionary = {}

static func _apply(player) -> void:
	var direction := Vector2.ZERO
	for action in held:
		direction += DIRECTIONS[action]
	if direction == Vector2.ZERO:
		player.stop_autowalk()
	else:
		player.walk_to(player.position+direction.normalized()*400.0)

static func press(player, action: String) -> void:
	held[action] = true
	_apply(player)

static func release(player, action: String) -> void:
	held.erase(action)
	_apply(player)

static func reset(player) -> void:
	held.clear()
	player.stop_autowalk()
