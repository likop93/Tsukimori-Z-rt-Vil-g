# Tsukimori — Decision Log

**Dátum:** 2026-09-24  
**Cél:** megakadályozni a már elfogadott kreatív döntések véletlen felülírását.

## Státuszrendszer

**IDEA → PROPOSED → APPROVED → LOCKED**

- **IDEA:** szabad ötlet, bármikor eldobható.
- **PROPOSED:** konkrét javaslat review-ra.
- **APPROVED:** elfogadott irány, még finomítható.
- **LOCKED:** projektkánon. Csak kifejezett tulajdonosi döntéssel módosítható.

### Kötelező szabály

Sem GitHub-commit, Work-implementáció, Ren'Py-forrás, generált asset, Blender-fájl vagy Godot-prototípus nem módosíthat automatikusan LOCKED döntést.

Ha implementáció ütközik egy LOCKED döntéssel:
1. ne írd felül;
2. jelöld az ütközést;
3. kérj/kövess tulajdonosi döntést;
4. frissítsd ezt a logot.

---

## LOCKED döntések

| Dátum | Döntés | Státusz | Megjegyzés |
|---|---|---|---|
| 2026-09-24 | **Tsukimori Visual Target v1 (legacy 3D)** | SUPERSEDED FOR PRODUCTION RENDERING | A hangulati, világítási és térbeli célok részben öröklődnek, de a végleges renderformátumot a 2026-09-26-i pixel-art lock írja felül. |
| 2026-09-26 | **Full-game visual production = cinematic pixel art 2.5D** | LOCKED | A teljes játék high-detail cinematic pixel-art / 2.5D narrative adventure formában készül. Az A Space for the Unbound részletgazdag pixel-art prezentációja inspiráció, nem másolandó stílus. A korábbi 3D render production target SUPERSEDED; a 3D layout/blocking referencia marad. Primary target: `TSUKIMORI_PIXEL_ART_VISUAL_TARGET_V1.png`. Részletes spec: `docs/PIXEL_ART_PRODUCTION_DIRECTION.md`. |
| 2026-09-26 | **Hybrid pixel dialogue presentation** | LOCKED | Exploration közben world sprite; fontos párbeszédnél nagy, részletes pixel-art portré/félalak jelenik meg, miközben a jelenet és a kis sprite-ok dimmelve megmaradnak. Rövid ambient dialógus portré nélkül is mehet; kiemelt jelenet külön pixel-CG-re válthat. Primary reference: `TSUKIMORI_PIXEL_DIALOGUE_UI_V1.png`. |
| 2026-09-26 | **Opening pre-control staging v1** | LOCKED | A nyitás vizuális ritmusa: fekete+eső → busz/monológ → Tsukimori establish → figyelő ablakok → Akira a kapunál → kontroll átadás a Village Streetnek. Primary reference: `visual_target/OPENING_SEQUENCE_STORYBOARD_V1.png`. |
| 2026-09-28 | **Opening cinematic structure + traumatic memory motif** | LOCKED | A hosszú automatikus village→bridge→Miyako arrival nyitás SUPERSEDED. Új pre-control: busz → rövid szépnek induló, horrorba törő emléktöredék Akira bántalmazott múltjáról → leszállás → erdei gyaloglás → Tsukimori kapu → control handoff. Az emlékben szereplő felnőtt nő szándékos vizuális azonosítója a monumentális, extrém nagy mellkas/sziluett; név/arc az elején részben rejtett. A bántalmazás nem explicit képpel, hanem töredékes testi/pszichológiai jelekkel jelenik meg. A Village Street, Hana/Kuroe/Shion, híd és Miyako ezután játékosvezérelt flow. |
| 2026-09-26 | **Village population = women-only ambient cast** | LOCKED | Tsukimori falusi crowd/NPC lakossága nőkből áll; generikus férfi falusi NPC nem használható. A lakosság nagy része lehet kifejezetten vonzó/elegáns, kor- és szerepvariációkkal. A fogadóban külön felnőtt courtesan/sex-worker NPC-csoport működhet kihívóbb outfitekkel. Vizuális források: `npc/VILLAGE_NPC_PACK_V1_WOMEN_ONLY.png`, `npc/VILLAGE_NPC_ATTRACTIVE_VARIANTS_V2.png`, `npc/INN_COURTESAN_NPC_PACK_V1.png`. |
| 2026-09-24 | **Beauty target: Akira esti megérkezése Miyako házához** | LOCKED | A fő vizuális quality bar jelenet. |
| 2026-09-24 | **Ren'Py = történeti forrás, nem automatikus pálya-/kamera-terv** | LOCKED | A jóváhagyott Godot világépítést csak valódi történeti ütközés és tulajdonosi döntés módosíthatja. |
| 2026-09-24 | **Shion háza a patak falusi oldalán** | LOCKED | A jelenlegi Godot térkép része. |
| 2026-09-24 | **Patakhíd a falu túlsó peremén** | LOCKED | A jelenlegi Godot térkép része. |
| 2026-09-24 | **Miyako és Akira közös háza a túlpart távolabbi háza** | LOCKED | Katsuro egykori háza. |
| 2026-09-24 | **Rendelőszárny a közös ház része** | LOCKED | Híd felőli külön bejárattal. |
| 2026-09-24 | **Jelenlegi falusi és erdei útstruktúra** | LOCKED | Nem kell Ren'Py-hiányzó térleírás miatt átrendezni. |
| 2026-09-24 | **Akira FINAL design: fekete haj** | LOCKED | Nem szőke; nem keverhető Loft vizuális identitásával. |
| 2026-09-25 | **Akira szakmai identitás = orvos** | LOCKED | Akira nem kizárólag terapeuta. Terápiás/pszichológiai kompetenciája lehet, de a karakter és a rendelő alapja valódi orvosi szerep. A pontos szakirány még nincs külön lezárva. |
| 2026-09-24 | **Akira FINAL Character Design v1** | LOCKED | Fekete haj, kb. 180 cm, korai harmincas, karcsú-atletikus testalkat, sötét rétegzett városi outfit, opcionális modern szemüveg; a jóváhagyott karakterlap az irány. Gyártási spec: `docs/AKIRA_PRODUCTION_SPEC.md`. |
| 2026-09-24 | **Akira FINAL locomotion = in-place** | LOCKED | CharacterBody3D mozgatja; root motion csak külön cinematic használatra. |
| 2026-09-24 | **Akira animációs alapelv: kontrollált reakció** | LOCKED | Minél furcsább az esemény, annál kevésbé látványos az első testi reakció. |
| 2026-09-24 | **Miyako FINAL Character Design A — Primary** | LOCKED | Alapjátékos FINAL: kb. 165 cm, korai harmincas, hosszú sötét haj, fekete/charcoal elegáns gyászruha, finom arany/bordó részletek. Gyártási spec: `docs/MIYAKO_PRODUCTION_SPEC.md`. |
| 2026-09-24 | **Miyako Design B — Ceremonial / Detail Exploration** | LOCKED VARIANT | Megtartott második vizuális referencia: hajdísz, bordó–arany motívumok, textilminták és ceremoniális outfit használható. A képen szereplő „házvezető / szentélyi gondozó” szöveg nem kánon. |
| 2026-10-03 | **Kuroe FINAL Character Design v1** | LOCKED | Hosszú sötétlila/majdnem fekete haj, ametiszt szem, fekete-lila modern gótikus glamour outfit, csipke, hosszú kabát, lila kristályos részletek, elegáns homokóra-sziluett és **nagyon nagy, telt mellkas** mint felismerhető designjegy. Primary: `characters/KUROE_PRIMARY_CHARACTER_REFERENCE_V1.png`. Spec: `docs/KUROE_PRODUCTION_SPEC.md`. |
| 2026-09-24 | **Shion FINAL Character Design v1** | LOCKED | Hosszú fekete/ibolyás haj, zöld szem, finom virágdísz, víz/holdfény vizuális motívum, sötét rétegzett Primary outfit. A referencia-lap automatikus bio-szövegei nem kánonok. Spec: `docs/SHION_PRODUCTION_SPEC.md`. |
| 2026-09-24 | **Shion animációs alapelv** | LOCKED | Shion akkor a legnyugtalanítóbb, amikor túl kevéssé mozog; hosszú holdok, minimális testsúlyváltás, szemvezérelt reakció. |
| 2026-09-25 | **Hana FINAL Character Design v1** | LOCKED | Meleg tan bőr, nagyon hosszú hullámos sötét haj, vörösesbarna szem, arany hajdísz, telt/buja testalkat, nagyon telt mellkas, fekete–bordó–arany mély dekoltázsú japán ihletésű outfit. Spec: `docs/HANA_PRODUCTION_SPEC.md`. |
| 2026-09-25 | **Hana mozgásnyelv** | LOCKED | Földelt, közvetlen, magabiztos; több testsúlyváltás, de nincs komikus/túlzó secondary motion. |
| 2026-09-25 | **Hana route: life-seed → Akira child happy ending** | APPROVED | Hana nem materiálisan terhes: Tsukimori egy természetfeletti életmagot / felfüggesztett gyermek-energiát tart benne, amely a trauma nyomán jött létre, de nincs fizikai magzat. A tartós tejtermelés ennek egyik testi jele. A Hana-route végjátékában Akira energiája felülírja az életmag korábbi apai/eredeti lenyomatát, ezért a végül materiálissá váló gyermek **Akira és Hana gyermeke**. |
| 2026-09-25 | **Himiko FINAL Character Design v1** | LOCKED | „Empress” vizuális irány: kb. 200 cm-es karakterérzet, hosszú vörös haj, kék/majdnem fehér heterokrómia, monumentális női sziluett, extrém nagy mellkas, fehér top, fekete ceruzaszoknya, magassarkú. Spec: `docs/HIMIKO_PRODUCTION_SPEC.md`. |
| 2026-09-25 | **Himiko mozgásnyelv** | LOCKED | Hosszú, kontrollált lépések, stabil tartás, kitartott szemkontaktus, sokatmondó félmosoly, pszichológiai dominancia; nincs komikus túlzás. |
| 2026-09-25 | **Himiko Empress body-proportion update** | LOCKED | A jóváhagyott új primary referencia az extrém nagy mellkas mellett szélesebb csípőt, nagyobb fart és vastagabb/erősebb combokat használ; monumentális, szoborszerű Empress-sziluett. |
| 2026-09-25 | **Himiko personality archetype** | LOCKED | Boa Hancock-vonalból inspirált regal pride / felsőbbrendűség / Empress-jelenlét / ritka gyengédség, de saját Tsukimori-karakterként, konkrét másolás nélkül. |
| 2026-09-25 | **Himiko trauma distinction** | APPROVED | Himiko korábbi férje anális szexuális erőszakot követett el ellene; ehhez nem kapcsolódik terhesség vagy elzárt magzat. A trauma kontroll/bizalom szálként, nem erotizált módon jelenik meg. |
| 2026-09-24 | **Asset státusz: PLACEHOLDER → BLOCKOUT → REVIEW → FINAL** | LOCKED | A technikailag működő asset nem lesz automatikusan FINAL. |
| 2026-09-24 | **Visual Reference Packet / konkrét jóváhagyott képek** | LOCKED AUTHORITY RULE | A konkrét képek kanonikus másolatai a ChatGPT Library `/Tsukimori Visual References/` mappában vannak; státusz és SHA-256: `docs/VISUAL_REFERENCE_INDEX.md`. A képeken lévő automatikus szövegek nem kánonok. |
| 2026-09-25 | **2.5D story rework — memory structure** | APPROVED | Az első nagy játékrész Akira végleges emlékezet-visszatéréséig tart; utána a döntések alapján nyílnak szét a kapcsolati és történeti route-ok. Részletek: `docs/TSUKIMORI_2_5D_STORY_REWORK.md`. |
| 2026-09-25 | **2.5D story rework — character-driven first half** | APPROVED | Akira bántalmazott múltja és Katsuro visszahívása megmarad; a női karakterekkel való ismerkedés viszi a cselekményt, a Mélység később nyílik meg. |
| 2026-09-25 | **Loft 2.5D role** | APPROVED | Loft köre korán tud Akiráról és figyeli; nem késői „nagy harcba becsapódó” szereplőként jelenik meg. |
| 2026-09-25 | **Loft felesége = Akira volt felesége** | APPROVED STORY DIRECTION | A Lofttal való kapcsolat alibi/védelmi konstrukció; Akira és a nő régen valódi házasságban éltek. A szakítás pontos oka még nyitott. |
| 2026-09-25 | **Renka mint Akira későbbi exe** | PROPOSED | Lehetséges, hogy a házasság után Renka törte meg Akirát és gyorsította fel a romlását; még nem LOCKED. |
| 2026-09-25 | **Konszenzuális többpartneres route** | APPROVED | Harem/multi-partner opció marad, de külön bizalom, őszinteség és karakter-kompatibilitás kell; nem minden nővel és nem minden kombinációban lehetséges. |
| 2026-09-25 | **2.5D narrative pacing / retention structure** | APPROVED | Minden fontos jelenet adjon választ, új kérdést vagy kapcsolati változást; mikrobeat ~5–10 perc, értelmezést módosító középbeat ~20–30 perc, fejezetvégi horog kötelező. Részletek: `docs/TSUKIMORI_2_5D_NARRATIVE_PACING.md`. |

