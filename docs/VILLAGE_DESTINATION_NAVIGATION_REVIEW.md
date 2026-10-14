# Falubejárás — kattintásos navigáció V1

2026-10-14 · IMPLEMENTED / REVIEW · tulajdonosi korrekció.

## Mi változott

A rendelés utáni falubejárás helyszínválasztós lett. Belépéskor térkép nyílik; a kilenc kültéri helyszín és az Otthon közvetlenül kattintható. A vázlatos összeköttetések a meglévő faluszerkezetet jelzik, nem új földrajzi kánont. Az aktuális hely arany jelölést kap. A helyszínváltás rövid, szüneteltethető áttűnés.

Minden kültéri helyen állandó Térkép / Főtér / Hazamegyek gomb van. A helyi találkozás és később a belső tér külön gombbal nyílik. M nyitja/zárja a térképet; a gombok billentyűzettel is bejárhatók. A helyszínekhez nem kell rejtett közelségi pontot vagy járható sávot keresni. Az új képernyő gombjai csak az előző kattintás/Enter/E elengedése után élesednek.

Akira járó sprite-ja a falubejárás alatt rejtett, a kézi mozgatása és scripted_axis értéke tiltva/nullázva. Nem lép át épületen, NPC-n vagy a háttér perspektíváján. A meglévő helyszínképek, álló falusi figurák, keret nélküli VN-portrék és három épületbelső megmaradnak. Új karakterdizájn vagy generált kép nem készült. A nyitány korábbi mozgásos szakaszai és a folyosói cinematic külön rendszerek, ebben a változtatásban nem kerültek át térképes irányításra.

## Hazatérés és állapot

Korábbi akadály: az esti folytatáshoz mind a nyolc helyszíni találkozás kellett, és a híd végének kis interakciós pontját kellett elérni. Ez megszűnt.

Az Otthon nulla, részleges vagy teljes bejárás után is elérhető. Nappali közösotthon-háttér jelenik meg, ugyanazzal a meglévő képpel, amely a reggeli jelenetben szerepel. A hazalépés önmagában nem zárja le a délutánt. Vissza lehet térni a faluba, vagy külön a **Lezárom a délutánt · esti beszélgetés** gomb indítja Miyako meglévő esti jelenetét.

- A meglévő találkozási flagek kizárólag a nyugtázott párbeszédből keletkeznek.
- `village_tour_returned_home`: az esti folytatás választásakor igaz.
- `village_tour_complete`: továbbra is csak nyolc ténylegesen teljesített találkozás után, az esti folytatáskor igaz.
- Korai hazatérés nem talál ki Reina/Aoi/Sora/Ritsu találkozást, nem old fel rejtett személyazonosságot, nem ad affinitást vagy horrorértéket.
- A történet folytathatósága már nem függ a teljes bejárás jelzőjétől. A meglévő esti párbeszéd és első napot lezáró esemény marad.

Az esti továbblépés lezárja az adott délutánt; a ki nem választott találkozások nem lesznek automatikusan későbbre átütemezve. A többnapos szabad bejárás még külön fejlesztés.

## Fájlok

- `scripts/opening/village_walk_director.gd`: meglévő belépési útvonal, új place/map/travel/home/dialogue/interior állapotok; régi közelségi navigáció eltávolítva.
- `scripts/ui/village_map.gd`: kattintható célpontok, jelenlegi hely, látogatási állapot és közvetlen Otthon.
- `scripts/opening/first_night_director.gd`: a visszatérés már nem állít be hamis teljes-bejárási flaget.
- `scripts/ui/main_menu.gd`, `scripts/ui/pause_menu.gd`: friss irányítási segítség.
- Helyszín- és történetadatok: a meglévő `village_layout.json`, `village_interiors.json`, `village_tour.json`, változatlan képi és történeti forrásokkal.

## Ellenőrzés

Godot 4.7.2 stable / Compatibility, valódi grafikus futás:

- `tests/ui/village_walk_regression.tscn`: egérkattintások a Godot GUI-n keresztül; minden célpont, nyolc egyszeri találkozás, három belső, korai/részleges/teljes hazatérés; gombok; M; szünet alatt tiltott utazás és megálló áttűnés; láthatatlan/mozdulatlan Akira; korai esti folytatásból első nap lezárása. `review/map_navigation_regression.log`: PASS.
- `tests/ui/night_day_regression.tscn`: első éjszaka (folyosóval és nélküle), rendelő, teljes térképes bejárás, esti folytatás. `review/map_night_day_regression.log`: PASS.
- `tests/ui/chapter_select_regression.tscn`: fejezetválasztó, a falu checkpointja térképpel indul. `review/map_chapter_select.log`: PASS.
- `tests/ui/village_tour_merge_regression.tscn`: találkozások, karakterlapok és esti kapcsolódás. `review/map_tour_merge.log`: PASS.

Képi ellenőrzés: `review/navigation_map_REVIEW.png`, `navigation_home_REVIEW.png`, `navigation_school_REVIEW.png`, `navigation_controls_REVIEW.png`, `navigation_vn_*_REVIEW.png`. A sikeres futásokban nincs parse/runtime hiba; a korábbról ismert 2–4 ObjectDB kilépési figyelmeztetés néhány teszt lezárásánál megmarad.

A térkép jelenleg áttekinthető, sematikus helyszínválasztó. Festett térkép és helyszínenként külön Akira-érkezési animáció még nincs; a hibás járóciklust nem használja átvezetésként sem. A korábbi Sora/Ritsu production assethiányok változatlanok.

Csomagellenőrzés: külön kicsomagolt projekt importja és főmenüje elindult; a kattintásos regresszió ott is PASS (`review/map_clean_runtime.log`). A teszt az áttűnés és a kezelőszervek tényleges elkészültét várja meg, nem fix fél másodpercet; lassabb első képkockák mellett is determinisztikus.
