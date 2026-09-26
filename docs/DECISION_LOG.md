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

| Dátum | Döntés | Státusz | Következő lépés |
|---|---|---|---|
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
