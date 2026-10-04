extends RefCounted
# Read-only projection of earned story knowledge. No new relationship points.
static func entries() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	var data: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/ui/characters.json"))
	for spec in data.characters:
		var known: bool = spec.id == "akira" or GameState.has_flag(str(spec.get("reveal","")))
		if not known and not GameState.has_flag(str(spec.get("glimpse",""))):
			continue
		var entry: Dictionary = spec.duplicate(true)
		entry.known = known
		entry.title = spec.name if known else "Ismeretlen nő"
		entry.description = spec.description if known else spec.unknown
		entry.status = "Megpillantottad; még nem mutatkozott be."
		entry.events = []
		if known:
			entry.status = "Személyesen megismerted."
			if spec.id == "akira":
				entry.status = "Te"
			elif spec.id == "miyako":
				entry.events.append("Várt rád Katsuro házánál.")
				if GameState.has_flag("miyako_interior_dialogue_seen"):
					entry.status = "Beszélgettetek a közös otthonban."
					entry.events.append("Az első esti beszélgetés megtörtént.")
					if GameState.miyako_first_choice == "listen":
						entry.events.append("Hagytad, hogy a saját tempójában beszéljen.")
					elif GameState.miyako_first_choice == "ask":
						entry.events.append("Rákérdeztél, hogyan beszélnek a faluban a testükről.")
				if GameState.has_flag("miyako_morning_seen"):
					entry.status = "Az első közös reggelen is beszélgettetek."
					entry.events.append("Nem húzódtál el a kezétől." if GameState.miyako_morning_choice == "stay" else "Finoman visszahúztad a kezed.")
		result.append(entry)
	return result
