# Tsukimori — összevont kánonszinkron, 2026-10-21

**Státusz:** tulajdonosi döntések egyeztetése és korábbi dokumentumok felülírási jegyzéke; **nem új jelenetek automatikus megvalósítása**.
**Hatókör:** történet, karakterazonosság, képi gyártás, nyitány, mechanikák, rövid távú sorrend és ismert hiányok.

> Ez a dokumentum nem írja újra a teljes `CREATIVE_BIBLE`, `CHARACTER_BIBLE`, `MASHIRO_LOCKED_BIBLE` és a Ren'Py forrásokat. Ahol kifejezett **későbbi tulajdonosi korrekció** szerepel, az az adott részben felülírja a régebbi implementációs és vizuális leírást. Más LOCKED döntések megmaradnak. Az APPROVED CONCEPT / PROPOSED / REVIEW nem azonos az IMPLEMENTED vagy FINAL státusszal.

## 1. Rövid döntési hierarchia

1. Legfrissebb kifejezett tulajdonosi döntés, az érintett kérdés pontos hatókörén belül.
2. `docs/DECISION_LOG.md` LOCKED döntései, az itt felsorolt későbbi felülírásokat is beleértve.
3. `docs/STORY_CANON.md`, `docs/CHARACTER_BIBLE.md`, `docs/CREATIVE_BIBLE.md`, jóváhagyott tematikus biblia és karakteres LOCKED fájlok.
4. Meglévő kanonikus Ren'Py cselekmény, dialógus és választási struktúra, amennyiben nincs későbbi tulajdonosi módosítás.
5. Godot REVIEW, sprite proxy, generált képre írt szöveg és korábbi vázlat.

A kánon rögzítése, a képfájl átvétele, a Godot-ba integrálás és a képi elfogadás **négy külön esemény**.

## 2. Technikai és vizuális irány — OWNER OVERRIDE

- A teljes játék **filmes, részletgazdag 2D/2.5D pixel-art narratív kaland**, saját Tsukimori-nyelvvel. A karakter- és háttér-CG ugyanazon világ része. A nagy felbontású anime-referenciák **arc-, sziluett-, szín- és ruházati authorityk**, nem automatikusan kész pixel-art production assetek. A sima anime-render puszta pixelesítése nem minősül végleges kézi consistency passnak.
- **NINCS WASD vagy más kézi, szabad karakterirányítás** sem a nyitányban, sem a falubejárásban. Helyette kattintható falutérkép / helyszínválasztás, interakció, nem vezérelhető filmes séta- és érkezésbeállítások, valamint VN dialógus/choice. A korábbi `CharacterBody3D`, in-place walk és „bejárható utca” irányok technikatörténeti/legacy referenciák, **nem kötelezően visszaállítandó játékmenet**.
- Nagy cselekménypontokhoz önálló **16:9 CG, szöveg és UI nélkül**; rövid beszélgetéshez keret nélküli nagy portré a dimmelt jelenet előtt. Ne készüljenek játék-CG helyett többpaneles karakterlapok vagy díszposzterek.
- A falu térbeli kánonja marad: Shion háza a patak falusi oldalán, patakhíd, túlparton távolabb Miyako/Katsuro háza; rendelőszárny ugyanahhoz a házhoz kapcsolódik.
- Egyetlen GameState és VN-rendszer; meglévő flag-ek kompatibilisek. REVIEW képet, párbeszédet és tesztet tilos FINAL-nak nevezni tulajdonosi jóváhagyás nélkül.

## 3. Akira — LOCKED, felülírja a szemüveges/opcionális legacy variánst

