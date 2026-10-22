# TSUKIMORI — bevezető és korai napok, konkrét filmes CG shotlist V3
**Állapot:** vizuális rendezési és kreatív javaslat / REVIEW; nem bekötött játékasset.

**Döntés:** Akira a kocsival a falu széléig érkezik, otthagyja az autót, majd gyalog megy a falun/hídon át Miyakóhoz. A szereplőt a játékos nem mozgatja WASD-vel.

**Régi képek:** a korábbi öltönyös/szemüveges Akira és újratervezett Miyako képek kizárólag kompozíciós, fény-/hangulati referenciák, semmi több. Nem kerülhetnek be a játékba karakterassetként.

## Gyártási prioritások
- **P0:** szükséges első implementációs/identitásjavító munkák; első hullám: CG00_02, CG00_04/05, CG00_09, CG_EARLY_TEA; meglévőket nem újragenerálni, hanem ellenőrizni.
- **P1:** történetet gazdagító, de nem technikai blokkoló képek.
- **P2:** feltételes, további jóváhagyást igénylő jelenetek.

## Jelenetek sorrendben

### CG00_01 — Nedves hegyi szerpentin / autó külső
**Idő:** D0 intró · **Pri:** P0 · **Teendő:** `NEW` · **Hívó történetpont:** `intro_start`
- **Szereplők:** Akira csak az autóban
- **Kompozíció:** 16:9 távoli oldal- vagy hátulnézet, normál alkonyati fény, fa és aszfalt; arc nem kötelező
- **Meglévő:** Korábbi autós CG-k csak kompozíciós referencia
- **Kánon / QA:** Autó, nem busz; nincs szokatlan időjárás

### CG00_02 — Vezetés belső nézet
**Idő:** D0 intró · **Pri:** P0 · **Teendő:** `NEW` · **Hívó történetpont:** `intro_driving`
- **Szereplők:** Akira
- **Kompozíció:** oldalsó félközeli; egy kéz a kormányon, hátul ívben a falu első fényei
- **Meglévő:** Régi szemüveges/öltönyös képek NEM használhatók
- **Kánon / QA:** Azonos arcvonások, sötét kapucnis kabát, szemüveg nélkül

### CG00_03 — Ex: megszakadó emléktöredék
**Idő:** D0 intró · **Pri:** P1 · **Teendő:** `EDIT_OR_NEW` · **Hívó történetpont:** `intro_flashback`
- **Szereplők:** Akira + felnőtt volt partner azonosítatlanul
- **Kompozíció:** gyors közeli: megmarkolt kabát, torz tükörkép, eltört tárgy
- **Meglévő:** Korábbi exes storyboard hangulati referencia
- **Kánon / QA:** Trauma ne legyen grafikus szexuális erőszak; nem kapjuk meg az ex teljes arcát

### CG00_04 — Parkolás a falu szélén
**Idő:** D0 intró · **Pri:** P0 · **Teendő:** `NEW` · **Hívó történetpont:** `intro_park`
- **Szereplők:** Akira az autó mellett
- **Kompozíció:** tág kép: megálló kocsi a bekötőútnál, gyalogos ösvény jól látszik
- **Meglévő:** Korábbi parkolós illusztráció REVIEW
- **Kánon / QA:** A kocsi sohasem Miyako házánál áll

### CG00_05 — Kiszállás + orvosi táska
**Idő:** D0 intró · **Pri:** P0 · **Teendő:** `NEW` · **Hívó történetpont:** `intro_exit_car`
- **Szereplők:** Akira
- **Kompozíció:** térdtől fejig oldalbeállítás, kabát/kapucni/óra és táska látszik
- **Meglévő:** Korábbi öltönyös arc elvetendő
- **Kánon / QA:** Kabát, nem öltöny vagy köpeny

### CG00_06 — Faluba belépés gyalog
**Idő:** D0 intró · **Pri:** P0 · **Teendő:** `EDIT_OR_NEW` · **Hívó történetpont:** `intro_village_entry`
- **Szereplők:** Akira; max 1-2 környezeti nő, csak ha konzisztens
- **Kompozíció:** Akira hátulról, falukapu/főutca, női falusiak helyben, ne központi portrékként
- **Meglévő:** A régi falusi atmoszféra újrafelhasználható
- **Kánon / QA:** Nem indul előre név szerinti találkozás; nincs WASD

### CG00_07 — Főtér, első félreeső pillantások
**Idő:** D0 intró · **Pri:** P1 · **Teendő:** `REUSE_OR_NEW` · **Hívó történetpont:** `intro_square`
- **Szereplők:** Akira; csak a jelenleg helyben hiteles női ambient figurák
- **Kompozíció:** életképszerű, nem szereplőket felsorakoztató poszter
- **Meglévő:** A mostani térkép/helyszínhátterek REUSE
- **Kánon / QA:** Nem szerepelhet Mashiro/Himiko/Ayame idő előtt azonosíthatóan

