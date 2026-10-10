# Tsukimori — aktuális fejlesztési állapot

2026-10-10: Akira–Katsuro fénykép a korábbi helyőrző helyett; Hana lezárása után külön folytatásgombbal a teljes késő délutáni Miyako-jelenet, füzet-CG és időzített jelzők. Katsuro arca REVIEW; az éjszakai látogató a következő blokk. [Részletek és képpromptok](AFTERNOON_PHOTO_REVIEW.md).

Hana, Kuroe és Shion korai cameója működik REVIEW atlasszal, névtábla/dialógus/kontrollzár nélkül. Hana felpillant és visszatér a ruhaigazításhoz; Kuroe áthalad a házközön; Shion a híd falusi oldaláról figyel, majd elfordul. [Hana/Shion részletek](HANA_SHION_CAMEOS_REVIEW.md), [Kuroe részletek](KUROE_CAMEO_REVIEW.md). A végleges gesztus- és járásanimáció még hiányzik.

Frissítve: 2026-10-04. Technikai REVIEW; a LOCKED kreatív döntések változatlanok.

Orvosi Akira-outfit a rendelői VN-hez; befelé forduló szereplők és igazított páciensarányok; Hana öt történeti pillanata önálló CG-re vált, a portrék elrejtésével és visszaállításával. [Képek és generálási napló](MEDICAL_AKIRA_HANA_CG_REVIEW.md).

Főmenü → Fejezetválasztás: hat működő tesztbelépés (nyitány, falusi séta, Miyako, első éjszaka, első rendelési nap, Hana). Előzményeket beállít, múltbeli döntésekért pontot nem ad. Nem save/load vagy route rendszer. [Működés és ellenőrzés](CHAPTER_SELECT_REVIEW.md).

Az első nap lezárása továbbvezet a következő reggelhez és Hana teljes első terápiás jelenetéhez. Két eredeti választás, négy tesztelt kombináció, változó arckifejezésű keret nélküli portré, megismerési flag és karakterlap. A külön klinikai kiegészítés és a késő délutáni folytatás még külön feladat. [Forrás és generation napló](HANA_FIRST_SESSION_REVIEW.md).

Tulajdonosi arány-visszajelzés alapján az új szoba/rendelő VN-háttér lett, járó Akira nélkül. Gombok vagy fel/le + Enter indítják a megfigyeléseket és a nap állomásait. Az eredeti nappali- és külső járás megmaradt. [Megjelenítés és ellenőrzés](ROOM_CLINIC_VN_REVIEW.md).

Karakterlapok, leírások és megtörtént eseményekből képzett kapcsolati státusz implementálva. Első éjszaka külön lezárással → közös reggel → két bővített eredeti névtelen konzultáció → Katsuro rendelői füzete → esti beszélgetés Miyakóval → „Hana” záróhang és első napi végpont működik. A teljes éjszaka–nap lánc egyben átnézhető. Inventory később. [Éjszaka](FIRST_NIGHT_IMPLEMENTATION_REVIEW.md), [első nap, források és production hiányok](FIRST_DAY_IMPLEMENTATION_REVIEW.md).

Játék közbeni szünetmenü és Shift-futás működik. A menü az intró és a VN idővonalát is megállítja. Külön REVIEW oldalfutó atlasz, front/back futás még ideiglenes. [Részletek és ellenőrzés](PAUSE_AND_RUN_REVIEW.md).

A monológ első buszos Akira-képe részletesebb, a karakterlaphoz és az emlékképhez igazított REVIEW CG-re cserélve. [Képi folytonosság és prompt](AKIRA_OPENING_CONTINUITY_REVIEW.md). A történet és az intró időzítése változatlan.

A belépési pont a scenes/ui/main_menu.tscn. Főmenü → Játék indítása → scenes/opening/opening.tscn: nyitás (66 mp) → kapunál kontroll → Village Street → híd → ház → Miyako köszöntése. A falun belüli útvonal játékosvezérelt.

2026-10-03: főmenü a felhasználó kifejezett kérésére. Játék indítása, Beállítások, Irányítás, Kilépés. Hangerő és teljes képernyő mentése külön beállításfájlba; ez nem játékállás-mentés. Meglévő erdei kapu REVIEW háttér, eső és halk esőhang. Részletek: [MENU_REVIEW](MENU_REVIEW.md).

Működik: négy női ambient NPC, nyolcképkockás oldalirányú járás és négyképkockás előre/hátra ciklus, kamera, eső, előtér-takarás, mozgáshatárok, talajhoz igazított Miyako, ütközés, látható feliratok. A Space nem ugrik a cinematic idővonalán; a teljes kihagyás a kapunál csak opening_intro_seen és entered_tsukimori flaget állít.

Miyako külső találkozása már kézzel léptethető VN-jelenet: névtábla, REVIEW referenciaportré, eredeti Ren’Py-narráció, zárolt mozgás és lezáráskor állított jelzők. Részletek: [MIYAKO_VN_REVIEW](MIYAKO_VN_REVIEW.md).

Az első benti beszélgetés és két eredeti választása működik, explicit E-belépéssel, Library háttérrel, halkuló esővel és egyszeri állapotmódosítással. Lezárás után a nappali első járósávja használható. Részletek: [MIYAKO_INTERIOR_REVIEW](MIYAKO_INTERIOR_REVIEW.md).

Az átjárás javítva: Miyako mellett mindkét irányban el lehet menni. A VN külön Tovább gombot kapott. Jobbra E már Akira bejárható szobájába vezet; a korábbi fejezetzárást felváltja az éjszaka–reggel–rendelő folytatás. A korábbi javítás történeti leírása: [INTERIOR_PASSAGE_AND_CONTINUATION_REVIEW](INTERIOR_PASSAGE_AND_CONTINUATION_REVIEW.md).

Hátralévő: teljes házbelső és interakciók, éjszakai férfihang/alvás animáció, a II–III. fejezet teljes adaptációja, Hana klinikai szövegének és első napi sorrendjének egyeztetése, napközbeni falusi/szabadidős folytatás, végleges portrék és animáció. Combat/inventory/route/komplex mentés nincs kész.

2026-10-01 technikai rendezés: a régi 3D ág archive/legacy_3d alá került, importbeállításokkal és szerkesztőeszközökkel együtt. Az aktív arrival_director már csak Miyako köszöntését vezérli; Akira explicit street referenciát kap. A korábbi szöveg-, talaj- és ütközésjavítások megmaradtak.

A korábbi 3D állapotjelentés: [archivált PROGRESS](../archive/legacy_3d/docs/PROGRESS_BEFORE_ARCHIVE.md). Az ott leírt klinika, 3D falusi párok és belső terek nem a jelenlegi pixel-art játékmenet funkciói.

2026-10-04 portréfrissítés: partner balra, Akira jobbra a keret nélküli párbeszédekben. Hana öt, Miyako négy képi reakció; az első két névtelen páciens saját eredeti portrékkal és reakciókkal. Éjszakai CG-k és megfigyelések továbbra is portré nélkül. [REVIEW assetek, források és ellenőrzés](DIALOGUE_PORTRAITS_REVIEW.md).
