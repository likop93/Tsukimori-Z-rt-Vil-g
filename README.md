# Tsukimori — Zárt Világ

Godot 4.7.2 alapú, cinematic pixel-art / 2.5D narratív pszichológiai horror és romantikus játék, 640×360 alapfelbontással. **Technikai REVIEW állapot:** a LOCKED kreatív döntések változatlanok, a működés nem jelent FINAL assetjóváhagyást.

## Indítás
1. A teljes ZIP kicsomagolása egy új mappába.
2. Godot 4.7.2 (normál kiadás) → Importálás → a gyökérben lévő `project.godot`.
3. Az import után F5 → főmenü (`scenes/ui/main_menu.tscn`) → Játék indítása.

macOS: [MACOS_INSTALL_HU.txt](docs/MACOS_INSTALL_HU.txt). Tesztelői leírás: [TESTER_README.txt](TESTER_README.txt). Játékállás-mentés még nincs; csak a hangerő és a teljes képernyő marad meg.

## Mi játszható most (2026-10-20)
Az érkezéstől a 3. nap esti teájáig összefüggő történet. Ez rendezett jelenetsor, nem három szabadon szimulált nap.

**nyitány (66 mp) → kapu → Miyako első találkozása → házbelső → első éjszaka → 1. nap (rendelő, két páciens, délutáni falubejárás) → 2. nap (Hana, késő délutáni Miyako, éjszakai látogató) → 3. nap (Shion-konzultáció, pecsét, délutáni falutérkép Ayamével és Hana/Himiko-említéssel, esti tea)**

A tea után a főmenü következik, negyedik nap nincs. Gyors belépés: Főmenü → Fejezetválasztás (10 belépő, előzményekkel, de megszerzett pontok nélkül; nem save/load). Karaktergaléria és karakterlapok a főmenüből, illetve a szünetmenüből.

| Működő rendszer | Hol |
|---|---|
| Főmenü, szünetmenü, beállítások, fejezetválasztó | `scripts/ui/` |
| VN-párbeszéd, portrék, CG-k, választások (adatvezérelt) | `scripts/ui/vn_dialogue.gd`, `data/home_day1–3` |
| Kattintásos falutérkép, visszalátogatások | `scripts/ui/village_map.gd`, `scripts/opening/village_walk_director.gd` |
| GameState: 120 napos naptár, napszakok, események, látogatások, kapcsolatok | `scripts/game_state.gd` |
| Karakterlapok, kapcsolati állapot, elutasítási/horror-állapotok | `scripts/ui/character_*.gd` |
| Godot-tesztek | `tests/` |

## Még nincs
4–10. nap · Hetedik Éjszaka · Katsuro nyomozati ága · Himiko érkezése · Mashiro jelenetei · Sayuri · mentés/betöltés · combat, inventory, komplex route-rendszer · végleges animáció, portrék és hang.

## Tulajdonosi döntések, amelyek még nincsenek implementálva (2026-10-20)
- **Autós érkezés:** a nyitány már autós (v3, REVIEW, [részletek](docs/OPENING_V3_CAR_ARRIVAL.md)); a falu szélén parkol. A gyaloglás Miyako házáig filmes átvezetésként még hátra van.
- **Akira szemüveg nélkül**, sötét kapucnis kabátban.
- **Nincs WASD-alapú szabad mozgás** (kivezetve, REVIEW, [részletek](docs/AUTOWALK_NO_WASD.md)): a kapu utáni szakaszban, a híd–ház úton, a házbelsőben és az esti nappaliban Akira magától megy a következő pontig, a játékos E-vel lép tovább. Térképes helyszínválasztás, filmes átvezetések és VN marad.

Részletek: [DECISION_LOG](docs/DECISION_LOG.md), 2026-10-20.

## Irányítás (jelenlegi build, kivezetés alatt)
Akira magától megy (nincs WASD/futás) · E: figyelés, továbbhaladás, beszélgetés · Space / Enter / bal kattintás: szöveg · Esc: szünetmenü (intróban kihagyás) · Tab: szünet · F1: súgó · M: falutérkép. A falutérképen kattintással lehet helyszínt választani, a „Hazamegyek” bármikor elérhető. [Menü és futás](docs/PAUSE_AND_RUN_REVIEW.md), [fejezetválasztó](docs/CHAPTER_SELECT_REVIEW.md).

## Teszt- és állapotforrások
- [Fejlesztési állapot](docs/PROGRESS.md)
- [Main audit és 3–10. napi terv, 2026-10-19](docs/WORK_HANDOFF_AUDIT_2026_10_19.md)
- [3. nap, Ayame, tesztek, 2026-10-20](docs/DAY3_VILLAGE_REVIEW.md)
- [Beérkezett Mashiro/Ayame referenciák](docs/REFERENCE_INTAKE_2026_10_20.md)

A 3. napi suite-ok sikeresek. Két régi teszt (`vn_dialogue`, `interior`) kézzel felállított belépési fixture-je hibás, és kilépéskor 2–4 ObjectDB-figyelmeztetés marad.

## Governance
A kreatív authority: [DECISION_LOG](docs/DECISION_LOG.md), [CREATIVE_BIBLE](docs/CREATIVE_BIBLE.md), [STORY_CANON](docs/STORY_CANON.md), [CHARACTER_BIBLE](docs/CHARACTER_BIBLE.md), [ART_DIRECTION_LOCK](docs/ART_DIRECTION_LOCK.md), [PIXEL_ART_PRODUCTION_DIRECTION](docs/PIXEL_ART_PRODUCTION_DIRECTION.md), [VISUAL_REFERENCE_INDEX](docs/VISUAL_REFERENCE_INDEX.md), [VISUAL_ASSET_USAGE_MATRIX](docs/VISUAL_ASSET_USAGE_MATRIX.md). Új történeti irányok: [STORY_DIRECTION_ADDENDUM](docs/STORY_DIRECTION_ADDENDUM_2026_10_19.md), [120 napos handoff](docs/TSUKIMORI_120_DAY_STORY_AND_WORK_HANDOFF.md). Az explicit tulajdonosi döntés felülírja az ellentétes régebbi LOCKED sort, de a DECISION_LOG-ba be kell vezetni.

## Archívum
- Korábbi 3D prototípus: [archive/legacy_3d](archive/legacy_3d/README.md). A jelenlegi F5 nem tölti be.
- Az előző README részletes változata: [README_HISTORY_BEFORE_2026_10_20](docs/README_HISTORY_BEFORE_2026_10_20.md).
