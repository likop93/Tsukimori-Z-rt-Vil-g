extends Node

# A Ren'Py történeti állapotának első, szűk Godot-megfeleltetése.
# A teljes route/corruption/menu rendszer még NINCS implementálva.

var flags: Dictionary = {}
var story_phase: int = 0
var aff_miyako: int = 0
var akira_gyogyulas: int = 0
var miyako_first_choice: String = ""

func choose_miyako_first_response(choice: String) -> bool:
    if not miyako_first_choice.is_empty() or (choice != "silence" and choice != "question"):
        return false
    miyako_first_choice = choice
    if choice == "silence":
        aff_miyako += 1
        akira_gyogyulas += 1
    return true

func set_flag(flag_name: String, value: bool = true) -> void:
    flags[flag_name] = value

func has_flag(flag_name: String) -> bool:
    return bool(flags.get(flag_name, false))

func clear_runtime_state() -> void:
    flags.clear()
    story_phase = 0
    aff_miyako = 0
    akira_gyogyulas = 0
    miyako_first_choice = ""
