# Tsukimori — Zárt Világ

Godot 4.x alapú 2.5D narratív RPG vertical slice.

## Aktuális állapot — 2026-09-23

Az első játszható hegyi szakasz technikai és animációs alapja **review-n átment**.

A kapun túli első falurész:
- **kibővített utcai blockout elkészült**
- **Ambient Animation Pass 1 review-n átment**
- **Miyako első találkozásának stagingje elkészült — review-ra kész**

Jelenlegi játszható ív:

**hegyi ösvény → első furcsa jel → Tsukimori-kilátópont → útjelző → kapu → első térbeli anomália („Szél?”) → Miyako háza a patakparton → híd → falu**

## Már működő alapok

- Godot 4.x projektstruktúra
- Akira humanoid proxy v0.2
- automatikus procedurális Akira fallback, ha a Blender GLB nincs a gépen
- Idle / WalkStart / Walk / WalkStop locomotion
- fallback humanoid walk / idle / coat motion
- sebességhez igazított walk playback
- lágyabb testfordulás és finom body lean
- 3/4-es rendezett követőkamera
- területenkénti kamera-kompozíciók
- fix világirányú WASD
- Mountain Path Blockout 2.0
- ambient cédrus- és ködmozgás
- papírcsík-furcsaság
- Tsukimori-kilátópont
- 月守村 — TSUKIMORI útjelző
- kapu előtti szirom/tér-anomália
- „Szél?” reakció
- Tsukimori kibővített falurésze tizennégy házzal és négy mellékutcával
- patak és járható híd a falu bejáratánál; Miyako és Katsuro háza a közeli parton, Shioné a túlparton, Hana Miyako szomszédságában
- hat animált fényű utcai lámpa
- mozgó textil-, szirom- és növényproxyk
- nyolc animált humanoid falusi proxy
- Miyako külön humanoid proxyja Katsuro házának bejáratánál
- három falusi kamera-kompozíció
- az első találkozás külön kameraképe és a kánon szerinti első mondata
- minimális GameState flag-rendszer
- fejlesztői HUD + subtitle prototípus

## Review eredmény

**Mountain Path Animation Pass v0.2: PASSED**

A hegyi út stabil alap.

### Aktuális review

**Tsukimori — Miyako első találkozása**

Most a megszólítás ritmusát, a patakparti házak térbeli viszonyát, a közös kameraképet és a hídon át vezető utat vizsgáljuk. A részleteket a `docs/MIYAKO_FIRST_ENCOUNTER.md` és a `docs/VILLAGE_LAYOUT.md` tartalmazza.

## Godot asset stratégia

Külön shortlist készült:

`docs/GODOT_ASSET_SHORTLIST.md`

Amikor a jelenet igényli, első körben vizsgálandó:
- Kominka Modular Home Pack
- Tree3D
- ScatterShot
- Dialogue Manager 3

Az asseteket először külön tesztjelenetben próbáljuk ki. Nem cserélünk le működő rendszert csak azért, mert van kész plugin.

## Irányítás

- W / A / S / D — mozgás
- a mozgás világirányú, a kamera nem téríti el a WASD irányait

## Asset szabály

Minden primitív vagy generált tesztasset státusza:

**PLACEHOLDER → BLOCKOUT → REVIEW → FINAL**

Semmi nem válik automatikusan FINAL assetté.
