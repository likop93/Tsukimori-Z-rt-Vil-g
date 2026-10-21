# Tsukimori — Character Bible

**Verzió:** 1.0  
**Státusz:** aktív karakterkánon  
**Dátum:** 2026-09-24

## Használati szabály

Karaktermodell, portré, animáció, ruha, arckifejezés vagy jelenetrendezés előtt ezt a dokumentumot ellenőrizni kell.

A `LOCKED` karakterdöntést nem írhatja felül automatikusan generált asset, proxy, korábbi koncepció vagy más karakterhez tartozó vizuális jegy.

A jóváhagyott konkrét képi referenciák és státuszaik: `docs/VISUAL_REFERENCE_INDEX.md`. Ha egy referencia-lap automatikus szövege ütközik ezzel a Character Bible-lel, mindig ez a dokumentum az irányadó.

---

# Dr. Akira

## Identitás

- férfi főhős;
- **orvos**; terápiás/pszichológiai munkát is végezhet, de nem pusztán terapeuta;
- kontrollált, megfigyelő személyiség;
- nem klasszikus fantasy-hős;
- Tsukimoriban Katsuro egykori házába/rendelőjébe érkezik;
- **Akira szakmai identitása: orvos.** A terápiás/pszichológiai kompetencia a karakter része, de nem írhatja felül vagy szűkítheti le az orvosi szerepét;
- tisztánlátása vágyakat, félelmeket, hazugságokat, elfojtott önképet és természetfeletti nyomást érzékel;
- elemi motívuma: **szél**;
- későbbi kulcsmondat: **„Én vagyok a szél.”**
- későbbi cím: **„A Bukottak Királya.”**

## FINAL vizuális irány — LOCKED

LOCKED:
- **fekete haj**;
- Akira vizuális identitását nem szabad Lofttal összemosni;
- normál emberi, nyúlánk/karcsú-atletikus arány;
- sötét, elegáns, de praktikus megjelenés;
- nem chibi;
- nem fotórealista;
- Tsukimori anime-stilizált 3D art directionjéhez igazodik.

LOCKED megjelenés:
- kb. 180 cm;
- korai harmincas, felnőtt férfi arc;
- enyhén rendezetlen, nagyobb tincsekben olvasható fekete haj;
- intelligens, komoly, figyelő arc;
- karcsú-atletikus testalkat;
- sötét charcoal/fekete, modern, rétegzett városi felsőruházat;
- puhább belső réteg / kapucnis réteg megengedett és a jóváhagyott design része; elsődleges külső réteg: **sötét kapucnis kabát** (tulajdonosi döntés, 2026-10-20);
- sötét, karcsú nadrág és praktikus sötét cipő;
- visszafogott karóra;
- **szemüveg nélkül, véglegesen** (tulajdonosi döntés, 2026-10-20; a korábbi „opcionális variáns” felülírva);
- hosszabb kabát későbbi alternatív outfit lehet, nem az elsődleges sziluett;
- a Black Fan motívum előrevetíthető, de ne legyen feltűnő cosplay-dísz.

A 3D gyártási specifikáció: `docs/AKIRA_PRODUCTION_SPEC.md`.

## Akira animációs nyelve — LOCKED

Alapelv:

> Minél furcsább dolog történik Akira körül, annál kevésbé reagál látványosan.

Jellemző:
- szem reagál először;
- fej utána;
- váll/test csak szükség esetén;
- kontrollált reakció;
- nincs nagy anime-hátrahőkölés;
- nyugodt járás;
- figyelő tekintet;
- finom súlyáthelyezés;
- kabát kézzel tervezett secondary motion + csak finom procedurális rásegítés.

FINAL locomotion:
- **in-place**;
- Godot CharacterBody3D mozgatja a karaktert;
- root motion csak külön cinematic kategóriában megengedett.

Első FINAL locomotion batch:
- `AKIRA_Idle_Base_01`
- `AKIRA_Walk_Loop`
- `AKIRA_WalkStart_L/R`
- `AKIRA_WalkStop_L/R`
- `AKIRA_Turn45_L/R`
- `AKIRA_Turn90_L/R`