---

## APPROVED / még finomítható

2026-09-27 — **SUPERSEDED owner change:** the earlier live in-game cinematic through bridge, house and Miyako's greeting remains a technical review reference only. The 2026-09-28 opening decision restores player control at the Tsukimori gate.

| Dátum | Döntés | Státusz | Következő lépés |
|---|---|---|---|
| 2026-09-27 | **Village Street playable owner image target** | APPROVED / REVIEW | A tulajdonos által csatolt storyboard-kivágás háromnegyedes, mélységbe futó utcaképe az első bejárható jelenet konkrét kompozíciós célja. Az új `street_clean_source_REVIEW.png` emberek és UI nélküli átmeneti háttér; Akira és az egyenként jóváhagyott női NPC-k külön sprite-ok. Részletek és hiányzó FINAL rétegek: `docs/VILLAGE_STREET_OWNER_TARGET_V4_REVIEW.md`. |
| 2026-09-24 | **Akira + Miyako arrival staging v1** | APPROVED / REVIEW | Rendezett beauty-target terv elkészült: 7–10 mp-es encounter, warm/cool kontraszt, Akira kontrollált recognition beat, Miyako Primary Design A, első mondat: „Dr. Akira. Már vártam.” Részletek: `docs/BEAUTY_TARGET_AKIRA_MIYAKO_ARRIVAL.md`. |
| 2026-09-24 | Miyako kontrollált, finom animációs nyelve | LOCKED | Idle/Walk első review; részletek: `docs/MIYAKO_PRODUCTION_SPEC.md`. |
| 2026-09-24 | Közös ház hero location szerepe | APPROVED | Beauty pass és F5 review. |
| 2026-09-24 | **2.5D cinematic narrative prototype** | SUPERSEDED BY PRODUCTION LOCK | A prototípus sikeres irányváltást alapozott meg; 2026-09-26-tól a teljes játék pixel-art 2.5D production iránya LOCKED. |
| 2026-09-24 | **Tsukimori Dialogue UI v1 képi referencia** | LEGACY / SUPPORTING REFERENCE | A korábbi UI board funkcionális/kompozíciós referencia marad; a 2026-09-26-i pixel dialógus UI a production authority. |
| 2026-09-24 | **Renka Character Design v1** | APPROVED REFERENCE | Jelenlegi képi irány megtartva; még nem production lock. |

