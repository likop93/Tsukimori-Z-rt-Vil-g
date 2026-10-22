# V4 — Akira/Miyako első találkozás, kontrollált képi próba

**Utólagos tulajdonosi visszajelzés: az itt látható elrendezés nem elfogadott.** A javított beállítás és a GitHub-biblia összevetése: [VN_LAYOUT_BIBLE_REVIEW_2026_10_22.md](VN_LAYOUT_BIBLE_REVIEW_2026_10_22.md). A forrásintegritási adatok megmaradnak; a korábbi teszt-PASS nem vizuális jóváhagyás.

2026-10-22. Kiindulás: `7e1a0b80c19df58bd5793008af2a1e8f1a69a052`, GitHub main. Státusz: **IMPLEMENTED technikai próba / REVIEW grafika**, nem végleges pixel-art készlet.

## Elvégzett munka

A tulajdonos V3 és V4 ZIP-jeinek 21 fájlja változatlan bájtokkal, eredeti néven a `reference/incoming/2026-10-22/visual_v3` és `visual_v4` mappában szerepel. A `.gdignore` kizárja a referenciákat a Godot importból. A [leltár](../reference/incoming/2026-10-22/intake_manifest.json) fájlonkénti SHA-256-ot, a [forrásjegyzék](../reference/incoming/2026-10-22/source_archives.json) ZIP-hash-eket tartalmaz. Mind a 21 másolat ellenőrizve. A csomagok dokumentumai forrásként vannak archiválva; jelenlétük nem teszi kész funkcióvá a bennük szereplő terveket.

Az első Miyako-találkozás explicit módon a V4 két különálló eredetijének változatlan runtime másolatát tölti:

- `assets/opening/vn_portraits/v4/akira_owner_original_REVIEW.png` — A0; SHA-256 `04a0b82c972c235536dfc03bb882dc8810a6335c65fcf169c19b5cf30f835cd8`.
- `assets/opening/vn_portraits/v4/miyako_owner_cutout_REVIEW.png` — M0 kivágat; SHA-256 `0c372188c87edbec4f1f6a00ce3893be0b9893b175eaabb63ea8deaa31561fd3`.

Csak a `data/opening/miyako_first_dialogue.json` képi hozzárendelése változott. A három mondat, a forrásmegjelölés, az eseményazonosító, a flagkezelés és a feloldások változatlanok. A `warm` szerzői szándék megmaradt a sorban, de ebben a próbában M0 a semleges fallback: nem állítjuk, hogy a csomag M01/M02 mimikát is tartalmazott. A korábbi képek és más jelenetek hozzárendelései megmaradtak. Nincs új VN- vagy GameState-rendszer, renderer-módosítás vagy képgenerálás.

## Képi eredmény

[Előtte, 640×360](visual_v4_review_2026_10_22/before_0.png) · [Utána, 640×360](visual_v4_review_2026_10_22/after_0.png). A mappában mindhárom oldal előtte/utána képe megtalálható.

A régi első portrék már követték az A0/M0 karakterazonosságot: nem találtunk itt szemüveges/öltönyös Akirát vagy új arcú Miyakót. Ez ezért kis, ellenőrizhető forráspontosítás, nem látványos karaktercsere. Miyako balra, Akira jobbra marad, egymás felé tájolva, azonos 228×312-es keret nélküli megjelenítési területen. A haj és a fej nem vágódik le; a szöveg mindhárom oldalon elfér. A két alak szemmagassága nem teljesen azonos, de Akira kissé magasabb beállítása olvasható; a képet nem torzítottuk azonos szemvonal kedvéért.

Mindkét forrás alfa-csatornás, a sarkok átlátszóak. Sötét háttéren világos peremfény/mattmaradvány látszik a sziluetteken; különösen Akira haján és ruháján. Az alfa és az egységes pixelrajz még **REVIEW**, nem hibátlan production kivágat. A nagyfelbontású képek nearest megjelenítése nem végleges pixel-art adaptáció. A háttérben a jelenlegi világfigurák is látszanak: ez a korábbi rendezés, nem az új autós/tisztán filmes nyitás elkészülte.

## Rövid aktív assettérkép