### CG00_08 — Patak/híd, átkelés
**Idő:** D0 intró · **Pri:** P1 · **Teendő:** `NEW` · **Hívó történetpont:** `intro_bridge`
- **Szereplők:** Akira
- **Kompozíció:** az Akira által bejárt híd a Shion-ház falusi oldaláról a közös ház felé
- **Meglévő:** Meglévő híd és folyó referencia
- **Kánon / QA:** Shion háza a patak falusi oldalán, Miyako háza túlsó oldalon

### CG00_09 — Első találkozás Miyakóval
**Idő:** D0 intró · **Pri:** P0 · **Teendő:** `NEW` · **Hívó történetpont:** `miyako_first_dialogue`
- **Szereplők:** Akira + Miyako
- **Kompozíció:** összkép vagy közepes: Miyako háza előtt, pár lépés távolság, a nő finoman fogadja
- **Meglévő:** Jelenleg VN-kivágás / házkülső van
- **Kánon / QA:** A feltöltött két arc; Miyako eredeti sötét ruhája; kánoni köszöntés

### CG00_10 — Házba belépés, átmenet
**Idő:** D0 este · **Pri:** P1 · **Teendő:** `REUSE_OR_NEW` · **Hívó történetpont:** `home_first_entry`
- **Szereplők:** Akira + Miyako
- **Kompozíció:** egy széles, nyugodt közös belső kép
- **Meglévő:** Meglévő beltér REUSE
- **Kánon / QA:** Ház nem fogadó, nem ryokan

### CG00_11 — Akira szobája, régi fénykép
**Idő:** D0 éj · **Pri:** P0 · **Teendő:** `REUSE_VERIFY` · **Hívó történetpont:** `katsuro_first_clue_seen`
- **Szereplők:** Akira + fénykép (Katsuro csak jóváhagyott arccal)
- **Kompozíció:** félközeli kéz/asztal, fotó CG beazonosítása
- **Meglévő:** GitHub szerint már van valódi Akira–Katsuro fénykép REVIEW; ellenőrizendő
- **Kánon / QA:** Ne gyárts új Katsuro-arcot

### CG00_12 — Álmatlan első éjszaka
**Idő:** D0 éj · **Pri:** P0 · **Teendő:** `REUSE_VERIFY` · **Hívó történetpont:** `first_night_started`
- **Szereplők:** Akira
- **Kompozíció:** futon jobb oldalt, ablak balra, kék szürkület és lámpa
- **Meglévő:** akira_sleep_REVIEW.png már létezik
- **Kánon / QA:** Az alvó arc ugyanaz; nincs szellem fizikai megjelenés

### CG01_01 — Miyako halkan várja Akirát
**Idő:** D1 reggel · **Pri:** P1 · **Teendő:** `NEW` · **Hívó történetpont:** `first_day_morning`
- **Szereplők:** Akira + Miyako
- **Kompozíció:** közös étkező, hétköznapi fény, kettejük közt emberi távolság
- **Meglévő:** Meglévő közös otthon háttér/portrék
- **Kánon / QA:** Miyako M01; nincs átalakulás

### CG01_02 — Első konzultáció
**Idő:** D1 rendelés · **Pri:** P1 · **Teendő:** `REUSE_VERIFY` · **Hívó történetpont:** `clinic_patient_1`
- **Szereplők:** Akira + már létező első felnőtt páciens
- **Kompozíció:** profil kettős, orvosi szék/asztal, kéz gesztusa
- **Meglévő:** Korábbi klinika+páciens részletek REUSE
- **Kánon / QA:** Csak klinikán viselhet fehér köpenyt; ne változtass páciensnemet/diagnózist

### CG01_03 — Második konzultáció
**Idő:** D1 rendelés · **Pri:** P1 · **Teendő:** `REUSE_VERIFY` · **Hívó történetpont:** `clinic_patient_2`
- **Szereplők:** Akira + második felnőtt páciens
- **Kompozíció:** másik kameraszög, ne ugyanaz a beállítás
- **Meglévő:** Meglévő páciensportré REUSE
- **Kánon / QA:** Eredeti párbeszédek és sorrend marad

### CG01_04 — Térkép és helyszín-érkezés
**Idő:** D1 délután · **Pri:** P0 · **Teendő:** `REUSE` · **Hívó történetpont:** `village_map_open`
- **Szereplők:** Csak valóban jelen lévő figurák
- **Kompozíció:** Kattintható 9 kültéri hely + Otthon, helyszínképek
- **Meglévő:** Kattintásos térkép megvan
- **Kánon / QA:** WASD végleg kizárva

### CG01_05 — Első Shion- vagy Kuroe-találkozás — opcionális
**Idő:** D1 délután · **Pri:** P2 · **Teendő:** `NEW_LATER` · **Hívó történetpont:** `actual_first_meet_only`
- **Szereplők:** A helyszínhez valóban tartozó szereplő
- **Kompozíció:** egy-egy külön CG csak ha az adott találkozást kiválasztották
- **Meglévő:** Létező helyszín és portrait; vizsgálni
- **Kánon / QA:** Soha ne írja be automatikusan a találkozási flaget