- Dr. Akira: kb. 32 éves, ~180 cm, felnőtt, karcsú-atletikus, rövid/közepes rendezetlen **fekete haj**, barna-szürkés tekintet, nyugodt megfigyelő, **szemüveg nélkül**.
- Elsődleges civil megjelenés: sötét/fekete utcai kabát, szürke kapucnis réteg, világosabb póló, sötét nadrág és cipő; a felhasználó által bemutatott eredeti Akira-front/oldal/hát és PNG-portré az identitásminta.
- **A ruha jelenetfüggő és cserélhető.** Az exes emlékképeken, otthon vagy külön alkalmakon nem kötelező ugyanaz a kabát. Fehér orvosi köpeny csak orvosi/rendelői helyzetben; az utcai érkezéshez nem.
- A korábban a dizájnlapon szereplő opcionális szemüveges Akira **nem jelenhet meg normál játékbeli, nyitány- vagy emlék-CG-kben**. A régi referencialap történetileg megőrizhető, de a szemüveges panel nem production authority. Ha külön új tulajdonosi engedély nem érkezik, ne készüljenek új szemüveges Akira-képek.
- Akira arcát, fekete haját és felnőtt arányait következetesen az eredeti referencia alapján kell őrizni; generikus szemüveges vagy öltönyös új férfialak nem helyettesíti.

## 4. Miyako — LOCKED primary identity, REVIEW mimikakészlet

- Elsődleges referencia: a tulajdonos által bemutatott **eredeti Miyako** (és a repository `MIYAKO_FINAL_DESIGN_A_PRIMARY.png` vonala); nem a később többször félregenerált, generikus rózsaszín hajdíszes/krémszínű kimonós figura.
- Felnőtt (~32), kb. 165 cm; hosszú sötétbarna haj részben feltűzve, meleg barna szem, érett elegáns arc, arany hajdísz/tassel, fekete/charcoal zárt elegáns alapöltözet, arany/bordó díszítések. A Design B kizárólag elkülönített ceremoniális variáns, nem automatikus főruha.
- Arcok: semleges, finom mosoly, gyengéd, játékos, érdeklődő, aggódó, szomorú/sebezhető és figyelő/nyugtalanító. **Még nem áll rendelkezésre elfogadott, egységes nyolcképes final expression set.** A korábbi többpaneles, arcot/ruhát változtató generálások **REJECTED**, nem kánon.
- Lassú pszichológiai ív: Akira másokhoz való kötődése felerősítheti Miyako birtoklását, megfigyelését, féltékenységét és fokozatos utánzását. A test/szem/haj végleges átalakulása csak hosszú előzmény és a külön történeti reveal után lehetséges. **NINCS teljes mániás, ezüst hajú/kék szemű változat a bemutatkozásban, a legelső teánál vagy egyetlen határhúzás után.** Korai állapot legfeljebb alig észrevehető figyelő reakció.
- Katsuro magán-dolgozószobájának és ott rejtett feljegyzéseinek létezéséről tud, a hozzáférést eltitkolja; nem a rendelő egy helyiségéről van szó.

## 5. Nyitány / 0. nap — OWNER OVERRIDE: autó, parkoló, gyalogos érkezés

A busz, buszmegálló és erdei leszállásos változat **SUPERSEDED**.

Kötelező folyamat:
1. Akira **saját autóval** érkezik hegyi úton; szépség, visszafogott nyugtalanság, hegyek és falukép.
2. Az autót **a falu szélén, Miyako házától távol** parkolja le.
3. Kiszáll, majd **gyalog indul be** a faluba. Filmes képek és átmenetek, **nem játékos által irányított séta**.
4. Helyszínhű rövid falu-képek: csak az ott és abban az időben jelen levő karakterek; ne kerüljön Mashiro, Himiko vagy egyéb később bemutatkozó személy indokolatlanul az első napi utcai képbe.
5. A meglévő hídon át a túloldali, távolabbi Miyako-házhoz jut; **Miyako első köszöntése a háznál**, nem a parkolónál.
6. Első házbeli beszélgetés / étkezés, Akira szobája, Katsuro fényképének nyoma, első éjszaka; a régóta meglévő traumatikus exes emlékbevillanások **villanások**, nem idő előtti teljes leleplezések.
7. Nappal 1: rendelő, a meglévő első páciensjelenetek, majd kattintásos falubejárás, este és a következő napok meglévő flow-ja.