| Csoport és tényleges fájl / bekötés | Megállapítás és státusz |
|---|---|
| V4 A0/M0 fenti két runtime fájl | Meglévő tulajdonosi identitásforrás; az első találkozásban tesztelve. Render/alfa REVIEW. |
| `akira_neutral_v1_REVIEW.png`, `miyako_cutout_v1_REVIEW.png`, `miyako_warm_v1_REVIEW.png` | Meglévő, az alapidentitást követő korábbi változatok. A VN alapértelmezéseiben, karakterlapokban és későbbi jelenetekben továbbra is használatban; nem utólagos FINAL jóváhagyás. |
| `miyako_worried_v1_REVIEW.png`, `miyako_surprised_v1_REVIEW.png` | Létező régi reakciók az interior/morning/clinic/evening és 2. napi adatokban. Nem azonosak a V4 késznek még nem tekinthető 00–07 reakciómátrixával; jelen egység nem minősíti át őket. |
| `akira_doctor_v1_REVIEW.png`, `akira_doctor_green_eye_v1_REVIEW.png` | Meglévő klinikai változatok. A köpeny a rendelőben indokolt; falubejáráskor, a 3. napi boltban és Miyako teájánál V4 outfit-eltérés. A zöld szemű változat történeti használatát külön kell megőrizni/ellenőrizni; nem cserélhető vakon A0-ra. Következő célzott feladat. |
| `miyako_possessive_v1_REVIEW.png`, `miyako_transformed_manic_v1_REVIEW.png`, `miyako_evening*_REVIEW.png` | A `character_reactions.gd` állapotfüggő családja, meglévő későbbi formák. A világos hajú/kék szemű kép nem M0. Nem első találkozásra való, nem új referenciaként használható; a korábbi történeti állapotkezelést nem módosítottuk. |
| `assets/opening/cinematic_v2/akira_recover_REVIEW.png` | Megnézett, alapruhát követő régi CG; buszbelsőben játszódik, ezért helyszíni/nyitási eltérés az autós tervhez. Nem szemüveges/öltönyös identitáshiba. |
| `sequence.json`: `memory_warm_REVIEW.png`, `memory_cold_REVIEW.png`, `short_intro_v1/memory_REVIEW.png`, busz/erdő képek | Jelenleg bekötött régi nyitóképek. V4 szerinti teljes CG-elfogadásuk nem történt meg. Nem lett mindegyik újragenerálva vagy késznek minősítve. |
| `assets/home_day1/akira_katsuro_photo_v1_REVIEW.png`, `akira_sleep_REVIEW.png`, `akira_room_REVIEW.png`, `hallway/miyako_turn_v1_REVIEW.png` | Első éjszakai/fotó/folyosói meglévő bekötések. Ebben a szűk próbában változatlanok, nem teljes CG-audit eredménye. |
| V4 A01–A07/M01–M07, egységes production pixel-art adaptáció, 23 új CG és autós nyitás | **MISSING/TERV** ebben a csomagban és ebben a fejlesztési egységben; nincs késznek jelentve. |

Az ellenőrizhető [gépi útvonallista](visual_v4_review_2026_10_22/literal_asset_references.json) 16 külön, szó szerint megadott Akira/Miyako képútvonalat és hivatkozási helyeiket tartalmazza. Ez nem teljes futási függőséggráf; a dinamikus családok és általános nevű CG-k fent külön szerepelnek. Az itt ténylegesen megvizsgált első portrék között nincs bizonyított `REJECTED_FOR_CHARACTER_IDENTITY` eset. Nem címkézünk elutasítottnak látatlanban egy meglévő képet, és nem vonjuk vissza a későbbi átalakulás korábbi jóváhagyását.

## Valódi tesztek

Tiszta, a fenti main commitból kibontott munkapéldány, saját tesztprofil; Godot **4.7.2 stable**, Compatibility/OpenGL, grafikus futás. [Gépi eredmény](visual_v4_review_2026_10_22/test_results.json).

- `vn_dialogue_regression`: **PASS** előtte és utána. A régi hibás, kézzel felépített fixture helyett a valós `miyako` fejezetbelépőt használja. A teszt javítása nem került megkerülő játéklogikaként a runtime-ba.
- Ellenőrizve: két eredeti V4 texture betöltése; átlátszó háttér; bal/jobb elhelyezés; szünet alatti léptetés tiltása; első gomb csak kiírja a mondatot; oldalankénti léptetés; szöveg nem vágódik; mozgás tiltva beszélgetés alatt; flag csak végső nyugtázás után; vezérlés visszaadása; korai Miyako stage 0 és transformation flag hamis.
- `current_entry_audit`: **PASS**, valódi utca → híd → ház → első VN → belépés, mindkét belső válasszal és megtartott affinitással.
- `chapter_select_regression`: **PASS**.
- VN próba **1920×1080, 3× integer** ablakmérettel is PASS; a mentett natív viewport képek 640×360-asak.
- Runtime naplókban nincs ERROR/WARNING. Az első sandboxos editor-import safe-save hibát jelzett; az engedélyezett ismétlés hibamentes. Mindkét importnapló megmaradt. Ez nem a teljes tesztkészlet vagy a teljes 120 nap igazolása; a korábbi külön `interior` fixture hibáját ez a munka nem javítja.

## Következő egység

Először a V4 képi próba tulajdonosi átnézése, majd az utcai/otthoni köpeny-hozzárendelések rendezése, a történeti szemváltozás megőrzésével. Ezután egyetlen egységes A0/M0 pixel-art render és alfa-korrekció, majd abból reakciók. Az autós, térképes nyitás külön implementáció; a buszos bevezető és a korai kézi mozgás még a régi rendszerben van. A 4–6. nap, 7. éjszaka és a 23 CG nem készült el ebben a képi javításban.
