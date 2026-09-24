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
| 2026-09-24 | **Asset státusz: PLACEHOLDER → BLOCKOUT → REVIEW → FINAL** | LOCKED | A technikailag működő asset nem lesz automatikusan FINAL. |

---

## APPROVED / még finomítható

| Dátum | Döntés | Státusz | Következő lépés |
|---|---|---|---|
| 2026-09-24 | **Akira + Miyako arrival staging v1** | APPROVED / REVIEW | Rendezett beauty-target terv elkészült: 7–10 mp-es encounter, warm/cool kontraszt, Akira kontrollált recognition beat, Miyako Primary Design A, első mondat: „Dr. Akira. Már vártam.” Részletek: `docs/BEAUTY_TARGET_AKIRA_MIYAKO_ARRIVAL.md`. |
| 2026-09-24 | Miyako kontrollált, finom animációs nyelve | LOCKED | Idle/Walk első review; részletek: `docs/MIYAKO_PRODUCTION_SPEC.md`. |
| 2026-09-24 | Közös ház hero location szerepe | APPROVED | Beauty pass és F5 review. |

---

## Következő kreatív lockok

1. Akira FINAL Idle + Walk vizuális review.
2. Miyako FINAL Idle + Walk vizuális review.
3. Miyako–Akira ház beauty-target pass.
4. Shion FINAL Idle + Walk vizuális review.
5. Dialógus/UI vizuális nyelv.