---

## Következő kreatív lockok

1. Akira FINAL Idle + Walk vizuális review.
2. Miyako FINAL Idle + Walk vizuális review.
3. Miyako–Akira ház beauty-target pass.
4. Shion FINAL Idle + Walk vizuális review.
5. Dialógus/UI vizuális nyelv.

## Technikai rendezés — 2026-10-01

Tulajdonosi kérésre a régi 3D prototípus az archive/legacy_3d alá került, az assetek és importbeállítások megőrzésével. A kreatív kánon és a pixel-art production irány változatlan. Az aktív játékból eltávolítottuk a használaton kívüli automatikus érkezési fázisokat; Miyako jelenlegi talaj-, ütközés- és feliratjavításai megmaradtak. Az aktuális működést a README és PROGRESS írja le; az eredeti állapotleírások az archívumban is megmaradtak.
# Technikai folytatás — 2026-10-04, REVIEW

2026-10-12 OWNER REQUEST / REVIEW: a többi nő kidolgozásának első köre Hana, Shion és Kuroe külön közeledési/ruházati/horrorívét tartalmazza. Három új teljes alakos hétköznapi kép és kilenc választásos galériajelenet-próba. Nem kerülnek automatikusan a fő történetbe. Hana gyors átalakulása szintén késői, külön felfedéshez kötve; a korai döntések legfeljebb bizonytalanságot okoznak. Részletek: [WOMEN_CHARACTER_DEVELOPMENT_REVIEW.md](WOMEN_CHARACTER_DEVELOPMENT_REVIEW.md).

