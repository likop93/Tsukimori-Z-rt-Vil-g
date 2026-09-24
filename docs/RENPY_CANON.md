# Történeti kánon és Godot-átültetés

**Történeti forrás:** a tulajdonos által 2026-09-24-én átadott `Tsukimori.rar` Ren’Py-projekt. A vizsgált archívum SHA-256 értéke: `834fb6caa9494e538a94eafb344f7e4e79e501b1c1f2e336525032e3f9a65c60`.

**A Ren’Py a történeti események, párbeszédek, döntések és route-szabályok kánonja.** A Godot a történet bejárható, térbeli és később harccal bővülő megvalósítása. A már jóváhagyott Godot-világot és faluelrendezést megtartjuk, ha a Ren’Py-jelenetekkel összeegyeztethető: egy hiányzó helyszínrészlet vagy apró leírásbeli különbség nem indokol automatikus pályaátrendezést. Ha valódi, a történet menetét érintő ellentmondás merül fel, előbb egyeztetjük a megoldást. Új történeti fordulatot vagy route-szabályt nem vezetünk be pusztán a Godot-pálya alapján.

A címkénkénti történeti sorrend, az állapotok és a következő jelenetek pontos átültetési jegyzéke: `docs/RENPY_GODOT_STORY_MAP.md`.


## Projektkánon-hierarchia

A Ren’Py-forrás ezt a fájlt **nem teszi magasabb prioritásúvá a már LOCKED tulajdonosi döntéseknél**. A teljes sorrend és konfliktuskezelés:

- `docs/STORY_CANON.md`
- `docs/DECISION_LOG.md`
- `docs/CREATIVE_BIBLE.md`
- `docs/CHARACTER_BIBLE.md`

Ha ez a Ren’Py-megfeleltetés egy LOCKED döntéssel ütközik, nem módosítjuk automatikusan a Godot-világot. Az ütközést dokumentálni kell, és csak kifejezett tulajdonosi döntés oldhatja fel.

## A Ren’Py-projektben ténylegesen elérhető fő út

`game/reworked_story.rpy` `start` címkéje → `game/canonical_html_story.rpy` prológus és I–VII. fejezet → első szabadidős szakasz → VIII. fejezet és Kuroe-jelenet → `game/romance_interchapter_v2.rpy` második szabadidős szakasza → „Új korszak” jelenet.

Az elnevezés ellenére a `canonical_html_story.rpy` **a feltöltött Ren’Py-játék része**, nem külön HTML-játék. A játékban a döntések affinitást, Akira fejlődési értékeit, kapcsolati állapotokat és történeti jelzőket módosítanak. A második szabadidős szakasz kapcsolati eseményei nem zárják ki automatikusan egymást.

A forrásban megőrzött `canonical_html_legacy_route_menu` jelenleg nem része a normál játékútnak. A `miyako_ix_v2.rpy` külön Miyako-IX címkéi és a Hana tűzoroszlánjának külön indítható bemutatója sem tekinthető automatikusan a normál út folytatásának; ugyanebben a Miyako-fájlban a `canonical_kuroe_sequence` **része** a fő útnak. E részekből csak a Ren’Py-útvonalak tisztázása után veszünk át új Godot-jelenetet. A fő út az „Új korszak” után még nem folytatódik; a harc nem működő rendszer a csomagban.

## A jelenlegi Godot-nyitány megfeleltetése

| Ren’Py-jelenet | Godot-állapot |
|---|---|
| Akira megérkezik a ködös hegyi faluba | Bejárható hegyi út és kapu; a Ren’Py prológusának szöveges jelenete még nincs átültetve. |
| A falusiak feltűnően figyelik Akirát | A falun végigvezető utcában időzített figyelő és összesúgó NPC-reakciók. |
| Katsuro házánál Miyako fogadja: „Dr. Akira. Már vártam.” | A térbeli kamera és Miyako néma üdvözlő animációja működik. A mondat és a történeti jelenet egyelőre a Ren’Py kánonban marad. |
| Miyako beengedi Akirát a házba; első beszélgetésük döntéshez vezet | A házbelső beszélgetés és a két választás későbbi, Godotba illő bemutatásra vár. A külön rendelőszárny jelenleg bejárható térbeli prototípus. |

**Térbeli egyeztetés:** a Ren’Py I. fejezete Katsuro házát „a falu egyik csendesebb részén” írja le, pontos patakhidat nem nevez meg. A jelenlegi Godot-világban a ház a falu csendes peremén, a híd után áll. Ez összeegyeztethető a történettel, ezért a jóváhagyott hidat, Shion falusi oldali házát és Miyako–Akira közös otthonát megtartjuk. A későbbi karakterotthonokat a történet alapján helyezzük el; lényegi ellentmondás esetén egyeztetünk, mielőtt a falut átrendeznénk.

## Az átültetés sorrendje

1. A jelenlegi Godot-világ animációs ritmusának fejlesztése: Miyako üdvözlése, falusi reakciók, kamera és visszafogott környezeti mozgás a meglévő proxykon.
2. Akira érkezésének, Miyako első beszélgetésének és az első éjszakának térbeli jelenetformája; a dialógusok és döntések csak az animációs jelenetnyelv kialakítása után kerülnek át.
3. Az első páciensek, kapcsolati rendszer és szabadidős szakaszok átvitele a Ren’Py feltételeinek megfelelően.
4. A külön körökre osztott harc prototípusa a történetbe illő helyen; a Ren’Py-ben szereplő harci sprite önmagában nem jelent kész harcrendszert.

Az archívumot nem másoljuk be a Godot-repóba; a kánon forrásváltozatát a fenti lenyomat azonosítja. Újabb Ren’Py-változat érkezésekor a megfeleltetést a tényleges új fő út alapján frissítjük.
