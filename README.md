# Tsukimori — Zárt Világ

A jelenleg futó játék egy high-detail pixel-art 2D/2.5D narratív prototípus. F5 a főmenüt indítja. A „Játék indítása” innen vezet a 66 másodperces nyitásba: busz, Akira monológja, emléktöredék, leszállás, erdei séta, kapu. A kapunál visszakapod az irányítást; a híd és Miyako találkozása játékosvezérelt.

## Indítás

1. A teljes ZIP-et csomagold ki egy új mappába.
2. Godot 4.7.2 → Importálás → a gyökérben lévő project.godot.
3. Várd meg az importálást, majd F5 → Játék indítása.

A főmenü egérrel vagy nyilakkal és Enterrel kezelhető. Beállítások: hangerő és teljes képernyő; ezek a következő indításra is megmaradnak. Az Irányítás megnyitja a gombok leírását, a Kilépés bezárja a játékot. Esc visszalép az almenükből. Játékállás-mentés még nincs.

WASD / nyilak: séta. Shift nyomva: futás. E: figyelés, továbbhaladás a helyszín kijáratánál, beszélgetés Miyakóval. Space / Enter: szöveg gyorsítása / tovább. Esc: szünetmenü (intróban kihagyás). Tab / jobb felső Menü gomb: szünet bármikor. F1: vezérlési segítség.

A szünetmenüben folytatás, karakterlapok és kapcsolati státusz, hangerő, teljes képernyő, irányítás és főmenübe visszatérés található. A világ és a párbeszéd szünet alatt megáll. [Menü és futás REVIEW](docs/PAUSE_AND_RUN_REVIEW.md).

## Aktuális állapot

Miyako előtt E indítja az első VN-jelenetet. E / Space / Enter / bal kattintás kiírja az aktuális mondatot, majd továbblép. A beszélgetés megvárja az olvasót. Utána újabb E belép a házba: benti beszélgetés, két eredeti választás, majd bejárható belső sáv. Jobbra E → Akira VN-szobája, ahol gombokkal választható az ablak, az orvosi táska, a fénykép és a lefekvés. Az első éjszaka külön lezárásából explicit folytatás vezet a reggelhez.

Akira szobája és a rendelő VN-háttérként működik, járó Akira nélkül. Egér vagy fel/le + Enter választja a megfigyeléseket, a lefekvést és a két konzultációt. Reggel Miyakóval és két eredeti döntés → rendelő → nap tanulságai és Katsuro füzete → esti beszélgetés → második éjszakai „Hana” záróhang → az első nap vége. [Aktuális VN-kezelés](docs/ROOM_CLINIC_VN_REVIEW.md), [éjszaka története](docs/FIRST_NIGHT_IMPLEMENTATION_REVIEW.md), [első nap és hiányok](docs/FIRST_DAY_IMPLEMENTATION_REVIEW.md).

Az első nap végén a Második reggel · folytatás gomb (vagy új E/Space/Enter) továbbvisz az éjszakai füzethez, Miyako üzenetéhez és Hana első terápiás beszélgetéséhez. Két eredeti választás, keret nélküli Hana-portré változó arckifejezéssel és megismerés után frissülő karakterlap. [Hana-jelenet, források és hiányok](docs/HANA_FIRST_SESSION_REVIEW.md).

REVIEW / PLACEHOLDER: négy női ambient NPC, mozgás, kamera, eső, járható úthatárok, előtér-takarás, kapunál állapotbiztos átadás, híd és Miyako köszöntése. Az oldalirányú járás nyolc képkockás, az előre/hátra ciklus négyképkockás. Ez nem a teljes 10–15 perces történeti flow.

A korai cameók működnek: Hana a meleg bejáratnál felpillant, Kuroe áthalad a házközön, Shion a híd falusi oldaláról figyel és elfordul. Mindhárom REVIEW asset, névtábla és dialógus nélkül. [Hana és Shion részletei](docs/HANA_SHION_CAMEOS_REVIEW.md).

A párbeszédekben a partner balra, Akira jobbra jelenik meg keret nélkül. Hana öt, Miyako négy képi reakciót kapott. Az első két névtelen páciens eredeti, dekoratív felnőtt női portréja és reakciói is megjelennek. [Assetforrások, promptok és REVIEW státusz](docs/DIALOGUE_PORTRAITS_REVIEW.md).

Még hiányzik: teljes házbelső, végleges karakteranimáció és portrék, fénykép-CG, alvás animáció/hang és Hana jóváhagyott klinikai szövege/sorrendje. A szoba, a reggeli háttér és a rendelő REVIEW. Combat, inventory, route-rendszer és komplex save/load nincs megvalósítva.

- [Fejlesztési állapot](docs/PROGRESS.md)
- [Nyitás és Space-javítás](docs/CINEMATIC_V2_REVIEW.md)
- [Talajhoz igazítás](docs/DIALOGUE_GROUNDING_FIX_REVIEW.md)
- [Szövegdoboz rétegjavítása](docs/SUBTITLE_LAYER_FIX_REVIEW.md)

## Governance

A kreatív authority változatlan: [DECISION_LOG](docs/DECISION_LOG.md), [CREATIVE_BIBLE](docs/CREATIVE_BIBLE.md), [STORY_CANON](docs/STORY_CANON.md), [CHARACTER_BIBLE](docs/CHARACTER_BIBLE.md), [ART_DIRECTION_LOCK](docs/ART_DIRECTION_LOCK.md), [PIXEL_ART_PRODUCTION_DIRECTION](docs/PIXEL_ART_PRODUCTION_DIRECTION.md), [VISUAL_REFERENCE_INDEX](docs/VISUAL_REFERENCE_INDEX.md), [VISUAL_ASSET_USAGE_MATRIX](docs/VISUAL_ASSET_USAGE_MATRIX.md). A technikai működés nem jelent FINAL assetjóváhagyást.

## Korábbi 3D prototípus

A megőrzött 3D jelenetek, modellek, generátorok és tesztek az [archive/legacy_3d](archive/legacy_3d/README.md) alatt találhatók. A jelenlegi F5-ös játék nem tölti be őket. A régi README és állapotjelentés másolata is az archívumban maradt.