2026-10-11 OWNER CORRECTION: Miyako teljes testi/mániákus változása hosszabb történeti folyamat vége legyen. Az első elutasítás csak rövid megtorpanás, változatlan kép; a két jelenlegi személyes határhúzás együtt legfeljebb finom figyelő állapotot ad. A teljes változat későbbi, külön megírt felfedéshez kötött; a jelenlegi történetben nem érhető el. A korábbi kétválasztásos gyors átalakulás SUPERSEDED. Hana ütemezése ebben a javításban változatlan.

2026-10-11 OWNER / REVIEW: karakterenként eltérő személyes közeledés és jelenethez kötött ruhatár. Első kiegészítés: Miyako esti teája a pecsét után, három személyes választás, a horrorállapottól külön kezelt megállapodás és három esti ruhás állapot. Nem kanonikus forrásszövegként jelölt új írás; alapdesign változatlan. [Részletek és pontos promptok](MIYAKO_TEA_WARDROBE_REVIEW.md).

2026-10-10 — Tulajdonosi döntés: a közeledés elutasítása ÉS a szakmai távolságtartás finoman, halmozódva erősítse a párhuzamos horrorszálat. Első implementáció: döntésfüggő környezeti narráció, fokozatos képszéli fényváltozás és halk neszek; meglévő kapcsolati hatások megőrzése. [Pontos súlyok és korlátok](REJECTION_HORROR_REVIEW.md).

