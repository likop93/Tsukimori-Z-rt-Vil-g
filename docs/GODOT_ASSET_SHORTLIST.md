# Godot Asset shortlist — Tsukimori

Cél: a saját irányításunk és art direction megtartása mellett olyan kész Godot asseteket/addonokat használni, amelyek ténylegesen időt spórolnak.

## Első körben erősen érdekes

### Kominka Modular Home Pack
- traditional Japanese home / garden modular 3D pack
- nagyon jó illeszkedés Tsukimori falusi környezetéhez
- Lite csomag: MIT
- Godot 4.5.2+
- statikus assetek: az animációt, szelet, füstöt, vizet továbbra is nekünk kell hozzáadni
- használat: első utca házblockoutjainak fokozatos lecserélése

**Státusz:** HIGH PRIORITY — vizuális próba szükséges, nem automatikus teljes csere.

### Tree3D
- procedurális 3D fa generátor
- Godot 4.5+
- MIT
- használat: cédrusvariációk és a hegyi/falusi növényzet gyorsabb előállítása

**Státusz:** HIGH PRIORITY — külön tesztjelenetben próbáljuk ki.

### ScatterShot
- mesh/decal szóró addon
- Godot 4.5
- MIT
- használat: fű, apró kövek, lehullott levelek, virágok, erdei és falusi részletek gyors elhelyezése

**Státusz:** HIGH PRIORITY — environment dressinghez.

### Dialogue Manager 3
- nonlinear dialogue addon
- Godot 4.4+
- MIT
- editoron belüli dialógusírás, változók, localization támogatás
- saját UI-val használható, ezért illeszthető a 2D portrés dialógusunkhoz

**Státusz:** HIGH PRIORITY — Miyako-jelenet előtt külön sandbox teszt.

## Érdekes, de nem most

### Terrain3D
- nagy teljesítményű szerkeszthető terrain rendszer
- Godot 4.4+
- GDExtension, MIT
- terrain sculpting, textúrafestés, foliage instancing, LOD
- a jelenlegi vertical slice-hoz még túl nagy rendszer lehet

**Státusz:** LATER EVALUATION — akkor, amikor a hegy és a falu közötti nagyobb tereket véglegesítjük.

### Phantom Camera
- rendezett 3D kamera addon
- Godot 4.4+
- MIT

A saját directed camera rendszerünk már review-n átment, ezért ezt nem cseréljük le csak azért, mert létezik plugin.

**Státusz:** HOLD — csak akkor próbáljuk ki, ha a későbbi cinematic staging túl bonyolult lesz a saját rendszerünkhöz.

## Referenciának / tanulásra

### Procedural Forest Demo
- stylized forest sandbox
- wind-reactive foliage, dynamic grass, procedural terrain, biome scattering
- CC-BY-4.0

**Státusz:** REFERENCE — elsősorban megoldási ötletekhez.

## Asset-beemelési szabály

1. Új asset először külön tesztjelenetbe kerül.
2. Nem írhatja felül automatikusan a működő kamera- vagy player-rendszert.
3. Licencet minden esetben ellenőrizzük.
4. Art direction szempontjából újramaterialozható / átszínezhető legyen.
5. Csak az marad a projektben, ami valóban időt spórol vagy minőséget emel.
6. A végleges Tsukimori ne nézzen ki "asset flipnek": a kész asseteket saját világítással, anyagokkal, elrendezéssel és animációval egységesítjük.
