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
| 2026-09-24 | **Tsukimori Visual Target v1** | LOCKED | Persona 4 Golden-szintű kész játékérzet, de saját dark-fantasy Tsukimori art direction. |
| 2026-09-24 | **Beauty target: Akira esti megérkezése Miyako házához** | LOCKED | A fő vizuális quality bar jelenet. |
| 2026-09-24 | **Ren'Py = történeti forrás, nem automatikus pálya-/kamera-terv** | LOCKED | A jóváhagyott Godot világépítést csak valódi történeti ütközés és tulajdonosi döntés módosíthatja. |
| 2026-09-24 | **Shion háza a patak falusi oldalán** | LOCKED | A jelenlegi Godot térkép része. |
| 2026-09-24 | **Patakhíd a falu túlsó peremén** | LOCKED | A jelenlegi Godot térkép része. |
| 2026-09-24 | **Miyako és Akira közös háza a túlpart távolabbi háza** | LOCKED | Katsuro egykori háza. |
| 2026-09-24 | **Rendelőszárny a közös ház része** | LOCKED | Híd felőli külön bejárattal. |
| 2026-09-24 | **Jelenlegi falusi és erdei útstruktúra** | LOCKED | Nem kell Ren'Py-hiányzó térleírás miatt átrendezni. |
| 2026-09-24 | **Akira FINAL design: fekete haj** | LOCKED | Nem szőke; nem keverhető Loft vizuális identitásával. |
| 2026-09-24 | **Akira FINAL Character Design v1** | LOCKED | Fekete haj, kb. 180 cm, korai harmincas, karcsú-atletikus testalkat, sötét rétegzett városi outfit, opcionális modern szemüveg; a jóváhagyott karakterlap az irány. Gyártási spec: `docs/AKIRA_PRODUCTION_SPEC.md`. |
| 2026-09-24 | **Akira FINAL locomotion = in-place** | LOCKED | CharacterBody3D mozgatja; root motion csak külön cinematic használatra. |
| 2026-09-24 | **Akira animációs alapelv: kontrollált reakció** | LOCKED | Minél furcsább az esemény, annál kevésbé látványos az első testi reakció. |
| 2026-09-24 | **Miyako FINAL Character Design A — Primary** | LOCKED | Alapjátékos FINAL: kb. 165 cm, korai harmincas, hosszú sötét haj, fekete/charcoal elegáns gyászruha, finom arany/bordó részletek. Gyártási spec: `docs/MIYAKO_PRODUCTION_SPEC.md`. |
| 2026-09-24 | **Miyako Design B — Ceremonial / Detail Exploration** | LOCKED VARIANT | Megtartott második vizuális referencia: hajdísz, bordó–arany motívumok, textilminták és ceremoniális outfit használható. A képen szereplő „házvezető / szentélyi gondozó” szöveg nem kánon. |
| 2026-09-24 | **Shion FINAL Character Design v1** | LOCKED | Hosszú fekete/ibolyás haj, zöld szem, finom virágdísz, víz/holdfény vizuális motívum, sötét rétegzett Primary outfit. A referencia-lap automatikus bio-szövegei nem kánonok. Spec: `docs/SHION_PRODUCTION_SPEC.md`. |
| 2026-09-24 | **Shion animációs alapelv** | LOCKED | Shion akkor a legnyugtalanítóbb, amikor túl kevéssé mozog; hosszú holdok, minimális testsúlyváltás, szemvezérelt reakció. |
| 2026-09-25 | **Hana FINAL Character Design v1** | LOCKED | Meleg tan bőr, nagyon hosszú hullámos sötét haj, vörösesbarna szem, arany hajdísz, telt/buja testalkat, nagyon telt mellkas, fekete–bordó–arany mély dekoltázsú japán ihletésű outfit. Spec: `docs/HANA_PRODUCTION_SPEC.md`. |
| 2026-09-25 | **Hana mozgásnyelv** | LOCKED | Földelt, közvetlen, magabiztos; több testsúlyváltás, de nincs komikus/túlzó secondary motion. |
| 2026-09-25 | **Himiko FINAL Character Design v1** | LOCKED | „Empress” vizuális irány: kb. 200 cm-es karakterérzet, hosszú vörös haj, kék/majdnem fehér heterokrómia, monumentális női sziluett, extrém nagy mellkas, fehér top, fekete ceruzaszoknya, magassarkú. Spec: `docs/HIMIKO_PRODUCTION_SPEC.md`. |
| 2026-09-25 | **Himiko mozgásnyelv** | LOCKED | Hosszú, kontrollált lépések, stabil tartás, kitartott szemkontaktus, sokatmondó félmosoly, pszichológiai dominancia; nincs komikus túlzás. |
| 2026-09-25 | **Himiko Empress body-proportion update** | LOCKED | A jóváhagyott új primary referencia az extrém nagy mellkas mellett szélesebb csípőt, nagyobb fart és vastagabb/erősebb combokat használ; monumentális, szoborszerű Empress-sziluett. |
| 2026-09-25 | **Himiko personality archetype** | LOCKED | Boa Hancock-vonalból inspirált regal pride / felsőbbrendűség / Empress-jelenlét / ritka gyengédség, de saját Tsukimori-karakterként, konkrét másolás nélkül. |
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
| 2026-09-24 | **2.5D cinematic narrative prototype** | APPROVED / REVIEW | Saját Tsukimori 2D/2.5D irány tesztelése a Miyako first encounterrel; hagyományos combat nélkül. A teljes 3D migration még nincs LOCKED. Visual target: `docs/VISUAL_REFERENCE_INDEX.md`. |
| 2026-09-24 | **Tsukimori Dialogue UI v1 képi referencia** | APPROVED / VISUAL AUTHORITY | A jóváhagyott UI board használható a prototípus dialógus-prezentációjához; konkrét fájl az indexben. |
| 2026-09-24 | **Renka Character Design v1** | APPROVED REFERENCE | Jelenlegi képi irány megtartva; még nem production lock. |

---

## Következő kreatív lockok

1. Akira FINAL Idle + Walk vizuális review.
2. Miyako FINAL Idle + Walk vizuális review.
3. Miyako–Akira ház beauty-target pass.
4. Shion FINAL Idle + Walk vizuális review.
5. Dialógus/UI vizuális nyelv.
