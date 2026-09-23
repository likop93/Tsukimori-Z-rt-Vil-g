# A rendelő — első bejárható változat

**Állapot:** Godot blockout, játékbeli F5 review előtt.

Az orvosi rendelő **Miyako és Akira közös, Katsurotól maradt házának kisebb, összeépített oldalszárnya** (`FirstStreet/Houses/MiyakoAkiraHome/Clinic`). A híd felőli oldalon áll, külön, az út felől elérhető ajtóval. A lakóház főbejárata és Miyako találkozási pontja változatlan. A pontos arányok a végleges házassetnél módosulhatnak.

## Bejárás

1. A Miyakóval való találkozás után a ház mellett menj pár lépést a híd felé, **a hídon ne kelj át**. A házhoz simuló alacsonyabb szárnynál a lámpás és a `RENDELŐ` tábla jelzi a kövezett bejáratot. A HUD is a ház híd felőli oldalára irányít.
2. Az oldalsó ajtónál **E**: belépés.
3. A kis váróban és a vizsgálóban **E**: egy-egy rövid környezeti megfigyelés. Az üres székek és előkészített vizsgáló az első páciensek következő történeti jelenetét készítik elő.
4. A belső tolóajtónál **E**: vissza a közös ház udvarára.

A belső tér technikailag külön, nyitott tetejű játéktér ugyanabban a 3D világban; a pályán a rendelő a közös házhoz kapcsolódik. Bent ütköző padló és falak, két várópad, alacsony asztal, térelválasztó, vizsgálóágy, gyógyszeres szekrény, eszköztálca és jegyzetek vannak. A beltéri kamera felülről olvashatóvá teszi a két teret. A belépés `met_miyako` flaghez kötött, `entered_clinic`, valamint a két megfigyelés `inspected_clinic_waiting_room` és `inspected_clinic_exam_room` jelzőt rögzít.

A rendelő és az első páciensek párbeszéde későbbi történeti pass. A korábbi kánon mondatait és a ház arányait ezzel a blockouttal nem véglegesítjük.