Az első gyártási validáció csak Idle + Walk után folytatható a teljes csomagra.

---

# Miyako

## Identitás

- Katsuro özvegye;
- Akira fő érzelmi és romantikus ellenpontja;
- Katsuro egykori házához, rendelőjéhez és a régi rendszerhez kötődik;
- Akira és Miyako kapcsolata slow-burn, bizalomra épül;
- képes lehet átalakulások/korrupció semlegesítésére;
- kezdetben sötét hajú, elegáns, fekete gyászruhás megjelenés;
- később vizuálisan változhat, de ezt külön jóvá kell hagyni.

## FINAL vizuális irány — LOCKED

**Design A — Primary FINAL**
- kb. 165 cm;
- korai harmincas, felnőtt nő;
- karcsú, nőies, elegáns testalkat;
- hosszú, sötétbarna/feketébe hajló haj;
- részben feltűzött, rendezett hajforma;
- melankolikus, méltóságteljes, kontrollált arc;
- fekete/charcoal, rétegzett, gyászruhás alapoutfit;
- finom arany/bordó díszítés;
- hosszú, elegáns sziluett;
- sötét, praktikus-elegáns lábbeli.

**Design B — Ceremonial / Detail Exploration**
- szintén megtartott hivatalos vizuális referencia;
- nem cseréli le Design A-t;
- használható belőle: hajdísz, bordó–arany részletnyelv, textilminták, díszesebb ceremoniális outfit, bizonyos arckifejezések;
- különleges/szentélyi/ceremoniális jelenetekhez használható;
- a lapon szereplő téves szerepleírások — „házvezető”, „szentélyi gondozó” — **nem kánonok**.

A 3D gyártási specifikáció: `docs/MIYAKO_PRODUCTION_SPEC.md`.

## Mozgásnyelv — PRODUCTION LOCK

- kontrollált;
- kevés felesleges testsúlyváltás;
- lassabb, tudatos kézmozdulatok;
- hosszabb szemkontaktus;
- érzelmi kibillenést apró gesztus árul el;
- félbehagyott mozdulat, elfordított tekintet, megálló kéz fontosabb, mint nagy reakció.

Alapelv:
> Miyako érzelmeit gyakran egy félbehagyott mozdulat árulja el.

Első animációs batch:
- `MIYAKO_Idle_Base_01`
- `MIYAKO_Walk_Loop`
- `MIYAKO_Turn_Soft_L/R`
- `MIYAKO_FoldHands`
- `MIYAKO_Wait`
- `MIYAKO_LookAway`
- `MIYAKO_SoftGesture`

Első találkozási kánon:
**„Dr. Akira. Már vártam.”**

---

# Shion

## Identitás

- fekete haj;
- **zöld szem — LOCKED karakterjegy**;
- karcsú, visszafogott;
- vízhez, emlékezethez és szentélyhez kötődik;
- Oto vitte le gyerekként a mélybe;
- Kuroe korábbi barátnője;
- háza a patak falusi oldalán van.

## FINAL vizuális irány — LOCKED

- hosszú fekete / nagyon sötét ibolyás haj;
- hideg holdfényben ezüstös-lilás edge-light;
- finom virágos hajdísz;
- sötét fekete / mély ibolya, japán ihletésű rétegzett Primary outfit;
- finom virágminták;
- törékeny, hosszanti, csendes sziluett;
- a vizuális motívum: **víz + holdfény + emlékezet + csend**;
- nem Miyako 2.0 és nem harsány goth;
- a jóváhagyott referencia-lap képi elemei az irányadók; a rajta automatikusan generált életrajzi számok/szövegek nem válnak automatikusan történeti kánonná.

A 3D gyártási specifikáció: `docs/SHION_PRODUCTION_SPEC.md`.

## Mozgásnyelv — PRODUCTION LOCK

Alapelv:
> Shion akkor a legnyugtalanítóbb, amikor túl kevéssé mozog.

