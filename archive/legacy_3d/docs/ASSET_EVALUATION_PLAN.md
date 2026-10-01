# Godot Asset Evaluation Plan — Tsukimori

**Frissítve:** 2026-09-23

Cél: kész Godot assetekkel gyorsítani a munkát úgy, hogy a működő vertical slice-rendszereket és Tsukimori saját vizuális identitását ne írjuk felül.

## Tesztelési szabály

Minden külső asset először a már létező fejlesztői sandboxban kerül kipróbálásra:

`scenes/dev/asset_sandbox.tscn`

A sandbox tartalmaz:
- Tsukimorihoz közeli fényt és ködöt;
- ~1,82 m-es Akira méretreferenciát;
- külön `DropAssetsHere` node-ot.

Külső asset addig nem kerül a valódi hegyi/falusi jelenetbe, amíg:
1. méretarányban nem működik Akirával;
2. nem ütközik a jelenlegi kamera/player rendszerekkel;
3. anyagban/színben Tsukimori art directionjéhez igazítható;
4. licence és Godot-verzió kompatibilitása rendben van.

## Első tesztkör

### 1. Kominka Modular Home Pack Lite — ELSŐDLEGES
- Forrás: https://store.godotengine.org/asset/rice-studio-lab/kominka-modular-home-pack-lite/
- Hagyományos japán moduláris házak és kert-elemek.
- Lite kiadás: 24 GLB asset, Godot scene-ekkel és collisionnel.
- MIT licenc.
- Minimum Godot 4.5.2.
- Tsukimoriban: a jelenlegi házblockoutok fokozatos kiváltása, nem egyben történő teljes csere.
- A 2026.09.23-i ellenőrzéskor a kiadó a Store-ban a jelenlegi kiadást instabilnak jelölte; a platform csak macOS Compatibility renderer alatt tesztelt verziókat sorol fel. Addig nem kerül a projektbe, amíg az adott letöltés tartalma, licence, méretaránya és a Windows Godot import ellenőrizhető.

**Teszt:** 1 ház + 1 kerítés/kerti elem a sandboxban, Tsukimori saját fényével és ködével.

### 2. ScatterShot — ELSŐDLEGES
- 3D mesh/decal szóró addon.
- MIT licenc.
- Godot 4.5+.
- Tsukimoriban: fű, lehullott levelek, apró kövek, virágok, erdei talajrészletek.

**Teszt:** egy 8×8 m-es erdei/falusi felület 2–3 mesh réteggel; teljesítmény és vizuális ismétlődés ellenőrzése.

### 3. Tree3D — ELSŐDLEGES
- Forrás: https://github.com/JekSun97/gdTree3D
- Procedurális 3D fa-generátor és wind támogatás.
- MIT licenc.
- Godot 4.5+.
- Tsukimoriban: cédrusvariációk gyors gyártása, később a placeholder koronák kiváltása.
- GDExtension függőség; a már bejárható erdőnek működnie kell telepítés nélkül is.

**Teszt:** 3 eltérő cédrus sziluett, közös Tsukimori anyagpalettával.

### 4. Dialogue Manager 3 — ELSŐDLEGES, DE KÜLÖN RENDSZERTESZT
- Branching dialogue, editor-integráció, localization támogatás.
- MIT licenc.
- Godot 4.4+ Asset Library verzió.
- Tsukimoriban: Miyako és későbbi szereplők dialógusainak adatvezérelt kezelése, saját 2D portrés UI-val.

**Teszt:** csak egy izolált 3 soros Miyako-beszélgetés a sandboxban; a jelenlegi GameState marad a játékállapot forrása.

## Későbbre

### Terrain3D
Nagyobb hegyvidéki terekhez érdekes, de a vertical slice jelenlegi méretén feleslegesen nagy rendszer lehet.

### Phantom Camera
Erős filmes kamera-addon, de a saját directed camera rendszerünk már működik és review-n átment. Csak akkor érdemes elővenni, ha a későbbi cinematic staging valóban kinövi a jelenlegi rendszert.

### Stylized Nature MegaKit
CC0, 110+ stylizált természetmodell. Referenciának és ideiglenes environment dressinghez hasznos lehet, de vizuálisan erősen át kell szűrni, hogy Tsukimori ne váljon generikus "asset pack" világgá.

## Javasolt sorrend

**Kominka Lite → ScatterShot → Tree3D → Dialogue Manager 3**

Ennek oka, hogy jelenleg a legnagyobb minőségi ugrást a házak és az environment dressing adják. A dialógusrendszert csak akkor érdemes integrálni, amikor Miyako első jelenetének stagingje már stabil.

## Környezeti részletezés — 2026.09.23

Az első utcán a kockatetők helyett két lejtős tetőlap, gerinc és eresz, a házakon talapzat, faváz és papírablakok készültek. Miyako és Akira közös háza saját falárnyalatot és bejárati lépcsőt kapott. A cédrusok háromlépcsős koronát, az erdő utak menti, ütközés nélküli aljnövényzetet kaptak. A házak és a fák eredeti ütközői és helyei változatlanok. Ezek saját, helyben generált blockoutok: továbbra is cserélhetők bejáratott külső assetre a sandboxos próba után.

## Nem automatikusan telepítendő

Külső addon nem kerül közvetlenül a main vertical slice-ba csak azért, mert elérhető az Asset Store-ban. Először sandbox, utána kreatív/technikai review, és csak azután integráció.