**Asset-státusz (nem implementációs bizonyíték):** a tulajdonos elfogadott három új autós nyitányképet és két meglévő exes flashbacket átadáshoz. A három autós anime-render **REVIEW** a pixel-art átültetésig; a két régi exes CG egy régebbi **szemüveges Akirát** használ, ezért **REVIEW / javítandó arcazonosság**. A konkrét binárisok repóbeli elhelyezését és Godot-bekötését külön kell ellenőrizni. Régi `village_walk_REVIEW.png` jelenléte önmagában nem bizonyítja a parkoló → faluszél → első ház látványhiányainak pótlását.

## 6. Időkeret és korai napok — elfogadott

- **120 játékbeli nap**, 4×30 nap: tavasz 1–30, nyár 31–60, ősz 61–90, tél 91–120; fő események és szabadabb/könnyebb időszakok váltakoznak. Kisebb, route-függő 2–5 napos intim kiruccanások lehetségesek, nem egyetlen lineáris kötelező út.
- A **legelső időjárási rendellenesség a 30. napon** jelentkezhet. Nap 0–29: természetes eső, köd, szél stb. lehetséges, de **nincs természetellenes időjárás/évszakcsúszás**. A pszichológiai horror korábban megjelenhet.
- Nap 1: rendelő és kattintható falu, szabad sorrendű ismerkedés, opcionális hazatérés; a nap nem követel minden NPC-től találkozást.
- Nap 2: Hana, Miyako és más már meglévő jelenetek a jelenlegi adatok szerinti sorrendben.
- Nap 3: Shion → pecsét → falutérkép (Aoi boltjában Ayame, piacnál Hana Himikót említi) → hazatérés → Miyako esti tea. Ez GitHubon REVIEW implementációként dokumentált.
- Himiko **későbbi, külön érkezés**, megközelítőleg 3–4. napos előkészítéssel, nap 1 kötelező jeleneteiben nincs ott.
- Mashiro első találkozása nap **5–10**, alapjavaslat **7**: fehér virágokat visz Miyako házába, ott ismeri meg Akirát; Holdvirág Üvegházba való meghívása időérzékeny.
- A fenti napok nem jelentik, hogy 4–10. nap játszható kódban már elkészült. Későbbi tartalom a dokumentáció szerint **MISSING/PLANNED**.

## 7. Hetedik Éjszaka, Kollektíva és Katsuro — OWNER APPROVED, részletek nyitottak

- Visszatérő különleges éjszakák: **7., 14., 21., 28.**, majd minden hetedik nap a történeten belül (legutolsó 119.).
- A falusi nőkből álló **Kollektíva** kollektív nyomása, fokozott vágyak, szokatlan szociális észlelés és fenyegető szabályok egyre nyilvánvalóbbá válnak. **Az első hét nap a feszültség felépítése, nem az összes horror előzetes elmagyarázása.**
- A Kollektíva szerint a tényleges éjszakai együttlét nyújthat védelmet; ez a fenyegető csoport **torz követelése**, nem beleegyezés és nem romantikus teljesítmény. **Kötelező nem szexuális menekülési, ellenállási vagy túlélési ág.** Fenyegetés alatt létrejött találkozás nem automatikus szerelmi kötődés.
- Katsuro személyes, lezárt dolgozószobájában a falusiakról készített feljegyzések találhatók. Miyako tud róluk és rejti őket. A nyomozás vezethet ahhoz az állításhoz, hogy a falusi nők egy korábbi Hetedik Éjszakán megölték Katsurót; a közvetlen elkövetők, tanúk, elhallgatók **még nincsenek kijelölve**. Ez **nem teszi automatikusan minden route egyetlen objektív világmagyarázatává** a racionális olvasatot.
- A **28. nap** lehetséges „Katsuro sorsa” rossz befejezés, nem minden esetben automatikus halál; küszöbök és pontos események **MÉG NINCSENEK LOCKED**.
- Egyéni pszichés problémák és trauma szereplőnként részletesek, de önmagukban nem bizonyítanak erőszakosságot; konkrét klinikai diagnózisok nincsenek automatikusan véglegesítve.

## 8. Szereplők, útvonalak, vizuális státusz

