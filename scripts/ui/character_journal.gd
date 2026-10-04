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
				if GameState.has_flag("first_clinic_day_started"):
					entry.portrait = "res://assets/opening/vn_portraits/akira_doctor_v1_REVIEW.png"
				entry.status = "Te"
				if GameState.has_flag("first_night_seen"):
					entry.events.append("Nyugtalan első éjszakád volt a házban.")
				if GameState.has_flag("katsuro_first_clue_seen"):
					entry.events.append("Láttad a régi közös fényképet Katsuróval.")
				if GameState.has_flag("first_clinic_day_seen"):
					entry.events.append("Lezártad az első két konzultációt.")
				if GameState.has_flag("katsuro_clinic_notebook_seen"):
					entry.events.append("Megnézted Katsuro füzetét a rendelőben.")
				if GameState.has_flag("hana_name_heard"):
					entry.events.append("Éjszaka a Hana nevet hallottad.")
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
				if GameState.has_flag("miyako_first_day_evening_seen"):
					entry.status = "Megosztottad vele az első nap tapasztalatait."
					entry.events.append("Beszéltetek a faluban örökölt szabályokról.")
			elif spec.id == "hana":
				entry.status = "Találkoztatok a rendelőben."
				if GameState.has_flag("hana_first_boundary_seen"):
					entry.events.append("Beszéltetek a saját vágyairól és a szakmai határokról.")
				if GameState.has_flag("hana_memory_discussed"):
					entry.events.append("Megosztotta veled egy régi barátság emlékét.")
				if GameState.has_flag("hana_first_session_seen"):
					entry.status = "Az első terápiás beszélgetésetek lezárult."
					entry.events.append("Tudja, hogy visszajöhet, és nem kell szerepet játszania.")
		result.append(entry)
	return result
