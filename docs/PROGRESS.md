# Tsukimori — aktuális fejlesztési állapot

**Frissítve:** 2026-10-20. Technikai REVIEW; a LOCKED kreatív döntések változatlanok. A részletes korábbi napló: [PROGRESS_HISTORY_BEFORE_2026_10_20.md](PROGRESS_HISTORY_BEFORE_2026_10_20.md).

## Aktuális fázis
2.5D pixel-art vertical slice. Cél: az 1–10. nap végigjátszható, összefüggő változata, 120 napos adatmodellel. Jelenleg az érkezéstől a 3. nap esti teájáig fut összekötött történet.

## Állapot
| Elem | Státusz |
|---|---|
| Főmenü, szünet, beállítások, fejezetválasztó (10 belépő) | IMPLEMENTED |
| Nyitány (66 mp, autós v3) | IMPLEMENTED — REVIEW, Godot-ban még nem futtatva ([részletek](OPENING_V3_CAR_ARRIVAL.md)) |
| Miyako első találkozása, házbelső, első éjszaka, rendelő | IMPLEMENTED / képek REVIEW |
| 1. nap falubejárás (kattintásos térkép, visszalátogatás) | IMPLEMENTED |
| 2. nap: Hana → késő délutáni Miyako → éjszakai látogató | IMPLEMENTED / képek REVIEW |
| 3. nap: Shion → pecsét → délutáni falu (Ayame, Hana/Himiko-említés) → esti tea | IMPLEMENTED / szövegek és CG-staging REVIEW |
| GameState: 0. nap + 1–120, napszakok, események, látogatások | IMPLEMENTED infrastruktúra; történeti ütemező nincs |
| Időjárási anomália a 30. nap előtt | tiltott (API-korlát) |
| Szabad (WASD) mozgás | **kivezetve** → automatikus séta ([részletek](AUTOWALK_NO_WASD.md)), REVIEW, Godot-ban még nem futtatva; a falutérkép kattintásos |
| Akira szemüveg nélkül | **döntés rögzítve**; a meglévő portrék/CG-k ellenőrzése hátra van |
| 4–10. nap, Hetedik Éjszaka, Katsuro nyomozás, Himiko érkezése | MISSING |
| Mashiro jelenetek, moon_two_faces, Sayuri | MISSING (Mashiro/Ayame referenciák beérkeztek: [intake](REFERENCE_INTAKE_2026_10_20.md)) |
| Mentés/betöltés, napvégi továbblépés a tea után | MISSING |

## Tesztek
3. napi célzott suite-ok PASS (day3_village, seal, shion_session, village_walk, tea, chapter_select). Ismert adósság: a régi `vn_dialogue` és `interior` teszt fixture-je hibás (a tényleges kapu → híd → ház út a külön `current_entry_audit` tesztben PASS), kilépéskor 2–4 ObjectDB-figyelmeztetés. Források: [audit](WORK_HANDOFF_AUDIT_2026_10_19.md), [3. nap](DAY3_VILLAGE_REVIEW.md).

## Soron következő lépések (minden lépés külön jóváhagyással)
1. Döntések rögzítése — [DECISION_LOG](DECISION_LOG.md), 2026-10-20. ✔
2. Dokumentáció egységesítése (ez a változtatás). ✔
3. Nyitány v3: **✔ autós érkezés + parkolás implementálva (REVIEW, tesztelésre vár)**, buszos assetek archiválva; hátra: gyaloglás Miyako házáig filmes átvezetésként (`village_walk_REVIEW.png` kész, nincs bekötve).
4. **✔ WASD kivezetve** (automatikus séta, REVIEW, tesztelésre vár); a mozgásos tesztek átállítva; Akira-portrék szemüveg-ellenőrzése kész (lásd AUTOWALK_NO_WASD.md). Hátra: a két régi hibás teszt (`vn_dialogue`, `interior`) tartalmi javítása, és a Miyako-házhoz vezető séta képi átvezetése (`village_walk_REVIEW.png`).
5. Minimális verziózott mentés és napvégi továbblépés, majd a 4. nap (VI. fejezet, Katsuro-jegyzetek, Himiko). A Hetedik Éjszaka csak a 3–6. nap összhangja után; a szerkezet és a nem szexuális túlélési ág készül, explicit szexuális tartalom nem.

## Nyitott blokkolók
Ayame production CG és teljes alakos karakterlap · Mashiro képek hozzárendelése és importja · Himiko belépőszövege és stagingje · a Hetedik Éjszaka nem szexuális alternatívái · Katsuro ügyének szereplői és bizonyítékai · Sayuri önálló specifikációja. Részletek: [audit](WORK_HANDOFF_AUDIT_2026_10_19.md), [történeti kiegészítés](STORY_DIRECTION_ADDENDUM_2026_10_19.md).