### Ayame — OWNER APPROVED, 28 éves
- Aoi boltjának alkalmankénti segítője (teák, gyógynövények). Nap 3 hétköznapi megismerkedés, nap 5 személyesebb beszélgetés, nap 7 első éjjeli látogatás, nap 14 második, nap 15 józan és önkéntes döntésen alapuló szeretői út feloldása.
- Aoi **nem tűnik el**, és a két személy szerepe nem mosódik össze. A későbbi önkéntes közeledést az éjszakai kényszer nem helyettesítheti.
- Későbbi Ayame–Kuroe–Shion különleges, kölcsönös döntésre épülő jelenet **további kidolgozandó lehetőség**, nem automatikusan minden route-ban megjelenő kötelező esemény.
- A 3. napi Ayame-bolti kép és a 7. napi küszöbkép referenciaként beérkezett; nem jelentenek teljes kész route-ot.

### Mashiro — LOCKED elsődleges True Love
- 25 éves, 165 cm; fehér haj, világos bőr, ezüstkeretes szemüveg **nála helyes**, nappal visszafogott szürkés-kék szemek, éjjel külön, fehér róka fülek/farok és arany szembeli motívum; Holdvirág Üvegház.
- **True Love** út exkluzív, tiszta újrakezdés és gyógyulás lehetséges befejezése; az első találkozás és a meghívás időérzékeny.
- **Egyetlen külön titkos kivétel:** `moon_two_faces`, vagyis **A Hold Két Arca** – Akira, Mashiro és Sayuri kölcsönös, őszinte, folyamatos beleegyezésű, külön történettel megalapozott kapcsolata. Ez **nem globális háremfeloldás**; feltételei, küszöbei, napi időzítése még REVIEW.
- Mashiro 29 beérkezett referenciafájlja **nem 29 elkészült production sprite vagy CG**. Lásd `docs/REFERENCE_INTAKE_2026_10_20.md`.

### Sayuri — OWNER-ESTABLISHED alap, további szereplőbiblia még szükséges
- Felnőtt onsen/fürdő működtetője, bordó haj és borostyán szem, külön érzelmi szerep. A titkos Moon Two Faces route-ban Mashiróval **önálló kapcsolatot** is fel kell építeni.
- Korábbi karakterképek rendelkezésre álltak beszélgetésbeli csomagban; nem szabad puszta fájlnévből Godot-integrációt feltételezni.

### Hana, Himiko, Shion, Kuroe, Reina, Renka, Oto, Sora
- A régebbi LOCKED design és egyéni történeti ívek maradnak; nem generikus helyettesítő modellek. Hana nővére **Himiko**, köztük nincs romantikus/szexuális kapcsolat.
- **Kuroe és Shion korábbi szerelmi kapcsolata** fontos háttér. Akira később az első olyan férfi lehet, aki mindkettőjük érdeklődését kiváltja; az út konkrét megvalósítása **további jelenetírás**, nem automatikusan kánoni párkapcsolat.
- Kuroe kezdeményezésére Akira hangszerét **hangszerkészítő műhelyben, mahagóniból** készítik el; a külsőn **Miyako motívumai dominálnak**. A jelenet **későbbi**, nem helyettesíti a mostani fő cselekményt.
- Oto nappali/idős és éjszakai/fiatalos megjelenése külön identitáskezeléssel működik; a reveal előtt ne spoilerezzék a menük. A Mélységben az idősebb asszonyok láthatóan kb. késő negyvenesnek tűnő korra fiatalodnak vissza: **késői helyszíni motívum, nem korai látvány**.

### Natsume — új, elkülönített APPROVED CONCEPT; még nem production LOCK
- Sora fogadójához kapcsolódó **nagyon kövér, erősen nőies, magabiztos, kacér felnőtt vendéglátó/szakácsnő**; korábbi javasolt életkor 38, neve Natsume. A tulajdonos egy látványtervet kifejezetten elfogadott vizuális kiindulóként, de az azt követő, extrémebb arányokra irányuló képmódosítások **nem készültek el**.
- Sora külön karakter és a fogadó vezetője, **Natsume nem Sora redesignja**. Natsume háttértörténete, horror/romance ág, production-ready karakterlap és pontos implementáció **nem LOCKED**. Korábbi, teljesen eltérő, európai külsejű, fiatalos megjelenésű női próbálkozások **nem Natsume helyére elfogadott redesignok**.
- A korábbi első szakaszos karakterbővítési stop mellett Natsume csak **külön új concept**, amíg a tulajdonos tényleges történetbeli integrációját nem kéri.

