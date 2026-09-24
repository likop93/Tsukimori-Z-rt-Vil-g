# Történeti kánon és Godot-átültetés

**Fő történeti forrás:** a tulajdonos által 2026-09-24-én átadott `Tsukimori.rar` Ren’Py-projekt. A vizsgált archívum SHA-256 értéke: `834fb6caa9494e538a94eafb344f7e4e79e501b1c1f2e336525032e3f9a65c60`.

Ha a Godot-prototípus jelenete, párbeszéde vagy helyszínleírása eltér a Ren’Py-történettől, **a Ren’Py az irányadó**. A Godot a történet bejárható, térbeli és később harccal bővülő megvalósítása. Új történeti fordulatot vagy route-szabályt nem vezetünk be pusztán a Godot-pálya alapján.

## A Ren’Py-projektben ténylegesen elérhető fő út

`game/reworked_story.rpy` `start` címkéje → `game/canonical_html_story.rpy` prológus és I–VII. fejezet → első szabadidős szakasz → VIII. fejezet és Kuroe-jelenet → `game/romance_interchapter_v2.rpy` második szabadidős szakasza → „Új korszak” jelenet.

Az elnevezés ellenére a `canonical_html_story.rpy` **a feltöltött Ren’Py-játék része**, nem külön HTML-játék. A játékban a döntések affinitást, Akira fejlődési értékeit, kapcsolati állapotokat és történeti jelzőket módosítanak. A második szabadidős szakasz kapcsolati eseményei nem zárják ki automatikusan egymást.

A forrásban megőrzött `canonical_html_legacy_route_menu` jelenleg nem része a normál játékútnak. A `miyako_ix_v2.rpy` kibővített jelenetei és a Hana tűzoroszlánjának külön indítható bemutatója sem tekinthető automatikusan a normál út folytatásának. E részekből csak a Ren’Py-útvonalak tisztázása után veszünk át új Godot-jelenetet. A fő út az „Új korszak” után még nem folytatódik; a harc nem működő rendszer a csomagban.

## A jelenlegi Godot-nyitány megfeleltetése

| Ren’Py-jelenet | Godot-állapot |
|---|---|
| Akira megérkezik a ködös hegyi faluba | Bejárható hegyi út és kapu; a Ren’Py prológusának szöveges jelenete még nincs átültetve. |
| A falusiak feltűnően figyelik Akirát | A falun végigvezető utcában időzített figyelő és összesúgó NPC-reakciók. |
| Katsuro házánál Miyako fogadja: „Dr. Akira. Már vártam.” | A találkozás első mondata és kamerája működik; a ház belső történeti jelenete még nincs átültetve. |
| Miyako megmutatja a házat és a rendelőt; első beszélgetésük döntéshez vezet | A rendelő térbeli prototípusa megvan, a Ren’Py-jelenet és a választás Godotban még hiányzik. |

**Térbeli egyeztetés:** a Ren’Py I. fejezete Katsuro házát „a falu egyik csendesebb részén” írja le, pontos patakhidat nem nevez meg. A jelenlegi Godot-blockoutban a ház a falu szélén, a híd után áll; ez csak akkor maradhat így, ha a további jelenetekkel összeegyeztethető. A korábban jóváhagyott híd, Shion falusi oldali háza és Miyako–Akira közös otthona egyelőre bejárható térbeli értelmezés, nem a Ren’Py-szöveget felülíró új kánon. A végleges karakterotthonokat a jelenetek alapján rögzítjük.

## Az átültetés sorrendje

1. Akira érkezésétől Miyako első beszélgetéséig a Ren’Py jeleneteinek, választásainak és állapotváltozásainak pontos megfeleltetése.
2. Ugyanezen jelenetsor Godotban való bejárható és párbeszédes megvalósítása; a mozgásból a VN-beszélgetésbe, majd vissza vezető átmenettel.
3. Az első páciensek, kapcsolati rendszer és szabadidős szakaszok átvitele a Ren’Py feltételeinek megfelelően.
4. A külön körökre osztott harc prototípusa a történetbe illő helyen; a Ren’Py-ben szereplő harci sprite önmagában nem jelent kész harcrendszert.

Az archívumot nem másoljuk be a Godot-repóba; a kánon forrásváltozatát a fenti lenyomat azonosítja. Újabb Ren’Py-változat érkezésekor a megfeleltetést a tényleges új fő út alapján frissítjük.
