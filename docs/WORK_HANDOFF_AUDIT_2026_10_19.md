# Tsukimori — main audit és 3–10. napi fejlesztési átadás
**Dátum:** 2026-10-19
**Vizsgált main:** ccf6fbc2677cc5348a06db02c471a7a4bc40357a
**Remote:** https://github.com/likop93/Tsukimori-Z-rt-Vil-g.git
**Típus:** állapotellenőrzés, kánon-összevetés és fejlesztési terv. A terv nem implementáció.

## 1. Vezetői megállapítás
A játék jelenleg a megérkezéstől a harmadik nap esti teájáig rendelkezik összekapcsolt történeti jelenetekkel. Ez nem három teljes, szabadon szimulált nap: a szereplői események rendezett jelenetsorban futnak, a falutérkép normál játékbeli belépése az első délutánra van bekötve. A tea lezárása után jelenleg Főmenü következik, nincs negyedik nap.

A 120 napos állapotmodell tényleges kód és tesztelt infrastruktúra. Nem 120 napnyi tartalom, nem mentés/betöltés és nem heti eseményütemező. A visszalátogatások működnek; többnapos nyitvatartás és találkozónaptár még nincs.

Ayame, a Hetedik Éjszaka, Katsuro új nyomozati bizonyítéklánca és a moon_two_faces titkos út még nincs implementálva. Az új tulajdonosi döntéseket a [történeti kiegészítés](STORY_DIRECTION_ADDENDUM_2026_10_19.md) rögzíti, kész jelenetnek minősítés nélkül.

## 2. Módszer és ellenőrzési határ
- Remote és fetch ellenőrizve; az audit kezdetén a helyi HEAD és origin/main azonos. Nincs lehúzatlan remote commit.
- A teljes, 942 követett fájlos main archívumból külön auditpéldány készült. A munkapéldányban lévő exportbeállításokat, módosított review-képeket és követetlen fájlokat nem írtuk felül, és nem tekintettük main-tartalomnak.
- Aktív projekt, autoloadok, jelenetdirektorok, történeti JSON-ok, karakterlapok, naptár, helyszínadatok, jóváhagyott kánon és tesztbelépők ellenőrizve.
- 159 képfájl az assets/reference könyvtárakban: SHA-256, méret, felbontás, dekódolhatóság ellenőrizve. 0 dekódolási hiba.
- 151 különböző szó szerinti res:// hivatkozás statikus vizsgálata. A négy kezdeti találat dinamikus fájlnév/prefix vagy review-kimenet; nem igazolt hiányzó kötelező bemeneti fájl. Ez nem helyettesíti a dinamikus Godot-erőforrások futási ellenőrzését.
- Godot 4.7.2 stable, Compatibility, NVIDIA RTX 4070 SUPER; tiszta editor-import és valódi grafikus tesztfutások.
- Nem teljes kézi végigjátszás minden időzítéssel. A jelenet- és ágvizsgálatokat tesztek hajtották; a képi ellenőrzés reprezentatív futási képekre terjedt ki. A 159 fájl dekódolhatósága nem 159 új művészeti jóváhagyás.
- Új karakterkép/CG nem készült, alkalmazáskód és meglévő történeti jelenet nem változott az auditban. Egy kiegészítő teszt került hozzá a valódi belépési út ellenőrzéséhez.

Bizonyítékok: [teszteredmények](audit_2026_10_19/test_results.json), [assetleltár](audit_2026_10_19/asset_inventory.json), a mellettük tárolt naplók.

## 3. IMPLEMENTED / REVIEW / MISSING

Az IMPLEMENTED a futó funkciót jelenti. Ugyanennek képe vagy új összekötő szövege lehet REVIEW; a két állítás nem cserélhető fel.

