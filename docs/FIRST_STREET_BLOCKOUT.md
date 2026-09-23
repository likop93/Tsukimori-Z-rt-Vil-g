# Tsukimori – Első utca Blockout 1.0 + Ambient Pass 1

A kapu után a hegyi út megszakítás nélkül folytatódik Tsukimori első utcáján.

A házelrendezés továbbra is blockout, de az utca most már kapott egy első **élő környezeti réteget**, hogy a térarányokat ne teljesen statikus maketten kelljen megítélni.

## Tér / blockout

- keskeny, végig járható főutca;
- hat eltérően elfordított háztömeg, fizikai ütközéssel;
- két rövid mellékutca;
- két kerítésszakasz;
- négy utcai lámpa;
- Miyako találkozási tere Katsuro házának küszöbénél;
- három rendezett kamera-kompozíció.

## Ambient Pass 1

Bekerült:

- finoman vibráló meleg lámpafény;
- négy mozgó noren / függő textil proxy;
- tíz lassan lebegő szirom/papírdarab;
- hat enyhén mozgó növényproxy;
- hat kapszula helyett emberarányos falusi proxy;
- többféle falusi idle: nézelődés, beszélő gesztus, munkamozdulat, nyugodt állás;
- eltérő testirányok a hat falusinál, hogy a mozgás ne sorba állított figuráknak hasson;
- három visszafogott hajsziluett a falusi proxykon;
- Miyako külön, hosszú hajú humanoid proxyként a ház bejáratánál.

Ez még nem teljes NPC-rutin. A cél az, hogy az utca **lakottnak és mozgónak** hasson anélkül, hogy final asseteket készítenénk.

## Állapotjelzők

- `entered_first_street`
- `reached_miyako_meeting_space`

## Következő review

F5 után a teljes hegyi út felől érkezz meg.

Figyeld:

1. a házak elrendezése jobb-e úgy, hogy körülöttük már történik valami;
2. megfelelő-e a főutca szélessége emberalakokkal;
3. túl sok vagy túl kevés-e a mozgás;
4. természetes-e a meleg lámpafény ritmusa;
5. kell-e házat, mellékutcát vagy NPC-helyet áthelyezni;
6. megfelelő-e Miyako későbbi belépési tere.

A vizuális review után Miyako első találkozásának stagingje következett. A külső environment asseteket a jelenet tényleges igénye alapján próbáljuk ki.

## Technikai review — 2026-09-23

A hat falusi proxy és az utcai ambient controller már működő kódként szerepelt a projektben. A review során a falusiak azonos alapirányát változatos, kézzel beállított testirányokra cseréltük, és három egyszerű hajsziluettet adtunk a falusi proxyknak. Az idle fázisok, a mozgó textil, növények, szirmok és a lámpafény meglévő működését megtartottuk.

A vizuális review még nyitott: a teljes hegyi út felől végigjátszva kell megítélni az NPC-k és Miyako helyét, a kamera kompozícióját és a mozgás mértékét. A technikai módosítás önmagában nem jelent kreatív jóváhagyást.

## Kibővített falurész — 2026-09-23

A korábbi bővítés tizennégy házat, négy mellékutcát, hat lámpát és nyolc falusi proxyt adott a pályához. Miyako házának akkori, beljebb helyezett változata az alábbi történeti pontosítás miatt már nem aktuális.

## Történet szerinti átrendezés — 2026-09-23

A falusiak reakcióihoz Akira a falu egyik szélén érkezik meg, majd végigsétál a lakott utcán. Négy falusi pár felé fordul, összenéz és suttogó mozdulatot tesz, ahogy elhalad mellettük. A patak megszakítja a talaj ütközőfelületét, a híd viszont járható; a partokat alacsony korlát védi. A később pontosított házhelyeket a `docs/VILLAGE_LAYOUT.md` tartalmazza.

## Iránykövető kamera és túlparti folytatás — 2026-09-23

A felhasználói bejárás megmutatta, hogy a rögzített utcai kameraszögek nem követték Akira fordulását, és a ház takarta Miyakót. Az utcai kamerák Akira haladási iránya szerint fordulnak, míg a találkozás külön, oldalról nyitott kameraképet kap. Akira későbbi lakóhelye után járható erdei főút, három mellékút, cédrusok és három névtelen ház jelölik a továbbépíthető tájat. A házakat a következő pontosítás ismét átrendezte.

## Híd utáni közös otthon és vezérlés — 2026-09-23

A legutóbbi bejárás után a szabadon forduló kamera mellé a WASD is képernyőirányú lett. Új billentyűálláskor rögzíti a kamera alapirányait, így ugyanazon gomb nyomva tartása alatt nincs visszacsatolt körbefordulás. Shion a patak falusi partján lakik. A híd utáni első ház névtelen; a második, távolabbi Katsuro egykori háza Miyako és Akira közös otthona, a találkozás ott történik. Hana házát a későbbi történeti falutérképhez kötjük. Az erdei szakasz az otthon után folytatódik.
