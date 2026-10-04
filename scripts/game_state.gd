extends Node

# A bejárható jelenet egyszeri jelzői. A Ren'Py kapcsolati értékek és
# döntések a dialógusok megjelenítésével együtt kerülnek át később.

var flags: Dictionary = {}
var story_phase: int = 0
var aff_miyako := 0
var akira_gyogyulas := 0
var miyako_first_choice := ""
var miyako_morning_choice := ""
var clinic_first_choice := ""
var aff_hana := 0
var aff_shion := 0
var hana_first_choice := ""
var hana_memory_choice := ""
var akira_elmerules := 0

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
    miyako_morning_choice = ""
    clinic_first_choice = ""
    aff_hana = 0
    aff_shion = 0
    hana_first_choice = ""
    hana_memory_choice = ""
    akira_elmerules = 0