| Elem | Státusz | Tényleges helyzet / forrás |
|---|---|---|
| Főmenü, szünet, beállítások, fejezetválasztó | IMPLEMENTED | project.godot, scripts/ui/main_menu.gd, pause_menu.gd, chapter_catalog.gd. 10 fejezetbelépő, nem tíz játékbeli nap. |
| Nyitány, eső, skip, állapotátadás | IMPLEMENTED / képek REVIEW | tests/opening/regression.tscn valójában gate_flow tesztet futtat; 66 másodperces nyitány és skip-esetek. |
| Miyako első köszöntése és házbelső döntés | IMPLEMENTED, tesztadóssággal | arrival_director.gd, interior_director.gd; két régi közvetlenül felállított teszt hibás. A kiegészítő valódi útvonalteszt eredménye a tesztrészben. |
| Első éjszaka, fénykép, szoba, rendelő | IMPLEMENTED / képek REVIEW | first_night_director.gd, data/home_day1; meglévő választások és két névtelen páciens. |
| Első napi falu, hazatérés, este | IMPLEMENTED | village_walk_director.gd; hazatérés nulla/részleges/teljes bejárás után is. |
| 2. nap: Hana → Miyako délután → éjszakai látogató | IMPLEMENTED / képek REVIEW | hana_day_director.gd, data/home_day2. Hana székre ülős tulajdonosi javítása megőrzendő. |
| 3. nap: Shion → pecsét → esti tea | IMPLEMENTED, Shion-naplóteszt hibás | Jelenetágak és döntéshatások lefutnak; a teljes Shion-tesztsuite nem PASS. |
| 4–10. nap, napvégi továbbvezetés | MISSING | tea_complete végén nincs következő történeti nap. |
| Naptár: 0. nap + 1–120, 5 napszak, 4 évszak | IMPLEMENTED infrastruktúra | GameState.set_story_time; visszalépés tiltott, új játék nulláz. Day 0 a prológus. |
| Időjárási anomália 30. nap előtti tiltása | IMPLEMENTED API-korlát | set_flag védi, teszt 1–120; nem kész időjárásvezérlő. Day 30-on nem indul automatikusan jelenet. |
| Napi látogatás és tartós felfedezés | IMPLEMENTED futáson belül | visits: nap/napszak/hely; discoveries külön. Visszaút nem jelent új bemutatkozást. |
| Helyszínek újranyitása későbbi napokon | MISSING | A bejárás normál bekötése az első délutánhoz tartozik. |
| Egyszeri, feltételes esemény API | IMPLEMENTED infrastruktúra / bekötés MISSING | event_available/complete_event csak tesztből hívott; nincs történeti ütemező. |
| Kapcsolati döntések és horror | IMPLEMENTED részlegesen | Hana/Shion/Miyako meglévő affinitások; 5 ismert távolságtartási döntés, deduplikáció. Nem teljes route-rendszer. |
| Mashiro időérzékeny meghívás és kizárás | IMPLEMENTED infrastruktúra / jelenet MISSING | invite_mashiro/visit_mashiro/commit_relationship csak tesztben; nincs meghívási UI vagy üvegházjelenet. |
| Mashiro trust/affection, route_active, ending | MISSING | A dokumentumban felsorolt teljes készletből nincs mind megvalósítva. Jogosultsági API nem ending. |
| Ayame karakter, route és napok | MISSING | Nincs ayame a ROUTE_CHARACTERS-ben, karakteradatban, dialógusban vagy azonosított bináris assetként. |
| Hetedik Éjszaka 7/14/21/28 és későbbi ismétlés | MISSING | Nincs ciklusszámláló, eseményfeloldás, túlélési ág vagy automatikus halál. |
| Katsuro új nyomozati útja | MISSING | Korai füzet/pecsétnyomok léteznek; zárt szobai, szereplőkhöz rendelt bizonyítéklánc nincs. |
| Karakterlapok, képek, megszerzett események | IMPLEMENTED részlegesen / REVIEW | character_journal.gd; nem Ayame/Sayuri/Mashiro teljes lapja, nem minden szereplő végleges útvonala. |
| A Hold Két Arca / Sayuri | MISSING | Nincs moon_two_faces vagy Sayuri a kódban/adatban. A mostani pontosítás dokumentált, nem implementált. |
| Mentés, visszatöltés, hosszú távú checkpoint | MISSING | AppSettings beállításmentése nem játékmentés. Kilépés után a GameState-napló nem marad meg. |
| Romantikus utazások, időugrás közbeni eseményfeldolgozás | MISSING | set_story_time tud előrelépni, de a közben átlépett eseményeket nem dolgozza fel. |
| Külön Miyako-folyosó | IMPLEMENTED / asset REVIEW | Meglévő AnimationPlayeres jelenet, egyszeri flag; auditban csak regresszió, nincs duplikálás. |

