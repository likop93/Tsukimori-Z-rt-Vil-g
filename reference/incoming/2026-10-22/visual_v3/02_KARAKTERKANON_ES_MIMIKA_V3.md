# TSUKIMORI — karakterazonosság és Miyako expression bible V3
**Státusz:** tulajdonos által jóváhagyott *azonosság* + PROPOSED arckifejezés-terv. **Nem Godotba integrált asset.**
**Kelt:** 2026-10-20

## Elsőbbség
Kifejezett, friss tulajdonosi választás > a csomagban lévő friss felhasználói referencia > GitHub korábbi műszaki/REVIEW anyag > régi, hibás képgenerálások.
A régi `docs/DECISION_LOG.md` buszos/gyalogos és kézi mozgásos megjegyzéseit a későbbi tulajdonosi döntések *az érintett kérdésben* felülírják. A többi LOCKED földrajzi/történeti tétel megmarad.

## A. AKIRA — jóváhagyott kanonikus arc és hétköznapi megjelenés
- Elsődleges képek: `01_KANONIKUS_KEPREFERENCIA/AKIRA_TULAJDONOSI_EGYALAKOS_PORTRE.png` (arc, testarány és részletek); `AKIRA_TULAJDONOSI_KARAKTERLAP.png` (nézetek, arckifejezések, sziluett). Ezeket a tulajdonos közvetlenül adta át.
- Életkor: 32; karcsú-atletikus; fekete, rendezetlen, rétegzett haj; barna szem; nincs szemüveg (az opcióként feltüntetett szemüveg NEM kerül be); nem szőke.
- Hétköznapi ruhatár a korai játékban: szürke kapucnis felső felett sötét/fekete városi kabát, világos szürke/fehér póló, sötét nadrág, sötét utcai cipő; órája és vállpántja opcionális a jelenet szerint. **NEM a korábbi fekete elegáns öltönyös, szemüveges generált férfi.**
- A **fehér orvosi köpeny kizárólag tényleges rendelési/gyógyítási kontextusban** viselhető, és alatta ugyanaz a kanonikus Akira marad. Hazatéréskor, vezetéskor, falunézéskor, teázáskor nincs köpeny.
- A jelenlegi Godot-portré `assets/opening/vn_portraits/akira_neutral_v1_REVIEW.png` régebbi, felülvizsgálandó staging asset; az eredeti `assets/opening/reference/AKIRA_FINAL_CHARACTER_DESIGN_V1.png` egyeztetendő a csatolt friss képekkel. Ez az átadás az utóbb feltöltött képeket tekinti az új vizuális referenciának.
- Az exes trauma bevillanásaihoz is ugyanaz az arc kell, nem alternatív főhős. A képek erősebb pszichológiai és filmes horrort mutathatnak, de az ex arca/múltjának tényállása ne kerüljön túl korán leleplezésre.

## B. MIYAKO — tulajdonosi, eredeti fekete ruhás karakter
- Elsődleges forrás: `01_KANONIKUS_KEPREFERENCIA/MIYAKO_TULAJDONOSI_EREDETI_PORTRE.jpg` (az utóbb feltöltött kép).
- Felnőtt nő, hosszú sötétbarna haj részben feltűzve, arany hajdísz/fityegők, barna szem, finom arcvonások, elegáns sötét/charcoal öltözet magas nyakkal, szövetmintás, arany részletekkel. Alapsziluett és arányok minden koraijelenetben változatlanok.
- Korai alapruha a fenti kép. Az `docs/MIYAKO_TEA_WARDROBE_REVIEW.md` külön, késő esti ruhatárat enged az adott jelenethez, **de az első találkozásnál és minden nem átöltözős jelenetnél marad a fekete eredeti**. Eltérő ruha nem jár új arccal.
- Nap 0–3: sem ezüst haj, sem kék szem, sem testarány-változtatás; természetfeletti változás csak későbbi dramaturgiai trigger után. Ha létrejön, maradandó (a későbbi történetszabály értelmében), de ez nem a korai CG-csomag része.
- **Miyako nem mindig komor:** meleg, finom humorú és figyelmes oldalát is látjuk; a bizonytalanság később erősödik fel. Nincs konstans fenyegető vagy üres arckifejezés.

