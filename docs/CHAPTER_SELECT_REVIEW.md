# Fejezetválasztás — 2026-10-04, REVIEW

Tulajdonosi kérés: a további történeti fejlesztés előtt a tesztelést megkönnyítő fejezetválasztó a játék elején. Főmenü → Fejezetválasztás. Egér vagy fel/le + Enter; Esc/Vissza bezárja, a fókusz visszatér a főmenügombra. Megnyitás és bezárás nem változtatja a játékállapotot.

## Belépési pontok

| Rész | Indulás | Előzmény |
| --- | --- | --- |
| Nyitány | Fekete + eső, eredeti monológ | Tiszta új játék |
| Falusi séta | Kapu, aktív játékoskontroll | opening_intro_seen, entered_tsukimori |
| I. Miyako | Első személyes köszöntés a háznál | Hídon átkelés; met_miyako még nincs |
| II. Első éjszaka | Akira VN-szobája, esti beszélgetés | Miyako külső/belső találkozás lezárva |
| III. Első rendelési nap | Eredeti közös reggel és döntések | Első éjszaka lezárva, konzultációk még nincsenek |
| IV. Hana | Éjszakai visszatolt füzet → reggeli előkészítés → Hana | Első nap lezárva; Hana személyes megismerése még nincs |

Csak már megvalósított részek választhatók. Ez tesztbelépés, nem mentésbetöltés vagy route/unlock rendszer. A kiválasztott rész új állapotból indul. Előző döntések az eredeti, nulla pontot adó alternatívákat kapják: Miyako első kérdés/ask; reggel withdraw; rendelési hozzáállás clinical. Nincs önkényes kapcsolatpont vagy jövőbeli karakterismeret. Az aktuális fejezet döntései továbbra is a játékosra várnak. A karakterlap a beállított előzményeket mutatja; ez tesztelőzmény, nem valódi végigjátszás mentése.

## Technika és ellenőrzés

scripts/ui/chapter_catalog.gd tartalmazza a belépési pontokat, érvényességi ellenőrzést, előzményflaget és scene-indítást. GameState.chapter_start egyszeri kérés, a tényleges scene _ready elfogyasztja. Az új Játék indítása ugyanúgy tiszta nyitányt indít. Az intró kihagyása a közös, egyszeri handoff úton fut. Kettős indítás és az átmenet alatti visszalépés nem cseréli le a választást. Nincs új asset vagy LOCKED redesign.

chapter_select_regression: mind a hat pont a valódi főmenüből, Enterrel és nyilakkal; visszalépés/fókusz; korábbi tesztállapot törlése; egyszeri kérés; megfelelő fázis/flag; első mondat megmaradása; szünet; ismeretlen fejezet elutasítása. main_menu_regression: eredeti normál új játék, beállítások és intró kihagyás. night_day_regression és hana_day_regression: normál történeti útvonalak és eredeti választások változatlanok.

Képi review: review/chapter_selector_REVIEW.png, chapter_miyako_REVIEW.png, chapter_night_REVIEW.png, chapter_clinic_REVIEW.png, chapter_hana_REVIEW.png. Következő történeti blokk továbbra is Hana találkozása után a megírt késő délutáni Miyako-jelenet.