## 4. Képi és helyszínállapot
A főportré-könyvtárban 41 tényleges kép van: Akira érkezési/orvosi/zöldszemű változatai; Miyako és Hana több reakciója és későbbi állapota; Shion/Kuroe portrék; a két első páciens reakciói; Reina tanári képe.
Az assets/home_day1 7 képet, a home_day2 18 képet tartalmaz. Ez fájlszám, nem egyedi játszható CG-jelenetszám: például Hana ajtóképe több verzióban van jelen. A hivatkozott, javított verziót kell megtartani, nem újragenerálni az egész családot.

| Hely / szereplő | Meglévő anyag | Hiány / korlát |
|---|---|---|
| Reina / iskola | school_v1_REVIEW, school_interior_v1_REVIEW, reina_v1_REVIEW; bemutatkozás és visszalátogatás | Későbbi személyes események még nincsenek. Reina tanár, nem a rendelő asszisztense. |
| Aoi / bolt | shop és shop_interior, aoi_v1_REVIEW | Ayame hozzáadása nem cserélheti le Aoit. |
| Sora / fogadó | inn külső/belső; sora_v1_PLACEHOLDER | Sora production kivágat hiányzik; a jelenlegi kép nem FINAL. |
| Ritsu / műhely | Külön bejárati látogatás, műhelyutcai háttér | Saját portré és külön belső hiányzik. |
| Kuroe / zeneszoba | Meglévő teljes portrék, zenei referenciák, ajtó mint külön pont | A referenciaboard nem tiszta játszható szobaháttér; meghívás és belépő történeti feltétel hiányzik. |
| Shion / veranda | Patak falusi oldalán lévő külső pont, meglévő VN-portrék és emlék-CG-k | Külön verandakép és későbbi saját helyszíni esemény hiányzik. |
| Hana / piac | Nyilvános találkozási pont; rendelői történet/CG-k | A piactér nem Hana otthona. Privát helyszínt nem találunk ki belőle. |
| Oto / szentély | Lépcsőalj, oto_v1_REVIEW | A korai névtelen megpillantás nem személyazonosság-felfedés vagy belépési engedély. |
| Miyako–Akira / otthon és rendelő | Meglévő szobák, reggel/éjszaka és rendelői képek | Katsuro dolgozószobája külön, későbbi helyszín; nincs új nyomozati szobakészlet. |
| Ayame | Tulajdonos szerint két jóváhagyott referencia létezik a chatben | A vizsgált mainben egyik sem azonosítható. Ez repo-integrációs hiány, nem állítás arról, hogy a kép sosem készült el. |
| Mashiro | Locked bible és asset-manifeszt | A manifeszt két referencialapja és öt meglévőként jelzett CG-je nincs a main binárisai között. |
| Himiko / Renka / Sayuri | Himiko specifikáció; Renka helyes reference/characters/RENKA_CHARACTER_DESIGN_V1_REFERENCE.png | Himiko production kép nincs a mainben; Renka referencia nem portrékészlet; Sayuri bibliája, kora, designja és képei nincsenek ebben a forrásban. |

A reference/incoming/2026-10-12/04_red_white_leader_sheet_labeled_renka.png felirata önmagában nem írja felül Renka helyes referenciáját.
A három visszalátogatható belső mellett öt külön külső pont van; ezek nem öt új, kész szobabelső. Akira orvosi portréja és a megszerzett jobb-szem változat megőrzendő. A térképes részen nincs erőltetett járóanimáció.

