# Harmadik nap — délutáni falu, Ayame és Himiko előkészítése
**Dátum:** 2026-10-20. **Státusz:** működő, tesztelt REVIEW egység; új összekötő szöveg és ideiglenes CG-staging.
Kiinduló main: `1a02a6a` (audit; alkalmazáskódja a `ccf6fbc` állapot).

## Mi működik
A meglévő **Shion-konzultáció → pecsét → délutáni térképes falubejárás → hazatérés → Miyako esti tea** összefüggően fut.
A pecsét végén a „Délután · vissza a faluba” gomb nyitja a már meglévő térképet. A helyszíneket szabad sorrendben lehet felkeresni. A Hazamegyek nem kényszerít találkozásra; otthon az Esti folytatás a változatlan tea-jelenetet indítja.

- Ayame a boltban külön megszólítható. Aoi marad a bolt saját szereplője; ha még nem találkoztunk vele, az ő első bemutatkozása előzi meg Ayamét.
- Ayame két hétköznapi válasza olvasóvezérelt. A név/ismeretség és az esemény a záró mondat tudomásulvétele után kerül a meglévő GameState-be. A választás a completed_events adott bejegyzésében megmarad.
- A piactéren Hana röviden megemlíti nővérét, Himikót és készülő érkezését. Ez nem Himiko fizikai jelenléte, nem `met_himiko`, és nem rögzít önkényesen pontos érkezési napot.
- A két új esemény csak a 3. nap délutánján, a pecsét után, saját helyén érhető el; külön egyszeri eseményazonosítót kapott. Hazatérés nem teljesíti a kihagyott találkozást.
- A 3. napi visszatérés nem jelöli utólag teljesítettnek az első napi falubejárást. A tartós ismeretség és a naphoz kötött látogatás külön marad.
- Akira a pecsét után az orvosi, zöld jobb szemes portréval jelenik meg. A bolti kompozícióban hátulról látszik, az eredeti forrás szerint.
- Nincs kitalált affinitáspont, horrorérték, automatikus romantikus elköteleződés, korai időjárási anomália vagy Miyako-átalakulás.

## Valós fájlok
- `scripts/opening/hana_day_director.gd`: pecsét utáni belépő és tea előtti visszaadás.
- `scripts/opening/village_walk_director.gd`: a meglévő térkép 3. napi eseményei. Nincs új térkép-, GameState- vagy VN-rendszer.
- `data/home_day3/village_events_REVIEW.json`: két külön esemény, feltételek, szövegek, Ayame-válaszok. A `source` mező megjelöli az új REVIEW szerzői adaptációt.
- `assets/home_day3/ayame_shop_source_REVIEW.png`: a tulajdonosi bolti kép byte-azonos példánya; felső részének AtlasTexture megjelenítése. A beégetett UI ki van zárva a látható képből.
- `tests/ui/day3_village_regression.gd`: két Ayame-ág, Aoi első/korábbi ismeretség, szünet, ismétlés tiltása, teljes Shion–pecsét–falu–tea út.
- `tests/ui/seal_regression.gd`: frissített átvezetés, közvetlen hazatérés találkozás nélkül.
- `tests/ui/shion_session_regression.gd`: a törékeny „pontosan két naplóesemény” helyett a tényleges emlékek, választott/ki nem választott dallam és beleegyezési esemény tartalmi ellenőrzése.

## REVIEW / hiányzó tartalom
A bolti bemutatkozás és Hana összekötő mondatai **új REVIEW szövegek**, nem az alaptörténetből idézett, véglegesített oldalak. Nem írják át a korábbi Shion-, pecsét- vagy tea-dialógust.
Ayame ideiglenesen a kapott CG-kompozícióban jelenik meg. UI nélküli production CG, átlátszó teljes alak, reakciók, menübeli karakterlap és teljes kapcsolati út még hiányzik. Nem készült új design.
Mashiro 29 forrásképe és Ayame két képe a [referencialeltárban](REFERENCE_INTAKE_2026_10_20.md) elérhető. Mashiro route-ja és animációja ettől még nincs implementálva; a titkos kivétel küszöbeit nem rögzítettük.
Himiko tényleges érkezése és képi stagingje a következő történeti egység feladata. A 4–6. nap még nincs kész. A tea után továbbra is a korábbi lezárás van; nincs önkényesen megírt negyedik nap.
Az első Hetedik Éjszakát csak a 3–6. nap történeti összhangja után szabad bekötni. A 7/14/21/28. napi események és a 28. napi halálfeltétel nem kerültek implementálásra.

## Tényleges teszteredmények
Godot 4.7.2 stable, Compatibility, grafikus futás; külön tiszta munkapéldány, saját tesztprofillal. **6 célzott suite PASS:** day3_village (mindkét válasz), seal, shion_session (4 döntéskombináció), village_walk (első nap), tea (9 kombináció), chapter_select.
A kezdeti editor-import a sandboxban safe-save hibát jelentett; az engedélyezett ismétlés hibamentes. Az eredeti napló és az ismétlés is megmaradt. A célzott runtime naplókban nincs parse/runtime hiba.
Bizonyítékok: [eredmények](day3_review_2026_10_20/test_results.json), [Ayame futási kép](day3_review_2026_10_20/day3_ayame_REVIEW.png) és a mappa naplói. A bolti feliratot 640×360-as futási képen is ellenőriztük; a beégetett eredeti felirat/gomb nem látszik.
Az audit két további régi, kézzel felállított `vn_dialogue` és `interior` tesztjét ez az egység nem javította. A korábbi hibáikat nem nevezzük utólag PASS-nak. A külön valódi belépési út tesztje az auditban PASS volt.

## Kipróbálás
Főmenü → Fejezetválasztó → **V. Shion · első konzultáció**. Konzultáció, majd pecsét után **Délután · vissza a faluba**. Bolt: előbb Aoi, ha még ismeretlen, majd a teákat rendező nő. Piactér: Hana. **Hazamegyek → Esti folytatás**: Miyako teája.
Az összekötés a normál történeti út része is; a fejezetválasztó csak gyors tesztbelépő.

Főmenü-indítás külön is ellenőrizve (180 képkocka): nincs parse/runtime hiba, kilépéskor 2 ObjectDB-példányra figyelmeztetés maradt. Ez a korábbi takarítási adósság része; nem tekintjük hibamentes erőforrás-felszabadításnak. Napló: [day3_main_startup.log](day3_review_2026_10_20/day3_main_startup.log).
