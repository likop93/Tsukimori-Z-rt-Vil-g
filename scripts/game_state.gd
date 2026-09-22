extends Node

# Minimális globális állapot a vertical slice-hoz.
# A teljes route/corruption/menu rendszer még NINCS implementálva.

var flags: Dictionary = {}
var story_phase: int = 0

func set_flag(flag_name: String, value: bool = true) -> void:
    flags[flag_name] = value

func has_flag(flag_name: String) -> bool:
    return bool(flags.get(flag_name, false))

func clear_runtime_state() -> void:
    flags.clear()
    story_phase = 0