## 5. Új döntések és meglévő kánon összevetése
| Kérdés | Meglévő állapot | Teendő / minősítés |
|---|---|---|
| Korai misztikum, késői felismerés | data/home_day1/day_evening.json:8 már biztos közös hazugságról beszél; 16. sortól a falu működését értelmezi. day_reflection.json:16-tól erős, általánosító füzetnyom. | REVIEW ütközés. Később célzott szövegfinomítás: bizonytalan észlelés és részleges nyom. Most nem töröltük a jelenetet. |
| Katsuro dokumentumainak rejtegetése | Rendelői névtelen füzet már van; zárt külön szobát clinic_morning.json említi. | A rendelői töredék és a későbbi részletes személyes akták legyenek külön bizonyítékcsoportok. A régi korai füzet nem adhatja meg a végső megfejtést. |
| Katsuro megölése | Nincs elkövető/tanú/elhallgató rendszer. | Tulajdonos jóváhagyta a nyomozati ág lehetőségét; személyek, bizonyítékok és felfedési napok még REVIEW. |
| Misztikus/pszichológiai értelmezés | shion_close és miyako_seal erős emlék/pecsét/„Katsuro hangja volt” állításokat tartalmaz. | A meglévő jelenetek megőrzendők; a későbbi magyarázat nem lehet minden ág kötelező objektív ténye. Narrátori bizonyosság külön szerkesztési ellenőrzést igényel. |
| Mentális problémák | Miyako/Hana pressure-profilok léteznek; nincs diagnózisrendszer. | Tünet, előzmény, választott cselekedet és természetfeletti értelmezés szétválasztása. Nem lesz diagnosis => violence feltétel. |
| Ayame és korábbi karakterbővítési stop | Handoff korábban a meglévő szereplőket priorizálta. | Ayame explicit új tulajdonosi kivétel. Nem nyit általános karaktergenerálást. |
| Ayame 3. napi találkozása | A jelenlegi 3. nap Shion → pecsét → tea, nincs szabad faluablak. | Új, rendezett szabadidős átvezetés szükséges; nem módosítjuk a Shion-választások következményeit. |
| Hetedik Éjszaka vs. korábbi horror_pressure | Utóbbi döntésalapú, 0–6 közé korlátozott; nem heti fenyegetési állapot. | Külön eseménynyilvántartás szükséges a meglévő GameState-en belül. Nem használjuk a régi értéket halálszámlálóként. |
| Fenyegetés és kapcsolati elköteleződés | Külön kapcsolat-API van, de nincs teljes route-UI. | Az éjszakai fenyegetés feloldása nem jelent affinitásjutalmat, szabad beleegyezést vagy automatikus kapcsolatot. A 15. napi döntés külön. |
| 30. nap időjárása | API-korlát már védi; nincs anomáliaesemény. | A 7/14/21/28. napi horror társas, pszichológiai és észlelési eszközökkel épüljön. Sem évszakugrás, sem rendellenes időjárás nem kerülhet elé. |
| Mashiro és Ayame/egyéb utak | Általános exclusivity kód. | Ayame barátsága nem route-commitment. Komoly kapcsolati döntés következményeit a játék előre, érthetően jelezze. |
| A Hold Két Arca | Sem Sayuri, sem moon_two_faces nincs. | Jóváhagyott, dedikált Akira–Mashiro–Sayuri kivétel. A globális Mashiro-szabály marad; nincs új számküszöb vagy automatikus hármas kapcsolat. |

## 6. A 3–10. nap fejlesztési sorrendje
Ez ütemterv. Az Ayame-napok tulajdonosi döntések; a szabadidős ablakok és technikai részletek REVIEW javaslatok.