## C. MIYAKO expression set — PROPOSED, 8 nézet
**Szigorú képi stabilitás:** pontosan azonos arc, hajkontúr, barna írisz, aranydísz, ruhaujj, testarány, vágás, fény, alfa-sziluett. Ne rajzoljon új női arcot vagy új frizurát minden változathoz. VN portréhoz tiszta alfa, szöveg/UI nélküli export.

| ID | Érzelem | Mikrokifejezés, testtartás | Tipikus használat | Tiltás |
|----|---------|---------------------------|-------------------|--------|
| M00_NEUTRAL | alap / figyelő | enyhén komoly, kiegyensúlyozott száj, természetes pillantás | első bemutatkozás második mondattól; hétköznap | nem harag |
| M01_WELCOME | finom köszöntő mosoly | ajaksarok alig emelkedik, szem lágy | „Dr. Akira. Már vártam.”, vendégfogadás | ne legyen túl széles vigyor |
| M02_WARM | őszinte melegség | lágyabb szem, enyhe mosoly, ellazult váll | nyugodt tea, közös étkezés | nem csábító mimika kötelezően |
| M03_AMUSED | halk játékosság | egyik szemöldök enyhén fel, száj sarka megemelkedik | humor, oldott reggeli replika | nincs karikatúrás arc |
| M04_CURIOUS | érdeklődő | fej alig billen, szemkontaktus aktív | Akira múltjáról kérdez | ne utaljon biztos titoktudásra |
| M05_CONCERNED | aggódó | szorosabb szemöldök, száj zárt | fáradtság, nehéz múlt, éjszakai nesz | nem pánik |
| M06_WATCHFUL | rövid, nyugtalanító figyelés | mosoly eltűnik, szem enyhén összeszűkül | Katsuro dolgozószobája, elterelő válasz | nap 0–3 ne legyen teljes megszállottság |
| M07_VULNERABLE | sebzett / visszafogott szomorúság | lefelé néz, szem fényes lehet, ajkak enyhén megnyílnak | egy kései őszinte pillanat | nincs indokolatlan sírás |

**Gyártási minimum**: első integráció M00 / M01 / M02 / M05 / M06. Második kör: M03 / M04 / M07. Azonos alapképet célzott *expression edit*-tel módosíts, ne teljes képgenerálással. Ha nem lehet az identitást megőrizni, az expression változat helyett ideiglenesen a jóváhagyott M00 marad.

## D. AKIRA reactions — PROPOSED
A00_NEUTRAL, A01_SMALL_SMILE, A02_FOCUS, A03_UNEASY, A04_TIRED. Azonos, szemüveg nélküli fej. Az első körben elég az alap + A03; lehetőség szerint a felhasználói karakterlap reakcióiból reprodukálható, nem új Arc ID.

## E. Szín/kompozíció és QA
- A források karakter-azonossági referenciák; a játék **LOCKED 2.5D cinematic pixel-art** renderirányát nem írják felül. Production export: 16:9 CG, Godot cél 640×360 és igény szerinti nagyobb natív generálási méret; portrait alpha PNG. A végleges pixel-art részletesség külön jóváhagyást igényel.
- Külön CG ne használjon kollázst, panelkeretet, fejlécet, ráégetett feliratot, watermarkot vagy dialógusdobozt.
- Kontroll: arc/haj/ruha egyezés; Akirán nincs szemüveg; nincs fehér köpeny nem-klinikai jelenetben; Miyako barna szemű és hajú a korai napokon; csak történetileg indokolt felnőtt szereplők kerülnek a jelenetbe.
- Az új portrék státusza PROPOSED / REVIEW; az alap referencia *jóváhagyott*, nem jelent automatikus engedélyt minden új generálásra.