Tulajdonosi kérés: Akira külön rendelői megjelenése, VN-szereplők helyes tájolása és Hana nagy történeti pillanataihoz külön jelenetképek. Jóváhagyott identitásokon alapuló REVIEW outfit/CG/staging; nem új karakter-design vagy történeti lock. [Részletek](MEDICAL_AKIRA_HANA_CG_REVIEW.md).

Tulajdonosi kérés alapján tesztelési fejezetválasztó a főmenüben; kizárólag működő jelenetekhez, egyszeri belépési kéréssel és dokumentált előzményállapottal. LOCKED kreatív döntéseket nem módosít. [Belépési pontok](CHAPTER_SELECT_REVIEW.md).

Tulajdonosi új vizuális kérés: Hana balra, Akira a beszélgetésekben, két eredeti névtelen páciens portréja, több Hana/Miyako képi reakció. Technikai staging és REVIEW cutoutok; LOCKED karakter-identitások, szöveg és döntések változatlanok. [Források és pontos promptok](DIALOGUE_PORTRAITS_REVIEW.md).

Tulajdonosi kérés alapján karakterlapok/kapcsolati státusz, majd első éjszaka és rendelési nap. LOCKED dizájn/történeti döntést nem módosít. A III. fejezet két eredeti névtelen konzultációja technikai folytatásként szerepel; a Hana-első sorrend és Hana pontos vizsgálati szövege még tisztázandó. REVIEW környezetek, hiányzó fénykép-CG és páciens production assetek: [részletek](CHARACTERS_NIGHT_CLINIC_REVIEW.md). Inventory továbbra is későbbi feladat.