### Függőségi sorrend
1. Tesztadósság rendezése, a jelenlegi első három nap és portrék rögzített regressziós alapja. Ezután célzott spoiler-szövegfelülvizsgálat, teljes jelenetcsere nélkül.
2. Többnapos falu-újrabelépés a meglévő village_walk_directorban, nap/napszak szerinti eseményválasztással. A főtér, bolt, otthon és visszaút maradjon érthető.
3. Ayame referenciáinak tényleges importja, karakteradatok és 3. napi első találkozás a meglévő VN-ben. Ugyanekkor napvégi továbblépés és minimális, verziózott mentés tervezése/megvalósítása a meglévő GameState adataiból.
4. 4–6. napi történeti egységek, Ayame 5. napi beszélgetése, előkészített segítség-/menekülési lehetőségek. Az első éjszakai veszélyhez ne a veszély pillanatában jelenjen meg először minden kezelőelem.
5. 7. napi esemény és annak nem szexuális túlélési ága; nincs automatikus halál. Mashiro bemutatkozása ettől külön kezelendő.
6. 8–10. napi következmények, Mashiro meghívás időzítése, szabad falu és új események. Csak ezután állítható késznek az 1–10. nap.
7. A 14–15. nap állapotigényeinek kompatibilitása előre tervezhető, de tartalmuk nem minősül késznek a 10. napi mérföldkővel.

| Nap | Történeti munka | Elfogadási feltétel |
|---|---|---|
| 3 | Shion/pecsét/tea megőrzése; közéjük illesztett bolt- és szabadidős ablakban Ayame hétköznapi bemutatkozása. Pontos helye a pecsét után, tea előtt REVIEW. | Aoi továbbra is a bolthoz tartozik; Ayame 28 éves saját karakter. Met flag csak a tényleges találkozás lezárásakor. Nincs korai romantikus elköteleződés. |
| 4 | Az alaptörténet következő részének napokra bontása, nyugtalanító, nem bizonyító nyomok; Himiko korábbi 3–4. napi tervének rendezése. | A VI. fejezet nem azonos a 6. nappal. Himiko pontos belépőszövege és stagingje jóváhagyandó; a meglévő szereplők nem tűnnek el miatta. |
| 5 | Ayame személyesebb beszélgetése; saját cél, elfoglaltság, határok. | A 3. napi találkozás hiányának külön, egyeztetett kezelése. Barátság és érdeklődés érvényes; jelenet nem jelenti a későbbi éjszaka elfogadását. |
| 6 | Hétköznapi találkozások, segítségkérés és útvonalak előkészítése; finom társas feszültség. | A nem szexuális megoldások kezelése érthető és kipróbálható; nincs időjárási torzulás vagy kész diagnózislista. |
| 7 | Ayame első éjszakai látogatása; első Hetedik Éjszaka. Mashiro nappali bemutatkozásának javasolt napja külön ütemezendő. | A nappali meghívás nem azonos az éjjeli fenyegetéssel; olvasóvezérelt jelenetek, szünet, döntési szabadság, legalább egy valóban végigjátszható nem szexuális túlélési út. |
| 8 | A választott éjszakai megoldás következményei és külön nappali beszélgetés. Ha Mashiro a 7. napon hívott: rendelés utáni optimális első látogatás. | Nincs utólag feltételezett beleegyezés vagy romantikus jutalom; játékos döntése és eseménynapló egyezik. |
| 9 | Karakterenként eltérő visszajelzések, részleges nyomok és szabad helyszínlátogatás. | Sem az összes nő közös bűnössége, sem az objektív világmagyarázat nem automatikus következtetés. |
| 10 | Az első nagy szakasz lezárása és folytatható napvégi állapot; nyitott kapcsolatok, 14. napi következmények előkészítése. | Új játékból elérhető, nem csak tesztből beállított day=10; mentés/visszatöltésből is konzisztens folytatás. |

Nem szexuális ágakhoz REVIEW változatok: előre előkészített útvonalon távozás; segítségkérés és közös ellenállás. Ezek alternatív történeti megoldások, nem a Kollektíva szexuális szabályának utólagos átírásai. Pontos helyük, áraik és eseményeik külön történeti kidolgozást igényelnek; egyik sem jelenthet rejtett, elkerülhetetlen halált.

