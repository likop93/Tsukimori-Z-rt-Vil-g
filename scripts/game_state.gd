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

func rejection_actor(dialogue_id: String, choice_id: String) -> String:
    return str({"second_morning:withdraw":"miyako", "miyako_afternoon:keep_distance":"miyako",
        "hana_arrival:ask_body":"hana", "hana_memory:wait":"hana"}.get(dialogue_id+":"+choice_id,""))

func character_pressure(character: String) -> int:
    var total := 0
    for event in horror_events:
        var parts: PackedStringArray = str(event).split(":")
        if parts.size() == 2 and rejection_actor(parts[0],parts[1]) == character:
            total += 1 if parts[1] == "wait" else 2
    return total

func character_stage(character: String) -> int:
    var pressure := character_pressure(character)
    return 2 if pressure >= 3 else (1 if pressure > 0 else 0)

func character_response(character: String) -> Dictionary:
    var stage := character_stage(character)
    if stage == 0:
        return {}
    if character == "miyako":
        return {"speaker":"Miyako", "text":"Már megint távolabb húzódsz. Attól még észreveszem, ha valami történik veled." if stage == 2 else "Visszahúztad a kezed. Észrevettem, Akira.", "pressure_actor":character}
    if character == "hana":
        return {"speaker":"Hana", "text":"Ne döntsön helyettem, doktor. Ha egyszer kérdez, maradjon is itt a válaszomhoz." if stage == 2 else "Maga nagyon ügyesen tart távol mindent. Engem is.", "pressure_actor":character}
    return {}

func horror_level() -> int:
    return mini(3, floori(horror_pressure / 2.0))

func record_distance(dialogue_id: String, choice_id: String) -> bool:
    # Only decisions actually made by the player count; checkpoint flags do not.
    var weights := {"second_morning:withdraw":2, "first_clinic_morning:clinical":2,
        "hana_arrival:ask_body":2, "hana_memory:wait":1, "miyako_afternoon:keep_distance":2}
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
