extends RefCounted
const BASE := "res://assets/opening/vn_portraits/"

static func profile(id: String) -> Dictionary:
	var stage := GameState.character_stage(id)
	if id == "miyako":
		return {"stage":stage, "label":["Fegyelmezett","Figyelő","Birtokló"][stage],
			"description":["Távolságtartó nyugalommal figyel.","Számon tartja a visszahúzódásodat, és tovább tartja a szemkontaktust.","A gondoskodásába követelés vegyül. Kevésbé engedi, hogy lezárd a beszélgetést."][stage],
			"portrait":BASE+["miyako_cutout_v1_REVIEW.png","miyako_worried_v1_REVIEW.png","miyako_possessive_v1_REVIEW.png"][stage]}
	if id == "hana":
		return {"stage":stage, "label":["Magabiztos","Sértett","Követelőző"][stage],
			"description":["Közvetlenül, magabiztosan közeledik.","A mosolya megfeszül. Élesebb megjegyzésekkel próbál reakciót kiváltani.","A provokáció nyílt számonkérésbe fordul. Türelmetlenebb, és nem hagyja könnyen elengedni a témát."][stage],
			"portrait":BASE+["hana_neutral_v1_REVIEW.png","hana_guarded_v1_REVIEW.png","hana_demanding_v1_REVIEW.png"][stage]}
	return {}

