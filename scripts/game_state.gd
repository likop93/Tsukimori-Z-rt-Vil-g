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
var personal_choices: Dictionary = {}

func record_personal_choice(scene: String, choice: String) -> bool:
    # Personal agreement is independent of horror and canonical affinity.
    if scene != "miyako_tea" or choice not in ["closer","slow","friends"] or personal_choices.has(scene):
        return false
    personal_choices[scene] = choice
    record_relationship_decision(scene,"miyako","closer" if choice == "closer" else ("friendship" if choice == "friends" else "boundary"))
    set_flag("miyako_evening_outfit_seen")
    return true

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
    if character == "miyako":
        # Early decisions only reveal watchfulness. A later authored story beat
        # must explicitly reveal the physical change; no current scene sets it.
        if pressure < 4:
            return 0
        return 2 if has_flag("miyako_transformation_revealed") else 1
    if character == "hana":
        if pressure < 3:
            return 0
        return 2 if has_flag("hana_transformation_revealed") else 1
    return 2 if pressure >= 3 else (1 if pressure > 0 else 0)

func character_response(character: String) -> Dictionary:
    var stage := character_stage(character)
    if character == "miyako" and stage == 0 and character_pressure(character) > 0:
        return {"speaker":"", "text":"Miyako egy pillanatig hallgatott, aztán folytatta, amit félbehagyott."}
    if character == "hana" and stage == 0 and character_pressure(character) > 0:
        return {"speaker":"", "text":"Hana mosolya egy pillanatra elhalványult. Aztán bólintott, és megvárta a következő kérdést."}
    if stage == 0:
        return {}
    if character == "miyako":
        return {"speaker":"Miyako", "text":"Már megint távolabb húzódsz. Attól még észreveszem, ha valami történik veled." if stage == 2 else "Rendben. Majd szólsz, ha beszélgetnél.", "pressure_actor":character}
    if character == "hana":
        return {"speaker":"Hana", "text":"Jól van… megvárom, amíg szól. Így maradjak? Csak mondja meg, doktor, mi lenne jó." if stage == 2 else "Talán túl közvetlen voltam. Mondja, ha inkább csendben maradjak.", "pressure_actor":character}
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
    var actor := rejection_actor(dialogue_id,choice_id)
    if not actor.is_empty():
        record_relationship_decision(event,actor,"professional" if dialogue_id.begins_with("hana") else "boundary")
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
    if flag_name == "weather_anomaly" and value and day < 30:
        return
    flags[flag_name] = value

func has_flag(flag_name: String) -> bool:
    return bool(flags.get(flag_name, false))

func clear_runtime_state() -> void:
    reset_calendar()
    flags.clear()
    personal_choices.clear()
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

# Shared calendar. Day zero is the arrival/prologue, not a clinic day.
signal calendar_changed(day: int, period: String)
const PERIODS := ["morning","clinic","afternoon","evening","night"]
const ROUTE_CHARACTERS := ["miyako","shion","kuroe","hana","himiko","reina","renka","mashiro","aoi","sora","oto"]
var day := 0
var time_of_day := "night"
var current_location := ""
var visits: Dictionary = {}
var discoveries: Dictionary = {}
var completed_events: Dictionary = {}
var relationship_decisions: Dictionary = {}
var commitments: Dictionary = {}
var harem_alignment := ""
var mashiro_invitation_day := -1
var mashiro_first_visit_day := -1

func reset_calendar() -> void:
    day = 0
    time_of_day = "night"
    current_location = ""
    visits.clear()
    discoveries.clear()
    completed_events.clear()
    relationship_decisions.clear()
    commitments.clear()
    harem_alignment = ""
    mashiro_invitation_day = -1
    mashiro_first_visit_day = -1
    calendar_changed.emit(day,time_of_day)

func set_story_time(next_day: int, period: String) -> bool:
    if next_day < 0 or next_day > 120 or period not in PERIODS:
        return false
    # Only chapter preparation/new game may rewind, through clear_runtime_state.
    if next_day < day or (next_day == day and PERIODS.find(period) < PERIODS.find(time_of_day)):
        return false
    day = next_day
    time_of_day = period
    if day < 30:
        flags["weather_anomaly"] = false
    calendar_changed.emit(day,time_of_day)
    return true