- nagyon kis testsúlyváltás;
- hosszabb statikus pózok;
- szem gyakran előbb vált, mint a fej;
- lassú, csekély fejfordítás;
- néha szinte természetellenesen mozdulatlan;
- a haj és ruha finom, puha secondary motiont kap.

Első animációs batch:
- `SHION_Idle_Base_01`
- `SHION_Walk_Loop`
- `SHION_Turn_Slow_L/R`
- `SHION_LookAside`
- `SHION_StillHold`
- `SHION_SmallSmile`
- `SHION_WaterObserve`

---

# Kuroe

## Identitás

- felnőtt nő;
- sötét, modern, zenei/művészi karakter;
- Shion korábbi barátnője;
- leszbikus;
- Akira az első férfi, aki iránt később valódi vonzalom alakulhat ki benne;
- hegedű/zongora/zene motívum;
- Akira jövőbeli mahagóni gitárjának ötlete tőle ered;
- a hangszer külső motívumai közül Miyako motívumai dominálnak.

## FINAL vizuális irány — LOCKED

- nagyon hosszú, sötétlila / majdnem fekete haj;
- lila / ametiszt szem;
- fekete/lila virágos-masnis hajdísz;
- elegáns, modern, enyhén gótikus összhatás;
- fekete testhezálló ruha, áttetsző csipkés felsőrész;
- fekete öv, finom láncos/lila kristályos kiegészítők;
- combpánt / harisnyapánt részletek;
- hosszú fekete kabát vagy blézer;
- erősen nőies homokóra-sziluett;
- keskeny derék, hangsúlyos csípő és telt combok;
- **nagyon nagy, telt mellkas**, a primary referenciánál is hangsúlyosabb production aránnyal;
- karakterkülönbség: Hana földeltebb/bujább, Himiko monumentális Empress, Kuroe elegánsabb és sötét glamour jellegű.

Elsődleges képi referencia:
`/Tsukimori Visual References/characters/KUROE_PRIMARY_CHARACTER_REFERENCE_V1.png`

Támogató referenciák:
- `KUROE_STORY_KEY_VISUAL_V1.png`
- `KUROE_MUSIC_ROOM_REFERENCE_V1.png`

Production specifikáció:
`docs/KUROE_PRODUCTION_SPEC.md`

## Mozgásnyelv — PRODUCTION LOCK

Alapelv:
> Kuroe úgy mozog, mintha mindig tudná, hogy figyelik — de nem azért mozog, hogy figyeljék.

- lassú, kontrollált testsúlyváltás;
- elegáns járás;
- kevés fölösleges kézmozgás;
- oldalról megfigyelő testtartás;
- késleltetett fejfordítás szemkontaktus után;
- finom félmosoly;
- haj/kabát visszafogott secondary motion;
- nincs komikus fanservice animáció.

---

# Hana

## Átalakulási irány — OWNER APPROVED, 2026-10-10

Az átalakult Hana karcsúbb, lágyabb, nőiesebb megjelenése elfogadott irány. Ez kifejezetten felülírja a korábbi, átalakuláskor nagyobb/teltebb testre vonatkozó kérést. Viselkedése az alap magabiztosság ellentéteként elbizonytalanodó, majd alárendelődő és jóváhagyást kereső. A viselkedés és a testalkat együtt a karakter saját természetfeletti változása, nem általános összefüggés.

Az elfogadott átalakulási vizuális referencia: `assets/opening/vn_portraits/hana_casual_deferential_v2_REVIEW.png` (bordó nőies top, magas derekú farmer rövidnadrág). Az eredeti Hana alapdesignja megmarad. A korábbi teltebb kimonós átalakulási asset átmeneti REVIEW; későbbi változatait a karcsúbb irányhoz kell igazítani. A hétköznapi ruhaváltás történeti bevezetése még hátralévő munka.

## Identitás

- felnőtt nő;
- meleg barna/tan bőr;
- nagyon hosszú, sötét, hullámos haj;
- arany virágos hajdísz;
- vörösesbarna szem;
- erős, közvetlen, testi/fertilitási energia.

## FINAL vizuális irány — LOCKED

