# Tsukimori — Zárt Világ

Godot 4.x alapú 2.5D narratív RPG vertical slice.

## Aktuális állapot — 2026-09-22

Az első játszható hegyi szakasz technikai és animációs alapja **review-n átment**.
A kapun túli első falurész **Blockout 1.0** változata elkészült és review-ra kész.

Jelenlegi játszható ív:

**hegyi ösvény → első furcsa jel → Tsukimori-kilátópont → útjelző → kapu → első térbeli anomália („Szél?”) → első utca → Miyako találkozási tere**

## Már működő alapok

- Godot 4.x projektstruktúra
- Akira humanoid proxy v0.2
- Idle / WalkStart / Walk / WalkStop locomotion
- sebességhez igazított walk playback
- lágyabb testfordulás és finom body lean
- külön kabátmozgás a proxy rigben
- 3/4-es rendezett követőkamera
- területenkénti kamera-kompozíciók
- fix világirányú WASD — játék közben elfogadott irányítás
- Mountain Path Blockout 2.0
- ambient cédrusmozgás és finom ködmozgás
- papírcsík-furcsaság
- Tsukimori-kilátópont
- 月守村 — TSUKIMORI útjelző
- kapu előtti szirom/tér-anomália
- „Szél?” reakció
- Tsukimori első utcája hat házzal és két mellékutcával
- négy utcai lámpa és hat falusi NPC-hely
- Miyako első találkozásának kijelölt tere
- három falusi kamera-kompozíció
- minimális GameState flag-rendszer
- fejlesztői HUD + subtitle prototípus

## Review eredmény

**Mountain Path Animation Pass v0.2: PASSED**

A Blenderből generált Akira proxy, a Godot locomotion, a kamera, az ambient mozgás és a narratív trigger-sor hibamentesen végigfut a jelenlegi buildben.

Ez nem jelenti azt, hogy a karaktermodell, az animáció vagy az environment art FINAL. A jelenlegi állapot a következő terület fejlesztéséhez elfogadott működő alap.

## Irányítás

- W / A / S / D — mozgás
- a mozgás világirányú, a kamera nem téríti el a WASD irányait

## Aktuális review

### Tsukimori — Első utca Blockout 1.0

Elkészült:

- kapun túli első falurész játszható blockoutja;
- keskeny főutca és két oldalirányú mellékutca;
- hat hagyományos háztömeg, kerítések és négy lámpa;
- hat falusi NPC elhelyezési pontja;
- Miyako első találkozásának tere;
- három, a falusi környezethez igazított kamera-zóna.

Részletes review-leírás: [docs/FIRST_STREET_BLOCKOUT.md](docs/FIRST_STREET_BLOCKOUT.md)

Még nem került be végleges NPC-rutin, combat, inventory, route rendszer vagy final dialogue system.

## Asset szabály

Minden primitív vagy generált tesztasset státusza:

**PLACEHOLDER → BLOCKOUT → REVIEW → FINAL**

Semmi nem válik automatikusan FINAL assetté.