## 9. További dramaturgia — elfogadott irányok és nyitott igazságok

- A két nagy történeti rész választóvonala **Akira kulcsemlékeinek teljes visszatérése**. A romantikus kapcsolatok/bizalmi döntések az emlékezés utáni útvonalakat is befolyásolják.
- Katsuro hívta haza Akirát. Exfeleség/Loft körül előzetes APPROVED story direction van; Renka mint későbbi exe **PROPOSED**, nem minden korai flashback nőalakja automatikusan Renka.
- A fekete legyező szilánkjainak korábbi széttöréstörténetét a meglévő forrás alapján kell folytatni, nem újraszerkeszteni.
- A Mélységbe lejutás késői fordulat. Tsukimori teljes metafizikája, kóma/ébredés-olvasata és a világ végső magyarázata **NYITOTT**.
- Jó szándékú többpartneres kapcsolatok csak minden érintett felnőtt önkéntes és informált beleegyezésével; manipulációs út horror/erkölcsi romlás, nem automatikus romantikus jutalom.

## 10. Implementációs valóság és teendőlista — nem késznek jelentett tartalom

**A GitHub ellenőrzött alapja** a 2026-10-20-i `DAY3_VILLAGE_REVIEW.md`: 3. napi falu/tea REVIEW végigfut; a 4–10. nap és a Hetedik Éjszaka teljes lánca még nincs készre dokumentálva. Azóta más fejlesztő helyi vagy remote változtatásainak státuszát külön ellenőrizni kell.

Következő produkciós hiányok:
1. Autós nyitány 3 képe és parkoló → faluszél/első ház átmenet: arcazonosság, pixel-art CG-feldolgozás és játékbeli integráció ellenőrzése.
2. Szemüveg nélküli Akira production karakterlap (külön oldal- és hátnézettel); Miyako eredeti Design A szerinti megbízható portré és reagáló expression set.
3. Katsuro dolgozószoba/zárt ajtó, jegyzetek, Akira–Katsuro hiteles közös fotó (Katsuro arcazonosság nélkül nem található ki).
4. Hiányzó production portrék, többek között Reina, Sora placeholder helyett, Mashiro, Himiko, Sayuri; a meglévő jóváhagyott képi identitások alapján.
5. Nap 4–10 jelenetek és helyszínek, első Hetedik Éjszaka, 14. nap előkészítése és route-függő döntések; csak kanonikus sorrend és jelenetenkénti review után.
6. Nem procedurális, végleges audio és következetes filmes animáció külön munkakörben.

**Sem a nyers generált kép, sem az előzetes ZIP-átadás, sem a kész dokumentum nem bizonyítja a futó Godot integrációt.** Forrásfájl, játékbeli screenshot és sikeres regresszió együtt szükséges az IMPLEMENTED/FINAL státuszhoz.

## 11. Végrehajtási fegyelem

- Ez **kánonszinkron**, nem felhatalmazás a történet átírására vagy azonnali 120 napos tartalomgyártásra.
- A régi buszos/öltönyös/szemüveges generált CG **archív/review**, a régi direkt WASD-mozgás **SUPERSEDED**.
- A korai történetben **ne legyen időjárási anomália, Mashiro/Himiko idő előtti jelenléte, Miyako idő előtti végső átalakulása, illetve hetedik éjszakai fenyegetésből automatikus romantikus jutalom**.
- Egy-egy képnél és jelenetnél azonos karakterazonosság + történetbeli hely/idő + stílus + forrás + elfogadási teszt szükséges.
- **Claude, Codex, Work vagy más fejlesztő nem jogosult a tulajdonosi kánon megváltoztatására saját kreatív ötlet alapján.**
