# Tsukimori — Zárt Világ

A jelenleg futó játék egy high-detail pixel-art 2D/2.5D narratív prototípus. F5 a főmenüt indítja. A „Játék indítása” innen vezet a 66 másodperces nyitásba: busz, Akira monológja, emléktöredék, leszállás, erdei séta, kapu. A kapunál visszakapod az irányítást; a híd és Miyako találkozása játékosvezérelt.

## Indítás

1. A teljes ZIP-et csomagold ki egy új mappába.
2. Godot 4.7.2 → Importálás → a gyökérben lévő project.godot.
3. Várd meg az importálást, majd F5 → Játék indítása.

A főmenü egérrel vagy nyilakkal és Enterrel kezelhető. Beállítások: hangerő és teljes képernyő; ezek a következő indításra is megmaradnak. Az Irányítás megnyitja a gombok leírását, a Kilépés bezárja a játékot. Esc visszalép az almenükből. Játékállás-mentés még nincs.

WASD / nyilak: séta. E: figyelés, továbbhaladás a helyszín kijáratánál, beszélgetés Miyakóval. Space / Enter: a nyitás szövegének gyorsítása, a mozgás átugrása nélkül. Esc: a nyitás kihagyása. F1: vezérlési segítség.

## Aktuális állapot

Miyako előtt E indítja az első VN-jelenetet. E / Space / Enter / bal kattintás kiírja az aktuális mondatot, majd továbblép. A beszélgetés megvárja az olvasót. Utána újabb E belép a házba: benti beszélgetés, két eredeti választás, majd rövid bejárható belső sáv. A karakter keret nélküli, átlátszó hátterű REVIEW kép. A beszélgetés után jobbra sétálva E indítja az első éjszaka szöveges átvezetését. A fejezet végén visszatérhetsz a főmenübe.

REVIEW / PLACEHOLDER: négy női ambient NPC, mozgás, kamera, eső, járható úthatárok, előtér-takarás, kapunál állapotbiztos átadás, híd és Miyako köszöntése. Az oldalirányú járás nyolc képkockás, az előre/hátra ciklus négyképkockás. Ez nem a teljes 10–15 perces történeti flow.

Még hiányzik: Hana/Kuroe/Shion jóváhagyott cameói, játszható házbelső, végleges karakteranimáció és hangjáték. Combat, inventory, route-rendszer és komplex save/load nincs megvalósítva.

- [Fejlesztési állapot](docs/PROGRESS.md)
- [Nyitás és Space-javítás](docs/CINEMATIC_V2_REVIEW.md)
- [Talajhoz igazítás](docs/DIALOGUE_GROUNDING_FIX_REVIEW.md)
- [Szövegdoboz rétegjavítása](docs/SUBTITLE_LAYER_FIX_REVIEW.md)

## Governance

A kreatív authority változatlan: [DECISION_LOG](docs/DECISION_LOG.md), [CREATIVE_BIBLE](docs/CREATIVE_BIBLE.md), [STORY_CANON](docs/STORY_CANON.md), [CHARACTER_BIBLE](docs/CHARACTER_BIBLE.md), [ART_DIRECTION_LOCK](docs/ART_DIRECTION_LOCK.md), [PIXEL_ART_PRODUCTION_DIRECTION](docs/PIXEL_ART_PRODUCTION_DIRECTION.md), [VISUAL_REFERENCE_INDEX](docs/VISUAL_REFERENCE_INDEX.md), [VISUAL_ASSET_USAGE_MATRIX](docs/VISUAL_ASSET_USAGE_MATRIX.md). A technikai működés nem jelent FINAL assetjóváhagyást.

## Korábbi 3D prototípus

A megőrzött 3D jelenetek, modellek, generátorok és tesztek az [archive/legacy_3d](archive/legacy_3d/README.md) alatt találhatók. A jelenlegi F5-ös játék nem tölti be őket. A régi README és állapotjelentés másolata is az archívumban maradt.