## 7. Story + Visual + Audio assetlista
Minden új útvonal és fájlnév az alábbi táblában tervezett deliverable, nem állítás létező fájlról.

| Prioritás | Típus | Szükséges anyag / újrahasznosítás | Státusz és elfogadás |
|---|---|---|---|
| P0 | Story | 3. napi szabadidős átvezetés és Ayame első találkozása | MISSING; a bolti szerepek, névfeloldás és Shion/tea sorrend rögzítendő. |
| P0 | Visual | Ayame két jóváhagyott referenciaeredetije | MISSING IN REPO; import és forrásazonosítás előbb, újragenerálás nélkül. |
| P0 | Visual | Ayame átlátszó teljes alak és szükséges hétköznapi reakciók | MISSING; csak az elfogadott referencia alapján, tájolás/kezek/azonos arány ellenőrzéssel. |
| P0 | Story | Napléptetés, helyszíni eseményfeltételek, elmulasztott találkozás ágai | MISSING bekötés; egy meglévő GameState + VN. |
| P0 | Story | Katsuro-jegyzetek bizonyítéktáblája | MISSING: forrás, hely, szükséges tudás, hitelesség, elkövető/tanú/elhallgató szerepek. Az érintetteket nem találjuk ki automatikusan. |
| P0 | Story | Ayame 5., 7., 14., 15. napi külön jelenetei | MISSING; 15. napi kölcsönös, józan döntés külön esemény. |
| P0 | Story | Hetedik Éjszaka első eseménye, megszakítás/menekülés/ellenállás és utóhatás | MISSING; nem szexuális sikerút, nincs önkényes halálfeltétel; intim esemény nem romantikus pontjutalom. |
| P1 | Visual | Meglévő bolt, otthon, Akira orvosi portré és kényelmes párbeszédtájolás | IMPLEMENTED / REVIEW: újrahasznosítandó; nem kell újragenerálni. |
| P1 | Visual | 7. éjszakai látogatás és nem szexuális menekülés/ellenállás CG/staging | MISSING produkció; elfogadott kompozícióból, nem grafikus fenyegetésábrázolással, meztelenség nélkül is működő vágatokkal. |
| P1 | Visual | Katsuro dolgozószobája, íróasztal/iratköteg, olvasható feljegyzésrétegek | MISSING; a rendelő háttere nem helyettesíti a titkos dolgozószobát. |
| P1 | Visual | Mashiro karakterlapok és meglévő CG-k | MISSING IN REPO; docs/MASHIRO_ASSET_MANIFEST.md két referencia + öt korábban jóváhagyottként felsorolt CG importja. |
| P1 | Visual | Himiko belépőkép/portré, Renka későbbi portréja | MISSING production; létező specifikáció/referencia megőrzése. |
| P1 | Audio | Hétköznapi bolt: csengő, teaedények, gyógynövény/papír foley | MISSING külön készlet; diszkrét ismétlődő hangok, feliratozható fontos jelzések. |
| P1 | Audio | Éjszakai lépések, kopogás, távoli csoporthang, csendbe váltás | Jelenleg procedurális REVIEW alapok; célzott hangok és mix MISSING. Fenyegető társas környezet, nem természetellenes időjárás. |
| P1 | Audio | Menü/pause és párbeszéd alatti hangerő, ágankénti leállítás | Részben meglévő AudioStreamPlayer infrastruktúra; új jelenetekben tesztelendő. |
| P2 | Story | Szereplőnkénti pszichológiai profil | REVIEW: tünet, előzmény, hétköznapi működés, trigger, önálló cél, határok, védő tényezők; diagnózis csak írói javaslat. |
| P2 | Story / Visual | Sayuri bibliája, jóváhagyott megjelenése és moon_two_faces eseménylánc | MISSING; a külön befejezés feltételei dokumentáltak, küszöbök/napok nyitottak. Nem az 1–10. napra kényszerítendő végjáték. |
| P2 | Audio | Karaktermotívumok, narratív zene és szinkron | Nincs igazolt végleges hangcsomag; opcionális produkció, nem előfeltétele a szöveges prototípusnak. |

