# Tsukimori — aktuális fejlesztési állapot

Frissítve: 2026-10-03. Technikai REVIEW; a LOCKED kreatív döntések változatlanok.

A belépési pont a scenes/ui/main_menu.tscn. Főmenü → Játék indítása → scenes/opening/opening.tscn: nyitás (66 mp) → kapunál kontroll → Village Street → híd → ház → Miyako köszöntése. A falun belüli útvonal játékosvezérelt.

2026-10-03: főmenü a felhasználó kifejezett kérésére. Játék indítása, Beállítások, Irányítás, Kilépés. Hangerő és teljes képernyő mentése külön beállításfájlba; ez nem játékállás-mentés. Meglévő erdei kapu REVIEW háttér, eső és halk esőhang. Részletek: [MENU_REVIEW](MENU_REVIEW.md). Kuroe cameója a jóváhagyott referencia hiányában függőben marad.

Működik: négy női ambient NPC, nyolcképkockás oldalirányú járás és négyképkockás előre/hátra ciklus, kamera, eső, előtér-takarás, mozgáshatárok, talajhoz igazított Miyako, ütközés, látható feliratok. A Space nem ugrik a cinematic idővonalán; a teljes kihagyás a kapunál csak opening_intro_seen és entered_tsukimori flaget állít.

Miyako külső találkozása már kézzel léptethető VN-jelenet: névtábla, REVIEW referenciaportré, eredeti Ren’Py-narráció, zárolt mozgás és lezáráskor állított jelzők. Részletek: [MIYAKO_VN_REVIEW](MIYAKO_VN_REVIEW.md).

Hátralévő: a jóváhagyott Hana/Kuroe/Shion cameók, házbelső és benti beszélgetés/döntés, teljes 10–15 perces narratív flow, végleges VN-portrék, animáció és hang. Combat/inventory/route/komplex mentés nincs kész.

2026-10-01 technikai rendezés: a régi 3D ág archive/legacy_3d alá került, importbeállításokkal és szerkesztőeszközökkel együtt. Az aktív arrival_director már csak Miyako köszöntését vezérli; Akira explicit street referenciát kap. A korábbi szöveg-, talaj- és ütközésjavítások megmaradtak.

A korábbi 3D állapotjelentés: [archivált PROGRESS](../archive/legacy_3d/docs/PROGRESS_BEFORE_ARCHIVE.md). Az ott leírt klinika, 3D falusi párok és belső terek nem a jelenlegi pixel-art játékmenet funkciói.