2026-10-10 OWNER / REVIEW: egyéni elutasítási reakciók Miyako és Hana számára; menübeli képek és viselkedésleírások döntésfüggők. A képek megtartják a meglévő alakos kivágást, közeli arcképre nem váltanak. Részletek: CHARACTER_PRESSURE_REVIEW.md.

2026-10-10 OWNER / REVIEW: Miyako ismételt elutasításánál testi horrorváltozat engedélyezett: világosodó haj, kék szem, teltebb mellkas és mániákus mosoly. Alapmegjelenése változatlan; alakos kivágás és ruha megtartva. CHARACTER_PRESSURE_REVIEW.md.

2026-10-10 OWNER / REVIEW: Hana elutasítási fejlődése felülírja a korábbi követelőző irányt: teltebb test és egyre alárendelődő, jóváhagyást kereső viselkedés, az alap magabiztosság ellentéteként. Zártabb ruhás alternatív portré REVIEW; alapdesign változatlan. CHARACTER_PRESSURE_REVIEW.md.

2026-10-10 OWNER / REVIEW: hétköznapi ruhatár idővel minden nőnek, egyéni karakterjegyekkel. Első Hana-alternatíva: bordó top és farmer rövidnadrág, karakterlapi előnézet. Kimonó megmarad, történeti ruhaváltás későbbi jelenethez kötendő. EVERYDAY_WARDROBE_REVIEW.md.

2026-10-10 OWNER APPROVED / SUPERSEDES: Hana átalakulásakor karcsúbb és nőiesebb lesz; a hétköznapi V2 kép erre elfogadott referencia. A korábbi nagyobb/teltebb átalakulási testirány visszavonva. Alárendelődő viselkedés megmarad. Alapdesign változatlan. A korábbi kimonós változat arányait később ehhez kell igazítani.

2026-10-10 REVIEW: Shion első konzultációjának eredeti szövege és két döntése átültetve. Világos kimonó a forrás jelenetspecifikus ruhájaként; sötét primary design változatlan. Saját horrorátalakulás nincs még kijelölve. SHION_FIRST_SESSION_REVIEW.md.


## 2026-10-11 — Reina FINAL Character Design v1 — LOCKED

Tulajdonosi jóváhagyás: Reina karaktere és Tsukimori-stílusú vizuális iránya elfogadva, játékba integrálható.

LOCKED mag:
- 29 éves, kb. 177 cm magas felnőtt nő;
- Tsukimori-születésű, városi múlt után visszaköltözött;
- helyi tanárnő;
- platina/hamvasszőke haj sötét tövekkel;
- szemüveg, piercingek, tetoválások;
- magas, erős homokóra-sziluett;
- modern School/Teacher és Riding/Casual outfit;
- fekete motor;
- közvetlen, ironikus, intelligens, pedagógusként felelősségteljes.

A generált reference sheet automatikus feliratai/számai nem authorityk. Részletek: `docs/REINA_PRODUCTION_SPEC.md`.


## 2026-10-12 — Első szabad falubejárás — APPROVED

Az első rendelési nap után, az esti Miyako-zárás előtt Akira feladata: **Ismerd meg Tsukimorit**.

