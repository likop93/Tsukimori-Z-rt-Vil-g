# Tsukimori — aktuális fejlesztési állapot

Hana, Kuroe és Shion korai cameója működik REVIEW atlasszal, névtábla/dialógus/kontrollzár nélkül. Hana felpillant és visszatér a ruhaigazításhoz; Kuroe áthalad a házközön; Shion a híd falusi oldaláról figyel, majd elfordul. [Hana/Shion részletek](HANA_SHION_CAMEOS_REVIEW.md), [Kuroe részletek](KUROE_CAMEO_REVIEW.md). A végleges gesztus- és járásanimáció még hiányzik.

Frissítve: 2026-10-04. Technikai REVIEW; a LOCKED kreatív döntések változatlanok.

Játék közbeni szünetmenü és Shift-futás működik. A menü az intró és a VN idővonalát is megállítja. Külön REVIEW oldalfutó atlasz, front/back futás még ideiglenes. [Részletek és ellenőrzés](PAUSE_AND_RUN_REVIEW.md).

A monológ első buszos Akira-képe részletesebb, a karakterlaphoz és az emlékképhez igazított REVIEW CG-re cserélve. [Képi folytonosság és prompt](AKIRA_OPENING_CONTINUITY_REVIEW.md). A történet és az intró időzítése változatlan.

A belépési pont a scenes/ui/main_menu.tscn. Főmenü → Játék indítása → scenes/opening/opening.tscn: nyitás (66 mp) → kapunál kontroll → Village Street → híd → ház → Miyako köszöntése. A falun belüli útvonal játékosvezérelt.

2026-10-03: főmenü a felhasználó kifejezett kérésére. Játék indítása, Beállítások, Irányítás, Kilépés. Hangerő és teljes képernyő mentése külön beállításfájlba; ez nem játékállás-mentés. Meglévő erdei kapu REVIEW háttér, eső és halk esőhang. Részletek: [MENU_REVIEW](MENU_REVIEW.md).

Működik: négy női ambient NPC, nyolcképkockás oldalirányú járás és négyképkockás előre/hátra ciklus, kamera, eső, előtér-takarás, mozgáshatárok, talajhoz igazított Miyako, ütközés, látható feliratok. A Space nem ugrik a cinematic idővonalán; a teljes kihagyás a kapunál csak opening_intro_seen és entered_tsukimori flaget állít.

Miyako külső találkozása már kézzel léptethető VN-jelenet: névtábla, REVIEW referenciaportré, eredeti Ren’Py-narráció, zárolt mozgás és lezáráskor állított jelzők. Részletek: [MIYAKO_VN_REVIEW](MIYAKO_VN_REVIEW.md).

Az első benti beszélgetés és két eredeti választása működik, explicit E-belépéssel, Library háttérrel, halkuló esővel és egyszeri állapotmódosítással. Lezárás után a nappali első járósávja használható. Részletek: [MIYAKO_INTERIOR_REVIEW](MIYAKO_INTERIOR_REVIEW.md).

Az átjárás javítva: Miyako mellett mindkét irányban el lehet menni. A VN külön Tovább gombot kapott. Jobbra E indítja az első éjszaka szöveges átvezetését, majd fejezetzárás és főmenü-gomb következik. Részletek: [INTERIOR_PASSAGE_AND_CONTINUATION_REVIEW](INTERIOR_PASSAGE_AND_CONTINUATION_REVIEW.md).

Hátralévő: teljes házbelső és interakciók, éjszakai kép/hang, II. fejezet, teljes 10–15 perces narratív flow, végleges VN-portrék, animáció és hang. Combat/inventory/route/komplex mentés nincs kész.

2026-10-01 technikai rendezés: a régi 3D ág archive/legacy_3d alá került, importbeállításokkal és szerkesztőeszközökkel együtt. Az aktív arrival_director már csak Miyako köszöntését vezérli; Akira explicit street referenciát kap. A korábbi szöveg-, talaj- és ütközésjavítások megmaradtak.

A korábbi 3D állapotjelentés: [archivált PROGRESS](../archive/legacy_3d/docs/PROGRESS_BEFORE_ARCHIVE.md). Az ott leírt klinika, 3D falusi párok és belső terek nem a jelenlegi pixel-art játékmenet funkciói.
