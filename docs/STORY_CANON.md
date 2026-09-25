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


## 7. 2.5D történeti átdolgozás

A 2.5D cinematic narrative verzióhoz külön jóváhagyott történeti átdolgozás tartozik:

- `docs/TSUKIMORI_2_5D_STORY_REWORK.md`

A dokumentumban **APPROVED** vagy **LOCKED** státuszú döntések a 2.5D verzióban elsőbbséget élveznek a régi Ren'Py történeti megoldásokkal szemben, ha a kettő ütközik.

A **PROPOSED / nyitott** elemek még nem írják felül a korábbi kánont, és nem implementálhatók végleges történeti tényként.

Kiemelt 2.5D szerkezeti irány:
- Akira korábbi bántalmazása megmarad;
- Katsuro hívta vissza Tsukimoriba;
- a női karakterekkel való ismerkedés viszi előre az első nagy történeti szakaszt;
- a Mélység későbbi esemény;
- az első nagy játékrész Akira végleges emlékezet-visszatéréséig tart;
- a memória-visszatérés után a route-ok az addigi döntések alapján nyílnak szét;
- a Loft-szál korán, háttérmegfigyelésként van jelen, nem késői akciós becsapódásként;
- a többpartneres/hárem route csak karakterhű, őszinte és konszenzuális formában működhet, és nem minden karakterrel/kombinációban elérhető.