APPROVED:
- szabad sorrendben bejárható első orientáció;
- iskola / Reina;
- bolt / Aoi;
- fogadó / Sora;
- Ritsu műhelye;
- piactér;
- patak / kishíd;
- Kuroe zenei helyének tease-e;
- szentély megközelítése / Oto távoli jelenléte;
- a Mélység ekkor még zárt;
- Reina itt mutatkozik be először;
- Hana, Shion, Kuroe és Oto korai jelenléte nem írhatja felül későbbi formális történeti jeleneteiket.

Himiko nem része az első falubejárásnak. Külön érkezési eseményt kap a Hana/Shion korai periódus után, nagyjából a 3–4. játéknap környékén.


## 2026-10-12 — Sora existing design — LOCKED

Tulajdonosi korrekció: Sorának már korábban elkészült vizuális terve volt, ezért nem szabad újratervezni.

LOCKED source:
- `VILLAGE_NPC_PACK_V1_WOMEN_ONLY.png` / **1. SORA — INNKEEPER**.

LOCKED vizuális mag:
- hosszú nagyon sötét haj;
- ibolyás/lila részletnyelv;
- érett, meleg, magabiztos arc;
- magasnak/erősnek ható, telt nőies sziluett;
- lila/indigó/bordó fogadói outfit;
- felnőtt, figyelő, földelt fogadósi jelenlét.

A generic `INN_COURTESAN_NPC_PACK_V1.png` supporting referencia, nem Sora redesign.

A történeti hang és első találkozás a már megírt Sora-szabadnapi jelenetből marad authority.


## 2026-10-12 — Oto day/night dual form — LOCKED

Tulajdonosi döntés:

- Oto önálló romance-opció lehet;
- az Akira–Oto kapcsolatban tudatos idősebb nő / fiatalabb férfi dinamika jelenhet meg;
- **nappal Oto idős, éjszaka fiatalosabb**;
- a fiatalodás nem szentélyhelyszínhez kötött;
- alkonyatkor átmenet megengedett, hajnalnál visszaöregedés;
- az éjszakai forma érett, kb. késő 30-as / 40 körüli vizuális érzet, nem huszonéves/tinédzseres;
- a két forma ugyanaz a személy, azonos tudattal és emlékezettel;
- a nappali/éjszakai testállapot Tsukimori természetfeletti idő-/testtorzító hatásának vizuális jele;
- a két forma arcban, szemben, hajalapban, hajdíszben és gesztusnyelvben kötelezően felismerhetően azonos;
- Oto route-ja slow-burn, spirituális, intim, nem gyors/comedic romance.

Kötelező production spec: `docs/OTO_PRODUCTION_SPEC.md`.


## 2026-10-12 — Oto FINAL visual design v1 — LOCKED

Tulajdonosi jóváhagyás: a nappali/éjszakai kettős Oto character sheet elfogadva.

Primary visual authority:
- `/Tsukimori Visual References/characters/OTO_DAY_NIGHT_FINAL_CHARACTER_DESIGN_V1.png`
- SHA-256: `e84b3b542f2a5224ddae61630fdf7f87ba731a8699c6f67e6d1be0c083431761`

LOCKED képi mag:
- DAY: idős, ezüsthajú, tradicionális, méltóságteljes Oto;
- NIGHT: ugyanaz a nő fiatalosabb, érett, nőiesebb formában;
- közös arc/szem/haj/hajdísz/ruhamotívum;
- alkonyati átmenet vizuálisan fokozatos;
- a két forma nem külön személy;
- a képi design nem redesignolható külön tulajdonosi döntés nélkül.


## 2026-10-12 — Oto night identity concealment — LOCKED

Tulajdonosi döntés:

