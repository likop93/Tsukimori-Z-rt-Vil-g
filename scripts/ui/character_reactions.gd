extends RefCounted
const BASE := "res://assets/opening/vn_portraits/"

static func outfit_portrait(id: String, outfit: String) -> String:
	if id == "miyako" and outfit == "evening":
		return BASE+["miyako_evening_v1_REVIEW.png","miyako_evening_watchful_v1_REVIEW.png","miyako_evening_transformed_v1_REVIEW.png"][GameState.character_stage(id)]
	return ""

static func profile(id: String) -> Dictionary:
	var stage := GameState.character_stage(id)
	if id == "miyako":
		return {"stage":stage, "label":["Fegyelmezett","Figyelő","Birtokló"][stage],
			"description":["Távolságtartó nyugalommal figyel.","Néha tovább időzik rajtad a tekintete. Egyelőre nehéz eldönteni, mi jár a fejében.","Haja ezüstösre világosodik, szeme jégkékké válik, alakja a ruha alatt is teltebb. Mániákus mosollyal figyel; gondoskodása egyre követelőzőbb."][stage],
			"portrait":BASE+["miyako_cutout_v1_REVIEW.png","miyako_possessive_v1_REVIEW.png","miyako_transformed_manic_v1_REVIEW.png"][stage]}
	if id == "hana":
		return {"stage":stage, "label":["Magabiztos","Elbizonytalanodó","Alárendelődő"][stage],
			"description":["Közvetlenül, magabiztosan közeledik.","Elakad a megszokott magabiztossága. Óvatosabban beszél, és a jóváhagyásodat keresi.","Alakja karcsúbbá, megjelenése lágyabbá, nőiesebbé válik. Kezeit összefogva vár, minden apró döntéshez az engedélyedet keresi. A túlzott alkalmazkodás szokatlan, nyugtalanító változás."][stage],
			"portrait":BASE+["hana_neutral_v1_REVIEW.png","hana_guarded_v1_REVIEW.png","hana_transformed_deferential_v1_REVIEW.png"][stage]}
	return {}