### CG01_06 — Akira–Miyako közös beszélgetése
**Idő:** D1 este · **Pri:** P1 · **Teendő:** `NEW` · **Hívó történetpont:** `day01_evening_scene`
- **Szereplők:** Akira + Miyako
- **Kompozíció:** két ember természetesen ül ugyanabban a szobában
- **Meglévő:** VN jelenet már létezik
- **Kánon / QA:** A mai pszichológiai csattanót ne árulja el előre

### CG02_01 — Csendes reggeli / friss tea
**Idő:** D2 reggel · **Pri:** P1 · **Teendő:** `NEW_AFTER_APPROVAL` · **Hívó történetpont:** `d02_morning_miyako`
- **Szereplők:** Akira + Miyako
- **Kompozíció:** asztal két csészével, nyugodt reggeli oldalfény
- **Meglévő:** D2 writing pack REVIEW; meglévő háttér van
- **Kánon / QA:** Másnap, nem az esti tea újrarajzolása

### CG_EARLY_TEA — Miyako esti teázása
**Idő:** korai napok, a pecsét után · **Pri:** P0 · **Teendő:** `NEW` · **Hívó történetpont:** `miyako_tea_scene`
- **Szereplők:** Akira + Miyako
- **Kompozíció:** egész jelenetes, helyes beltéri helyszín, teáscsésze a kezében
- **Meglévő:** Van álló VN-portré, közös ülő CG hiányzik
- **Kánon / QA:** Az első párban M02 vagy M05, bármely engedélyezett esti ruhában identitás marad

### CG_EARLY_WATCHFUL — Miyako egy pillanatra elhallgat
**Idő:** korai napok, feltételes · **Pri:** P2 · **Teendő:** `NEW_OPTIONAL` · **Hívó történetpont:** `miyako_watchful_trigger`
- **Szereplők:** Miyako (Akira részben belátszik)
- **Kompozíció:** M06 közeli, félhomály, villódzás nélküli hosszú csend
- **Meglévő:** Kifejezéscserék részben már megvannak
- **Kánon / QA:** Nincs korai ezüst haj/kék szem/horror leleplezés

### CG_EARLY_01 — Folyosó és Katsuro dolgozójának zárt ajtaja
**Idő:** korai napok · **Pri:** P1 · **Teendő:** `REUSE_OR_NEW` · **Hívó történetpont:** `katsuro_locked_door_first`
- **Szereplők:** Akira, opcionálisan Miyako
- **Kompozíció:** sötét helyi folyosó, ajtó, zár, visszafogott beállítás
- **Meglévő:** Korábbi folyosó CG-k kompozíciós referencia; valódi háztopológia ellenőrizendő
- **Kánon / QA:** Nem egy fogadó; Miyako nem adja oda azonnal a jegyzeteket

### CG_EARLY_02 — Miyako féltékenységének első apró jele
**Idő:** korai napok · **Pri:** P2 · **Teendő:** `NEW_LATER` · **Hívó történetpont:** `first_jealousy_hint`
- **Szereplők:** Akira + Miyako
- **Kompozíció:** Miyako figyel, de nem más nővé átalakulva
- **Meglévő:** Korai reakciók V1; dramatizálva nem
- **Kánon / QA:** Csak ha játékos döntése erre utal; nem kötelező Day0

## További 3–7. napos backlog — NEM ebben a Work körben
- Ayame D3 első bolti találkozás: csak ha akkor ténylegesen megismerték egymást; Aoi boltjának meglévő belseje + valódi Ayame.
- Himiko D3–4 megjelenés, Mashiro D5–10 (alap D7): ne szerepeljenek az intró névtelen háttereiben felismerhető főszereplőként.
- D7: első Hetedik Éjszaka, Ayame ajtóban; külön műfaji és állapotfüggő CG — majd későbbi csomag.
- Első valóban rendellenes időjárás D30, az első 29 nap csak természetes eső/köd/csend.

## Csoportosítás / optimalizálás
1. Intro CG-kből csak **azokat kérjük újra, ahol Akira tényleg látható**, a meglévő autós tájkép kivágható/csiszolható.
2. A szobán belüli Miyako CG-hez egy jó *master composition* és eltérő reakció/tekintet változatok kellhetnek, nem 3 teljesen új helyszín.
3. Jelenet–VN váltásnál a teljes hátteret megőrizzük; a portrék ne kerüljenek automatikusan a CG fölé.
4. A termék képi iránya részletgazdag 2.5D pixel-cinematic; az anime stílusú fotóreferenciák NEM bizonyítják az export kész voltát.
5. Ne legyen olyan CG, amelyben Akira a fehér köpenyt viseli a faluban; Miyako arcát a feltöltött eredeti határozza meg.