- **meleg barna / tan bőrtónus**;
- nagyon hosszú, dús, hullámos sötétbarna/majdnem fekete haj;
- vörösesbarna szem;
- arany virágos hajdísz és finom arany függők;
- telt, erőteljesen nőies, buja testalkat;
- **nagyon telt mellkas / nagy keblek** a karakter felismerhető designjegye;
- hangsúlyos csípő és formásabb combok;
- fekete–bordó–arany, japán ihletésű primary outfit;
- mély dekoltázs;
- virágmintás textil és díszített obi-jellegű öv;
- összhatás: **testiség + élet + hagyomány + termékenységi energia + melegség**.

Elsődleges képi referencia:
`/Tsukimori Visual References/characters/HANA_FINAL_CHARACTER_DESIGN_V1.png`

A production specifikáció:
`docs/HANA_PRODUCTION_SPEC.md`

## Történeti route-motívum — APPROVED

- Hana élet/termékenység motívuma a történetben konkrét testi jelenségként is megjelenik: tartós, orvosilag nem teljesen magyarázható tejtermelés.
- A bizalom kialakulása után Akirához fordul gépi fejéshez; a jelenetek funkciója a szégyen, elfogadás és bizalom fejlődése, nem erotizált kezelés.
- Himiko férje korábban szexuális erőszakot követett el Hana ellen; Hana gyermek-szála ehhez a traumához kapcsolódik.
- Hana a játék korai/középső részében **nem materiálisan terhes**; Tsukimori egy természetfeletti életmagot / felfüggesztett gyermek-energiát tart Hanában, fizikai magzat nélkül.
- A tartós tejtermelés ennek az életenergiának és a hely torzító hatásának egyik jele.
- A Hana-route végjátékában Akira energiája felülírja az életmag korábbi apai/eredeti lenyomatát; amikor a gyermek végül materiálissá válik, **Akira és Hana gyermeke** lesz.
- A pontos materializálódási szabály és jelenet későbbi történeti kidolgozás.

## Mozgásnyelv — PRODUCTION LOCK

Alapelv:
> Hana nem siet el a saját jelenlétéből.

- közvetlenebb és földeltebb mozgás;
- láthatóbb testsúlyváltás;
- stabilabb állás;
- nyugodt, magabiztos kézgesztusok;
- természetes, közvetlen szemkontaktus;
- több fizikai jelenlét, mint Miyakónál vagy Shionnál;
- secondary motion finom és fizikai, nem komikus fanservice effekt.

---

# Himiko

## Identitás

- Hana nővére;
- felnőtt nő;
- orvos / pszichiátriai karakterirány;
- rendkívül magas, domináns jelenlét;
- az „Empress” vizuális pólus.

## FINAL vizuális irány — LOCKED

- kb. 200 cm-es vizuális karakterérzet;
- hosszú, gazdag vörös haj;
- heterokrómia: egyik szem kék, a másik nagyon világos / majdnem fehér;
- érett, intelligens, kifinomult arc;
- nyugodt, sokatmondó félmosoly;
- monumentális, erősen nőies sziluett;
- **rendkívül telt mellkas / extrém nagy keblek** mint LOCKED designjegy;
- **szélesebb csípő, nagyobb far, vastagabb és erősebb combok** mint LOCKED Empress-arány;
- hosszú lábak, keskenyebb derék, egyenes testtartás;
- fehér elegáns top;
- fekete magas derekú ceruzaszoknya;
- fehér orvosi köpeny variáns;
- kb. 10 cm-es magassarkú vizuális érzet;
- összhatás: **Empress + intelligencia + pszichológiai dominancia + városi kifinomultság**.

Elsődleges képi referencia:
`/Tsukimori Visual References/characters/HIMIKO_FINAL_CHARACTER_DESIGN_V1.png`

A production specifikáció:
`docs/HIMIKO_PRODUCTION_SPEC.md`

## Trauma-háttér — APPROVED

