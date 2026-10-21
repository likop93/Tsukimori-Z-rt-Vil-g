# README — előző állapot (2026-10-20 előtt)

> Archivált másolat az áttekinthetőség kedvéért. A jelenlegi állapotot a gyökér `README.md` és a `PROGRESS.md` írja le. A hivatkozások a `docs/` mappából értendők.

# Tsukimori — Zárt Világ

**2026-10-14 · Falubejárás:** kattintható térképes helyszínválasztás, külön találkozás/belépés gombok, bármikor elérhető Otthon. Akirát ebben a szakaszban nem kell irányítani. Teszt: Fejezetválasztás → III. Falubejárás · Reina és a többiek. [Részletek](VILLAGE_DESTINATION_NAVIGATION_REVIEW.md).


A jelenleg futó játék egy high-detail pixel-art 2D/2.5D narratív prototípus. F5 a főmenüt indítja. A „Játék indítása” innen vezet a 66 másodperces nyitásba: busz, Akira monológja, emléktöredék, leszállás, erdei séta, kapu. A kapunál visszakapod az irányítást; a híd és Miyako találkozása játékosvezérelt.

## Indítás

1. A teljes ZIP-et csomagold ki egy új mappába.
2. Godot 4.7.2 → Importálás → a gyökérben lévő project.godot.
3. Várd meg az importálást, majd F5 → Játék indítása.

A főmenü egérrel vagy nyilakkal és Enterrel kezelhető. Beállítások: hangerő és teljes képernyő; ezek a következő indításra is megmaradnak. Az Irányítás megnyitja a gombok leírását, a Kilépés bezárja a játékot. Esc visszalép az almenükből. Játékállás-mentés még nincs.

Teszteléshez a Fejezetválasztás közvetlenül a nyitányhoz, falusi sétához, Miyako első találkozásához, első éjszakához, első rendelési naphoz vagy Hana fejezetéhez vezet. A kiválasztott rész új tesztállapotból indul, szükséges előzményekkel és az eredeti nulla pontos korábbi döntésekkel. [Belépési pontok és állapotkezelés](CHAPTER_SELECT_REVIEW.md).

WASD / nyilak: séta. Shift nyomva: futás. E: figyelés, továbbhaladás a helyszín kijáratánál, beszélgetés Miyakóval. Space / Enter: szöveg gyorsítása / tovább. Esc: szünetmenü (intróban kihagyás). Tab / jobb felső Menü gomb: szünet bármikor. F1: vezérlési segítség.

A szünetmenüben folytatás, karakterlapok és kapcsolati státusz, hangerő, teljes képernyő, irányítás és főmenübe visszatérés található. A világ és a párbeszéd szünet alatt megáll. [Menü és futás REVIEW](PAUSE_AND_RUN_REVIEW.md).

## Aktuális állapot

2026-10-12: Főmenü → Karaktergaléria · tervek. Hana, Shion és Kuroe teljes alakos hétköznapi ruhái, saját fejlődési iránya és három-három választható jelenetpróba. A galéria nem módosítja a játék állapotát és nem helyettesíti a fő történetet. Hana korai átalakulása is lassabb. [Kidolgozás és korlátok](WOMEN_CHARACTER_DEVELOPMENT_REVIEW.md).

Miyako horrorátalakulása lassabb: a jelenlegi fejezetekben legfeljebb finoman figyelő lesz. A teljes testi változás és mániákus mosoly későbbi történeti felfedésre van fenntartva.

2026-10-11: a pecsét után Miyako esti teázása következik, három személyes válasszal és új, horrorállapothoz illeszkedő esti ruhákkal. Közvetlenül: Fejezetválasztás → V. Esti tea. A karakterlap megőrzi a kimondott kapcsolati megállapodást és az új ruha előnézetét. Új REVIEW-kiegészítés, nem az eredeti forrás átirata. [Részletek, assetek, korlátok](MIYAKO_TEA_WARDROBE_REVIEW.md).

Miyako előtt E indítja az első VN-jelenetet. E / Space / Enter / bal kattintás kiírja az aktuális mondatot, majd továbblép. A beszélgetés megvárja az olvasót. Utána újabb E belép a házba: benti beszélgetés, két eredeti választás, majd bejárható belső sáv. Jobbra E → Akira VN-szobája, ahol gombokkal választható az ablak, az orvosi táska, a fénykép és a lefekvés. Az első éjszaka külön lezárásából explicit folytatás vezet a reggelhez.

