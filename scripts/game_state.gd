extends Node

# A bejárható jelenet egyszeri jelzői. A Ren'Py kapcsolati értékek és
# döntések a dialógusok megjelenítésével együtt kerülnek át később.

var flags: Dictionary = {}
var chapter_start := ""
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
signal horror_changed(level: int)
var horror_events: Dictionary = {}
var horror_pressure := 0

func horror_level() -> int:
    return mini(3, floori(horror_pressure / 2.0))

func record_distance(dialogue_id: String, choice_id: String) -> bool:
    # Only decisions actually made by the player count; checkpoint flags do not.
    var weights := {"second_morning:withdraw":2, "first_clinic_morning:clinical":2,
        "hana_arrival:ask_body":2, "hana_memory:wait":1}
    var event := dialogue_id+":"+choice_id
    if not weights.has(event) or horror_events.has(event):
        return false
    horror_events[event] = true
    horror_pressure = mini(6,horror_pressure+int(weights[event]))
    horror_changed.emit(horror_level())
    return true

func horror_response() -> String:
    match horror_level():
        1: return "A szoba egy pillanatra hűvösebbnek tűnt. Akira az ablakra nézett. Csukva volt."
        2: return "A fal mögül halk súrlódás hallatszott. Amikor Akira elhallgatott, a hang is abbamaradt."
        3: return "A padló alól három tompa koppanás felelt a csendre. Akira kivárt. A negyedik közvetlenül a széke alól érkezett."
    return "A csend egy pillanattal tovább tartott, mint kellett volna."

func set_flag(flag_name: String, value: bool = true) -> void:
    flags[flag_name] = value

func has_flag(flag_name: String) -> bool:
    return bool(flags.get(flag_name, false))

func clear_runtime_state() -> void:
    flags.clear()
    horror_events.clear()
    horror_pressure = 0
    horror_changed.emit(0)
    chapter_start = ""
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