Pszichológiai profilok kiinduló, már elfogadott tematikái: Miyako birtoklás/függőség; Hana bizalom/önrendelkezés; Shion emlékezet/identitás; Kuroe szabadság/kontroll; Himiko szakmai hatalom/családi konfliktus; Reina felelősség/autonómia; Renka korrupció/múlt; Mashiro gyógyulás/őszinteség. Ezek nem diagnózisok. Ayame saját profilja, Aoi/Sora/Oto/Ritsu részletezése és Sayuri háttere külön kidolgozandó.

## 8. Regressziós terv
Minden egység: először a módosítással érintett állapot- és jelenetteszt, majd az összefüggő út. Nem jelölhető késznek csak tesztbeli flag-beállítással.

| Terület | Kötelező teszt |
|---|---|
| Megőrzött alap | Új játék/skip → kapu → Miyako → házbelső → első éjszaka → két páciens → falu → esti folytatás; mindkét fő döntési ág, változatlan korábbi pontok. |
| Hana / Shion / Miyako | Minden meglévő döntéskombináció; ismételt callback nem dupláz; zöld jobb szem csak pecsét után; Miyako átalakulása korán hamis. |
| Ayame | 3. napnál korábbi bemutatkozás tiltott; 3/5/7 esemény egyszer indul; elmulasztott találkozás egyeztetett ága; Aoi és Ayame külön adatlap és portré. |
| Többnapos falu | Napi látogatás új napkor új számlálás; felfedezés és bemutatkozás megmarad; haza/vissza bármikor a szabad szakaszban; VN vagy fade alatt nincs új utazás. |
| Nap és időugrás | 1/29/30/31/60/61/90/91/120 határok; negatív, >120 és visszafelé lépés tiltott; időugrás nem hagyhatja ki csendben a kötelező éjszakát, hanem egyeztetett eljárást követ. |
| Hetedik Éjszaka | 6→7, 7 nappal→éjjel, 13→14, 20→21, 27→28, 34→35; nap+esemény szerint egyszeriség, pause/resume, ismételt belépés és visszatöltés. Egy általános once flag nem elég minden hétre. |
| Túlélési választások | Legalább egy nem szexuális ág ténylegesen végigjátszható és folytatható; nincs automatikus halál a 28. napon; nincs affinitás vagy beleegyezés kikövetkeztetése fenyegetésből. |
| Ayame kapcsolat | 14. napi esemény nem oldja fel automatikusan a 15. napi kapcsolatot; a józan kölcsönös döntés külön; visszautasítás nem írható át később beleegyezéssé. |
| Mashiro | Meghívás 5–10., első látogatás legkorábban következő délután; 1/2/3–4/5+ nap külön; barátság nem kizárás; komoly másik route/hárem továbbra is általános kizáró feltétel. |
| moon_two_faces | Csak a dedikált Akira–Mashiro–Sayuri kivétel; minden más kombináció elutasítva; mindhárom folyamatos beleegyezése és Mashiro–Sayuri önálló kapcsolata szükséges; küszöbtesztek csak véglegesítés után. |
| Nyomozás | Zárt szoba és rendelő külön; el nem olvasott dokumentum nem kerül naplóba; közvetlen elkövető, tanú és elhallgató nem összevont bűnösségflag; világmagyarázat ágspecifikus. |
| Időjárás | 1–29 minden új ágon természetes; 28. napi rossz vég sem kerülheti meg. A 30. nap első konkrét anomáliáját külön jelenet tesztelje majd. |
| Visual / UI | 640×360 és integer scale, nearest/pixel snap; teljes alak, megfelelő tájolás; választások/szöveg nem takarják egymást; CG után helyes portré-visszaállás. |
| Audio | Szünet és jelenetváltás nem hagy áthallatszó loopot; hang nélküli játékban is érthető fontos esemény; nincs időjárási horrorhang korai meteorológiai anomáliaként. |
| Mentés | Verziózott adatformátum, sérült adat kezelése, régi session migráció; pending/completed esemény és választás nem dupláz; új játék tényleges nullázás. |
| 10. napi mérföldkő | Egyetlen normál új játékból, választásokkal és visszalátogatásokkal elérhető 10. nap; mentésből ugyanaz a világ- és kapcsolati állapot. |

