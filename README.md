# Tsukimori — Zárt Világ

Godot 4.x alapú 2.5D narratív RPG vertical slice.

## Aktuális állapot — 2026-09-23

Az első játszható hegyi szakasz technikai és animációs alapja **review-n átment**.

A kapun túli első falurész:
- **Blockout 1.0 elkészült**
- **Ambient Animation Pass 1 implementálva**
- review-ra kész

Jelenlegi játszható ív:

**hegyi ösvény → első furcsa jel → Tsukimori-kilátópont → útjelző → kapu → első térbeli anomália („Szél?”) → első utca → Miyako találkozási tere**

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
- Tsukimori első utcája hat házzal és két mellékutcával
- négy animált fényű utcai lámpa
- mozgó textil-, szirom- és növényproxyk
- hat animált humanoid falusi proxy
- Miyako külön humanoid placement proxyja
- három falusi kamera-kompozíció
- minimális GameState flag-rendszer
- fejlesztői HUD + subtitle prototípus

## Review eredmény

**Mountain Path Animation Pass v0.2: PASSED**

A hegyi út stabil alap.

### Aktuális review

**Tsukimori — First Street Ambient Animation Pass 1**

Most azt vizsgáljuk, hogy a házak, NPC-k és kamera jobban működnek-e egy már mozgó, lakott környezetben.

## Godot asset stratégia

Külön shortlist készült:

`docs/GODOT_ASSET_SHORTLIST.md`

Első körben vizsgálandó:
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