func season() -> String:
    return ["spring","summer","autumn","winter"][clampi(floori((maxi(day,1)-1)/30.0),0,3)]

func calendar_label() -> String:
    if day == 0:
        return "Megérkezés · éjszaka"
    var periods := {"morning":"reggel","clinic":"rendelés","afternoon":"délután","evening":"este","night":"éjszaka"}
    var seasons := {"spring":"tavasz","summer":"nyár","autumn":"ősz","winter":"tél"}
    return "%d. nap · %s · %s" % [day,periods[time_of_day],seasons[season()]]

func visit_location(location: String) -> bool:
    if location.is_empty():
        return false
    current_location = location
    var key := "%d:%s:%s" % [day,time_of_day,location]
    var first := not visits.has(key)
    visits[key] = true
    if not discoveries.has(location):
        discoveries[location] = day
    return first

func visited_today(location: String) -> bool:
    for period in PERIODS:
        if visits.has("%d:%s:%s" % [day,period,location]):
            return true
    return false

func event_available(spec: Dictionary) -> bool:
    if day < int(spec.get("min_day",0)) or day > int(spec.get("max_day",120)):
        return false
    if spec.has("periods") and time_of_day not in spec.periods:
        return false
    if spec.has("location") and current_location != str(spec.location):
        return false
    for flag in spec.get("requires",[]):
        if not has_flag(str(flag)):
            return false
    for flag in spec.get("excludes",[]):
        if has_flag(str(flag)):
            return false
    var id := str(spec.get("id",""))
    return not id.is_empty() and not completed_events.has(id)

func complete_event(spec: Dictionary) -> bool:
    if not event_available(spec):
        return false
    completed_events[str(spec.id)] = {"day":day,"period":time_of_day,"location":current_location}
    return true

func record_relationship_decision(event_id: String, character: String, decision: String) -> bool:
    # Record the meaning of a real choice, not an invented affinity scale.
    # Friendship, flirting and professional boundaries never commit a route.
    if event_id.is_empty() or character not in ROUTE_CHARACTERS or decision not in ["closer","friendship","boundary","professional"]:
        return false
    if relationship_decisions.has(event_id):
        return false
    relationship_decisions[event_id] = {"character":character,"decision":decision,"day":day}
    return true

func commit_relationship(character: String) -> bool:
    if character not in ROUTE_CHARACTERS:
        return false
    if character == "mashiro":
        if not mashiro_route_eligible() or mashiro_first_visit_day < 0:
            return false
    elif commitments.has("mashiro"):
        return false
    commitments[character] = true
    return true

func set_harem_commitment(alignment: String) -> bool:
    # Deliberate authored commitment only; never infer morality from partner count.
    if alignment not in ["benevolent","dark"] or commitments.has("mashiro"):
        return false
    harem_alignment = alignment
    return true

func invite_mashiro() -> bool:
    if day < 5 or day > 10 or current_location != "home" or mashiro_invitation_day >= 0:
        return false
    mashiro_invitation_day = day
    set_flag("mashiro_met")
    set_flag("mashiro_invited")
    return true

func mashiro_visit_status() -> String:
    if mashiro_invitation_day < 0:
        return "not_invited"
    var elapsed := (mashiro_first_visit_day if mashiro_first_visit_day >= 0 else day)-mashiro_invitation_day
    if elapsed <= 0:
        return "tomorrow"
    if elapsed == 1:
        return "on_time"
    if elapsed == 2:
        return "uncertain"
    if elapsed <= 4:
        return "disappointed"
    # Canon says 5+ MAY close the route. No invented irreversible ending.
    return "overdue"

func visit_mashiro() -> bool:
    if mashiro_invitation_day < 0 or day <= mashiro_invitation_day or time_of_day != "afternoon" or current_location != "greenhouse" or mashiro_first_visit_day >= 0:
        return false
    mashiro_first_visit_day = day
    set_flag("mashiro_first_visit")
    return true

func mashiro_route_eligible() -> bool:
    if not harem_alignment.is_empty() or has_flag("mashiro_route_locked"):
        return false
    for character in commitments:
        if character != "mashiro":
            return false
    return true