- Akira az első éjszakai fiatalos Oto-találkozáskor **nem tudja**, hogy ugyanaz a személy, mint a nappali idős Oto;
- az első éjszakai jelenet egy szabad esti séta közben, a szentély előtt történik;
- a fiatal nő a szentély előtt ül;
- a prezentáció kezdetben név nélküli / „Ismeretlen nő”;
- Oto nem mondja el, hogy ő Oto;
- hamis alteregó vagy hamis név nem szükséges;
- Akira és a fiatalos Oto önállóan ismerkednek;
- 2–3 későbbi találkozás során azonos gesztusok, szem, motívumok és tudás alapján Akira gyanakodni kezd;
- a tényleges felismerés külön későbbi story beat;
- a reveal előtt Oto kettős megjelenése nem lehet menüből/UI-ból elspoilerezve.


## 2026-10-12 — Sora FINAL production sheet v1 — LOCKED

Tulajdonosi jóváhagyás: a korábbi Sora-designból készített új production character sheet elfogadva és FINAL/LOCKED státuszú.

Primary visual authority:
- `/Tsukimori Visual References/characters/SORA_FINAL_CHARACTER_SHEET_V1.png`
- SHA-256: `ba9cc9576ae76d4f4418984dd7de33087a7d6fd0f22a557cb6fad65dad5c7dfc`

LOCKED képi mag:
- hosszú nagyon sötét fekete/kékes-lilás haj;
- ibolyás/lila szem- és részletnyelv;
- virágos hajdísz;
- érett, meleg, magabiztos arc;
- telt, erőteljes felnőtt női sziluett;
- mély lila/indigó/bordó fogadói ruha;
- nappali work/innkeeper és esti elegánsabb innkeeper megjelenés;
- expression set és fogadói környezet/staging irány a jóváhagyott sheet szerint.

Az eredeti `VILLAGE_NPC_PACK_V1_WOMEN_ONLY.png` / 1. SORA — INNKEEPER panel design-lineage marad; az új sheet production authorityként részletezi azt, nem redesignolja.


## 2026-10-12 — Clinic assistant + Renka mother village leader — OWNER APPROVED

Két véletlenül generált, de tulajdonos által kifejezetten jónak ítélt vizuális design új karakterhez kerül át; egyik sem írja felül az eredeti Miyako vagy Reina karaktert.

### Klinikasszisztens
- új, név nélküli felnőtt nő;
- Akira állandó rendelői asszisztense / recepciósa;
- tényleges egészségügyi gyakorlattal rendelkezzen;
- a klinika hétköznapi működésének és a falubeliekhez való kapcsolódásnak fontos szereplője;
- Katsuróhoz való pontos korábbi viszonya nyitott;
- APPROVED visual reference: `/Tsukimori Visual References/characters/CLINIC_ASSISTANT_APPROVED_CONCEPT_V1.png`.

### Faluvezető / Renka anyja
- új, név nélküli felnőtt nő;
- Tsukimori világi/közösségi vezetője;
- **Renka anyja**;
- Oto spirituális tekintélyétől különálló hivatalos vezetői pólus;
- Akira hivatalos státuszához, községi iratokhoz és Katsuro hivatalos nyomaihoz természetes kapcsolódási pont;
- APPROVED visual reference: `/Tsukimori Visual References/characters/VILLAGE_LEADER_RENKA_FAMILY_APPROVED_CONCEPT_V1.png`.

A képeken szereplő „Reina” és „Miyako” feliratok hibás/örökölt generált feliratok és **nem kánonok**.

Részletek: `docs/NEW_SUPPORTING_CHARACTERS_APPROVED.md`.


## 2026-10-12 — Reina + Renka design correction — LOCKED

Tulajdonosi korrekció:
- **Reina marad a korábban LOCKED platina/hamvasszőke, sötét tövű tanárnő-designnal.**
- **Renka marad a korábbi `RENKA_CHARACTER_DESIGN_V1_REFERENCE.png` APPROVED vizuális referenciáján.**
- A később véletlenül generált vörös–fekete–arany „Renka örökösnő” sheet **ELVETVE / NEM KÁNON**.
- Az elvetett kép sem Reinát, sem Renkát nem írhatja felül.
