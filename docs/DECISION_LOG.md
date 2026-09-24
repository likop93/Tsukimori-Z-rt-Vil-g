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
| 2026-09-24 | **Akira FINAL locomotion = in-place** | LOCKED | CharacterBody3D mozgatja; root motion csak külön cinematic használatra. |
| 2026-09-24 | **Akira animációs alapelv: kontrollált reakció** | LOCKED | Minél furcsább az esemény, annál kevésbé látványos az első testi reakció. |
| 2026-09-24 | **Asset státusz: PLACEHOLDER → BLOCKOUT → REVIEW → FINAL** | LOCKED | A technikailag működő asset nem lesz automatikusan FINAL. |

---

## APPROVED / még finomítható

| Dátum | Döntés | Státusz | Következő lépés |
|---|---|---|---|
| 2026-09-24 | Akira sötét, elegáns, praktikus öltözéke | APPROVED | FINAL front/side/back design. |
| 2026-09-24 | Akira szemüvege maradhat, ha nem tolja Loft irányába | APPROVED | Karakterlap review. |
| 2026-09-24 | Miyako kontrollált, finom animációs nyelve | APPROVED | Idle/Walk/meeting pack tervezése. |
| 2026-09-24 | Közös ház hero location szerepe | APPROVED | Beauty pass és F5 review. |

---

## Következő kreatív lockok

1. Akira FINAL front/side/back karakterdesign.
2. Akira FINAL Idle + Walk vizuális review.
3. Miyako FINAL karakterdesign.
4. Miyako–Akira ház beauty-target pass.
5. Dialógus/UI vizuális nyelv.