Akira szobája és a rendelő VN-háttérként működik, járó Akira nélkül. Egér vagy fel/le + Enter választja a megfigyeléseket, a lefekvést és a két konzultációt. Reggel Miyakóval és két eredeti döntés → rendelő → nap tanulságai és Katsuro füzete → esti beszélgetés → második éjszakai „Hana” záróhang → az első nap vége. [Aktuális VN-kezelés](ROOM_CLINIC_VN_REVIEW.md), [éjszaka története](FIRST_NIGHT_IMPLEMENTATION_REVIEW.md), [első nap és hiányok](FIRST_DAY_IMPLEMENTATION_REVIEW.md).

Az első nap végén a Második reggel · folytatás gomb (vagy új E/Space/Enter) továbbvisz az éjszakai füzethez, Miyako üzenetéhez és Hana első terápiás beszélgetéséhez. Két eredeti választás, keret nélküli Hana-portré változó arckifejezéssel és megismerés után frissülő karakterlap. [Hana-jelenet, források és hiányok](HANA_FIRST_SESSION_REVIEW.md).

REVIEW / PLACEHOLDER: négy női ambient NPC, mozgás, kamera, eső, járható úthatárok, előtér-takarás, kapunál állapotbiztos átadás, híd és Miyako köszöntése. Az oldalirányú járás nyolc képkockás, az előre/hátra ciklus négyképkockás. Ez nem a teljes 10–15 perces történeti flow.

A korai cameók működnek: Hana a meleg bejáratnál felpillant, Kuroe áthalad a házközön, Shion a híd falusi oldaláról figyel és elfordul. Mindhárom REVIEW asset, névtábla és dialógus nélkül. [Hana és Shion részletei](HANA_SHION_CAMEOS_REVIEW.md).

A párbeszédekben a partner balra, Akira jobbra jelenik meg keret nélkül. Hana öt, Miyako négy képi reakciót kapott. Az első két névtelen páciens eredeti, dekoratív felnőtt női portréja és reakciói is megjelennek. [Assetforrások, promptok és REVIEW státusz](DIALOGUE_PORTRAITS_REVIEW.md).

A portrék egymás felé fordulnak; a páciensek mérete és elhelyezése igazított. A rendelőben külön orvosi Akira-portré látszik. Hana nagy történeti pillanatai öt külön jelenetképet kapnak (leülés, ajtó, jel, füzet, elköszönés), a megfelelő mondatoknál; ezek alatt a VN-portrék elrejtőznek. [Új képek, rendezés és pontos promptok](MEDICAL_AKIRA_HANA_CG_REVIEW.md).

Még hiányzik: teljes házbelső, végleges karakteranimáció és portrék, fénykép-CG, alvás animáció/hang és Hana jóváhagyott klinikai szövege/sorrendje. A szoba, a reggeli háttér és a rendelő REVIEW. Combat, inventory, route-rendszer és komplex save/load nincs megvalósítva.

- [Fejlesztési állapot](PROGRESS.md)
- [Nyitás és Space-javítás](CINEMATIC_V2_REVIEW.md)
- [Talajhoz igazítás](DIALOGUE_GROUNDING_FIX_REVIEW.md)
- [Szövegdoboz rétegjavítása](SUBTITLE_LAYER_FIX_REVIEW.md)

## Governance

A kreatív authority változatlan: [DECISION_LOG](DECISION_LOG.md), [CREATIVE_BIBLE](CREATIVE_BIBLE.md), [STORY_CANON](STORY_CANON.md), [CHARACTER_BIBLE](CHARACTER_BIBLE.md), [ART_DIRECTION_LOCK](ART_DIRECTION_LOCK.md), [PIXEL_ART_PRODUCTION_DIRECTION](PIXEL_ART_PRODUCTION_DIRECTION.md), [VISUAL_REFERENCE_INDEX](VISUAL_REFERENCE_INDEX.md), [VISUAL_ASSET_USAGE_MATRIX](VISUAL_ASSET_USAGE_MATRIX.md). A technikai működés nem jelent FINAL assetjóváhagyást.

## Korábbi 3D prototípus

A megőrzött 3D jelenetek, modellek, generátorok és tesztek az [archive/legacy_3d](../archive/legacy_3d/README.md) alatt találhatók. A jelenlegi F5-ös játék nem tölti be őket. A régi README és állapotjelentés másolata is az archívumban maradt.
