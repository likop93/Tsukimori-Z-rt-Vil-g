# Tsukimori — Story Canon

**Verzió:** 1.0  
**Státusz:** LOCKED governance  
**Dátum:** 2026-09-24

## 1. Kánonhierarchia

A projekt történeti döntéseinek prioritása:

1. **Kifejezett tulajdonosi döntés**
2. **LOCKED döntés a `docs/DECISION_LOG.md` fájlban**
3. **Jóváhagyott történeti kánon ebben a dokumentumban**
4. **A jelenlegi Ren'Py fő út történeti eseményei, dialógusai, választásai és route-szabályai**
5. **Godot blockout / implementációs ötlet**
6. **Korábbi, már felülírt vagy legacy változat**

Egy alacsonyabb szintű forrás nem írhat felül magasabb szintű, már LOCKED döntést.

## 2. A Ren'Py szerepe

A Ren'Py-projekt elsődleges történeti forrás:
- események;
- karakterkapcsolatok;
- fő dialógusok;
- választások;
- affinitás/kapcsolati állapotok;
- route-feltételek;
- fontos történeti fordulatok.

A Ren'Py **nem automatikus pályaterv, kamera-terv vagy térkép**.

A Godot-verzió a történet bejárható, térbeli narratív RPG-megvalósítása. Emiatt:
- egy hiányzó Ren'Py helyszínrészlet nem tesz hibássá egy jóváhagyott Godot térbeli döntést;
- a Godot környezeti történetmesélést, bejárást, kamerát és játékritmust adhat a jelenetekhez;
- a már jóváhagyott térbeli világépítés megmarad, ha nem mond ellent a történetnek.

## 3. Eltéréskezelés

Ha Ren'Py és Godot között valódi történeti ellentmondás jelenik meg:

1. ne módosíts automatikusan LOCKED Godot-elemet;
2. dokumentáld az ütközést;
3. különítsd el a történeti és a térbeli problémát;
4. a tulajdonosi döntés zárja le a kérdést;
5. a döntés kerüljön be a `DECISION_LOG.md` fájlba.

## 4. Godot kreatív szabadsága

Godotban önállóan tervezhető, ha nem sérti a kánont:
- házak és utak pontos elhelyezése;
- bejárható terek;
- híd/patak;
- kamera;
- jelenet staging;
- exploration ritmus;
- környezeti narratíva;
- fény/hang;
- interakciók;
- vizuális átmenetek;
- VN-jelenetből bejárható jelenetbe való adaptáció.

## 5. Jelenlegi térbeli kánon

LOCKED:
- Shion háza a patak falusi oldalán;
- a patakhíd;
- Miyako és Akira közös otthona a túlpart távolabbi háza;
- a rendelőszárny a közös házhoz tartozik;
- a jelenlegi falusi és erdei útstruktúra megmarad, amíg nincs kifejezett tulajdonosi módosítás.

## 6. Külön források

A részletes Ren'Py-forrás és technikai megfeleltetés:
- `docs/RENPY_CANON.md`
- `docs/RENPY_GODOT_STORY_MAP.md`

Ezek a források a jelen dokumentum hierarchiája szerint értelmezendők.