- Himiko férje korábban szexuális erőszakot követett el ellene.
- A rögzített forma anális szexuális erőszak.
- Himiko esetében ehhez **nem kapcsolódik terhesség vagy elzárt magzat**.
- A trauma a kontroll, kiszolgáltatottság és orvosi bizalom témáiban jelenik meg; nem erotizált háttérelem.

## Személyiség — LOCKED

- királynői önbizalom és felsőbbrendűség-érzet;
- büszke, elegáns, néha lekezelő;
- pszichológiailag éles és tudatosan domináns;
- ritkán mutat valódi gyengédséget;
- Akira azért kelti fel különösen az érdeklődését, mert nehezen uralható vagy zökkenthető ki;
- a felhasználó által megjelölt Boa Hancock-féle Empress-archetípusból indul, de saját Tsukimori-személyiséggel és saját dialógusokkal.

## Mozgásnyelv — PRODUCTION LOCK

Alapelv:
> Himiko nem siet, mert nincs oka sietni.

- hosszú, kontrollált lépések;
- kevés felesleges mozgás;
- stabil, függőleges tartás;
- hosszú szemkontaktus;
- finom fejbillentés és félmosoly;
- tudatosan kitartott csend;
- személyes térbe fél lépéssel túl közel kerülhet;
- haj/köpeny secondary motion finom és fizikai;
- nincs komikus vagy túlzó fanservice animáció.

---

# Oto

## Identitás — LOCKED 2026-10-12

- felnőtt, idősebb nő;
- ritualista / régi rend / living seals;
- Shion gyerekkori szentélytörténetéhez kötődik;
- önálló slow-burn romance-opció lehet;
- Akirával tudatos idősebb nő / fiatalabb férfi dinamika épülhet.

## Nappal / éjszaka kettősség — LOCKED

**Nappal Oto idős, éjszaka fiatalosabb.**

- a változás napszakhoz kötött, nem a szentélyhez;
- alkonyatkor átmenet lehetséges;
- éjszaka érett, késő 30-as / 40 körüli vizuális érzetű formát vesz fel;
- hajnal felé visszaöregszik;
- mindkét forma ugyanaz a személy, ugyanazzal a tudattal és emlékezetével;
- a jelenség Tsukimori időt/testet torzító természetfeletti hatásának egyik közvetlen jele.

## Vizuális felismerhetőség — LOCKED

Mindkét formában maradjon:
- ugyanaz a szemforma;
- ugyanaz az arccsont/orr-struktúra;
- ugyanaz a hajalap;
- ugyanaz a hajdísz/szentélyi motívum;
- ugyanaz a gesztusnyelv és tekintet.

Nappal: ezüstös/ősz haj, idős, tradicionális, méltóságteljes.  
Éjszaka: ugyanaz az arc visszafiatalodva, simább bőrrel, egyenesebb tartással, élőbb és nőiesebb jelenléttel.

Elsődleges képi referencia:
`/Tsukimori Visual References/characters/OTO_DAY_NIGHT_FINAL_CHARACTER_DESIGN_V1.png`

### Első éjszakai identitáskezelés — LOCKED

Az első éjszakai fiatalos találkozáskor Akira **nem tudja**, hogy a nő Oto.
- a nő a szentély előtt ül egy esti séta során;
- nincs Oto-névtábla;
- Oto nem mondja el, hogy ő a nappali idős szentélyőr;
- hamis név nem szükséges: a nevét kikerülheti;
- Akira külön ismerkedik vele;
- több későbbi apró egyezésből kezd gyanakodni;
- a valódi felismerés és Oto beismerése külön, későbbi story beat.

Részletes production spec: `docs/OTO_PRODUCTION_SPEC.md`.

---

# Katsuro

- Akira elődje;
- Miyako férje;
- nyilvánosan halottnak hitt;
- történeti lehetőség szerint fekete vízben fogva lehet;
- ház, dolgozószoba, láda, kazetta és Black Fan rejtélyének központja.

---

# Karakterasset szabály

PLACEHOLDER vagy PROXY nem válhat FINAL karakterkánonná.

