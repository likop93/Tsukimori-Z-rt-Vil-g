# A rendelő — első bejárható változat

**Állapot:** Godot blockout, játékbeli F5 review előtt.

Miyako és Akira találkozása után Akira visszasétálhat a lakott falurészbe. A rendelő külön épület a nyugati oldalon, a falusi utca belső szakaszán (`FirstStreet/Clinic`). Ez **ideiglenes cím**: a végleges ingatlanok mérete és a történeti térkép alapján még módosulhat. Shion háza, a patak, a híd és a túlpart két házának sorrendje érintetlen.

## Bejárás

1. A Miyakóval való találkozás lezárása után vissza az utcán, a rendelő oldalösvényéhez (`FirstStreet` helyi `z ≈ -72`).
2. A `診療所 • RENDELŐ` tábla mellett, a keletre néző ajtónál **E**: belépés.
3. A kis váróban és a vizsgálóban **E**: egy-egy rövid környezeti megfigyelés. Az üres székek és előkészített vizsgáló az első páciensek következő történeti jelenetét készítik elő.
4. A belső tolóajtónál **E**: vissza az utcára.

A belső tér külön, nyitott tetejű játéktér ugyanabban a 3D világban: ütköző padló és falak, két várópad, alacsony asztal, térelválasztó, vizsgálóágy, gyógyszeres szekrény, eszköztálca és jegyzetek. A beltéri kamera a bejárás során felülről olvashatóvá teszi a két teret. A kapunyitás `met_miyako` flaghez kötött, a belépés `entered_clinic`, a két megfigyelés `inspected_clinic_waiting_room` és `inspected_clinic_exam_room` jelzőt rögzít.

A rendelő és az első páciensek párbeszéde későbbi történeti pass. A korábbi kánon mondatait és a ház arányait ezzel a blockouttal nem véglegesítjük.