## 9. Nyitott döntések / blokkolók
- Ayame két meglévő képfájljának tényleges elérése és az első találkozás szövege.
- Mashiro képeinek importja; jóváhagyott titkos kivétele már pontosított, annak számai/eseményei/napjai továbbra is nyitottak.
- Hetedik Éjszaka konkrét nem szexuális alternatívái és a 28. napi rossz befejezés pontos, jóváhagyott feltételei.
- Katsuro ügyében ki mit tett, látott vagy hallgatott el; a bizonyítékok sorrendje és a szoba megnyitása.
- Ayame 3. napi, Himiko 3–4. napi és a meglévő Shion/pecsét/tea sorrend végleges rendezése.
- Sayuri önálló specifikációja; nem azonosítjuk automatikusan a régi forrás más, hasonló nevű nőalakjával.
- A hibás regressziók helyreállítása és kilépési ObjectDB figyelmeztetések kivizsgálása.

## 10. Tényleges Godot-eredmények
A 2026-10-19-i tiszta `ccf6fbc` futásban **17 eredeti tesztből 14 PASS, 3 FAIL**. A kiegészítő `current_entry_audit` PASS: összesen 18 futásból 15 sikeres. Ez nem hibátlan teljes regresszió.

- PASS: calendar, opening/gate_flow, main_menu, chapter_select, night_day, village_walk, hana_day, afternoon, night_visitor, seal, tea (9 kombináció), character_journal, character_pressure, miyako_hallway.
- FAIL — vn_dialogue: a régi, kézzel felállított belépési fixture-ben az E nem indította a VN-t. A tényleges kapu → híd → ház út mindkét döntése a külön `current_entry_audit` tesztben sikeres; az eredeti hibát ez nem törli.
- FAIL — interior: belépési feltételek hibái után a teszt nem létező `choice_box`-ot olvasott. SCRIPT ERROR, majd a képkockakorlát zárta le; a 0 kilépési kód itt **nem PASS**.
- FAIL — shion_session: mind a négy döntéskombinációban kizárólag a napló fix két eseményt váró ellenőrzése hibás. Az aktuális napló a dallamdöntést és adott esetben a beleegyezés kérését is megjeleníti. A többi ellenőrzés lefutott; a suite ettől még FAIL.
- A main_menu, village_walk, hana_day és afternoon sikeres futások végén is maradt 2–4 ObjectDB példányra vonatkozó figyelmeztetés. Takarítási adósság, nem elhallgatott tiszta kilépés.
- Editor-import elkészült; az audit nem módosította a production kódot vagy képeket.

Vizuálisan ellenőrzött friss futási képek: első páciens, Hana javított ajtó-CG, Shion karakterlap, normál Miyako esti tea, iskolai visszalátogatás, falutérkép. A szöveg és a kezelőszervek ezekben a vizsgált állapotokban elfértek. Nem állítunk teljes kézi végigjátszást vagy végleges művészeti jóváhagyást.

## 11. Utólag beérkezett referenciák — 2026-10-20
A tulajdonos időközben átadta a Mashiro és Ayame ZIP-eket. Ez feloldja a fájlok elérhetőségi blokkolóját, de nem változtatja meg visszamenőleg a vizsgált `ccf6fbc` main állapotát. A fenti MISSING IN REPO státuszok az auditált commitra vonatkoznak. A beérkező fájlok hozzárendelése és production alkalmassága külön ellenőrzés.
A következő egység: 3. nap előkészítése a Shion → pecsét → Miyako tea megtartásával; Ayame bemutatkozása és Himiko későbbi érkezésének előkészítése. Az első Hetedik Éjszaka csak a 3–6. nap következetes kidolgozása után következhet.