FINAL karakterhez kell:
- jóváhagyott front/side/back;
- arcirány;
- színpaletta;
- ruha;
- sziluett;
- rig-kompatibilitás;
- animációs language review.


---

# Reina

## Identitás — LOCKED 2026-10-11

- felnőtt, 29 éves nő;
- kb. 177 cm;
- Tsukimoriban született, éveket élt városban, majd visszaköltözött;
- a helyi iskola modern tanárnője;
- platina/hamvasszőke haj sötét tövekkel, szemüveg, piercingek, tetoválások;
- magas, erős homokóra-sziluett;
- School/Teacher és Riding/Casual fő outfit;
- fekete modern motor;
- gyors észjárású, ironikus, közvetlen; az iskolában professzionális és türelmes;
- kulcsmondat: **„A testem nem közösségi projekt.”**

Reina nem generikus modern/sexy NPC. Funkciója a falu hétköznapi, fiatalabb és modernebb életének megmutatása, valamint a későbbi szabadidős rendszer egyik természetes kapcsolódási pontja.

Kötelező production spec: `docs/REINA_PRODUCTION_SPEC.md`.


---

# Sora

## Identitás — LOCKED 2026-10-12

- felnőtt, középkorú nő;
- Tsukimori fogadójának vezetője;
- a fogadó több generáción át öröklődött a családjában;
- figyeli, ki érkezik és ki tűnik el a faluból;
- óvatos, figyelő, felnőtt jelenlét;
- nem fáradt-karakter, inkább belenyugvó és sokat látott;
- természetes információs csomópont a falu társasági életében.

## Vizuális identitás — LOCKED

Primary existing visual authority:
`/Tsukimori Visual References/npc/VILLAGE_NPC_PACK_V1_WOMEN_ONLY.png` — **1. SORA — INNKEEPER** panel.

- hosszú, nagyon sötét fekete/kékes-lilás haj;
- lila/ibolyás részletnyelv;
- érett, meleg, magabiztos arc;
- magasnak és fizikailag erősnek ható, telt nőies sziluett;
- mély lila / indigó / bordó fogadói outfit;
- elegáns, kissé érzéki, de földelt fogadói jelenlét.

A generic inn-worker/courtesan pack csak supporting environment/outfit reference; nem írhatja felül Sora saját karakterdesignját.

Elsődleges FINAL képi referencia:
`/Tsukimori Visual References/characters/SORA_FINAL_CHARACTER_SHEET_V1.png`

Eredeti design-lineage:
`/Tsukimori Visual References/npc/VILLAGE_NPC_PACK_V1_WOMEN_ONLY.png` — **1. SORA — INNKEEPER**.

Részletek: `docs/SORA_PRODUCTION_SPEC.md`.


---

# Klinikasszisztens — név nyitott

## OWNER APPROVED direction — 2026-10-12

- felnőtt, helyi nő;
- Akira rendelőjének állandó asszisztense és recepciósa;
- tényleges egészségügyi gyakorlattal;
- közvetlenebb, hétköznapibb jelenlét;
- a klinika működésének emberi arca;
- nem azonos Reinával, és nem Reina redesignja.

Approved visual concept:
`/Tsukimori Visual References/characters/CLINIC_ASSISTANT_APPROVED_CONCEPT_V1.png`

A képi lapon szereplő „Reina” név nem kánon.

# Tsukimori faluvezetője — Renka anyja, név nyitott

## OWNER APPROVED direction — 2026-10-12

- felnőtt, tekintélyes nő;
- Tsukimori világi/közösségi vezetője;
- Renka anyja;
- hivatalos, adminisztratív pólus Oto spirituális tekintélye mellett;
- községi iratok és Katsuro hivatalos nyomainak természetes kapuőre;
- nem azonos Miyakóval, és nem Miyako redesignja.

Approved visual concept:
`/Tsukimori Visual References/characters/VILLAGE_LEADER_RENKA_FAMILY_APPROVED_CONCEPT_V1.png`

A képi lapon szereplő „Miyako” név nem kánon.

Részletek: `docs/NEW_SUPPORTING_CHARACTERS_APPROVED.md`.
