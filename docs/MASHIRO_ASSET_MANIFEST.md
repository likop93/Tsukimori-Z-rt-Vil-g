# Mashiro — vizuális asset manifeszt / Godot handoff

**Állapot:** művészeti referenciák jóváhagyva a beszélgetésben; a repo-ba importálandó képállományok **FÜGGŐBEN**.

Alapdokumentum: [MASHIRO_LOCKED_BIBLE.md](MASHIRO_LOCKED_BIBLE.md).

## Referenciák — tervezett repo útvonalak

| Tervezett útvonal | Tartalom | Repo állapot |
|---|---|---|
| `assets/characters/mashiro/reference/MASHIRO_LOCKED_CHARACTER_SHEET_V1.png` | Tulajdonos által jóváhagyott nappali/éjszakai többpaneles karakterlap | nincs még feltöltve |
| `assets/characters/mashiro/reference/MASHIRO_GODOT_MULTIPANEL_REF_V1.png` | Bővített: front, side, back, expressions, details | nincs még feltöltve |
| `assets/cg/mashiro/CG_MASHIRO_FIRST_MEETING_01.png` | Első találkozás Miyakónál | nincs még feltöltve |
| `assets/cg/mashiro/CG_MASHIRO_GREENHOUSE_VISIT_01.png` | Első nappali üvegházi látogatás | nincs még feltöltve |
| `assets/cg/mashiro/CG_MASHIRO_NIGHT_FOX_01.png` | Első rókaalakos holdfényes esemény | nincs még feltöltve |
| `assets/cg/mashiro/CG_MASHIRO_AKIRA_MOMENT_01.png` | Közös Akira-pillanat, virágokkal | nincs még feltöltve |
| `assets/cg/mashiro/CG_MASHIRO_AKIRA_MOMENT_02.png` | Közös Akira-pillanat az üvegházban | nincs még feltöltve |

A megnevezések **tervezett assetnevek**. Mielőtt a bináris képeket feltöltjük, vizuálisan ellenőrizni kell, hogy a helyes forrásképet a helyes névhez rendeljük.

## Godot-import feladatok

1. Az eredeti jóváhagyott képek tényleges exportja és feltöltése a fenti útvonalakra.
2. Karakterarányok, kameranézetek és a panoráma-/CG-képek felbontásának ellenőrzése.
3. Nappali/éjszakai változatok rétegekre bontása, külön fülek/farok/haj/szemüveg/szem elemekkel.
4. Anchorok, pivotok, képkockák és animációs időzítések beállítása Godotban.
5. Valódi, futtatható animációk és jelenettriggerek tesztelése.

**Ne állítsuk késznek az animációt, a spritesheetet vagy az integrációt pusztán a képes referencialap alapján.**


## 2026-10-20 — Az eredeti referenciák megérkeztek
A tulajdonosi ZIP 29 médiafájlja a `reference/incoming/2026-10-20/mashiro/` alatt, SHA-256 leltárral rendelkezésre áll. A fenti tervezett production nevekre nem neveztük át automatikusan a több változatot. Pontos mapping-jelöltek és eltérések: [REFERENCE_INTAKE_2026_10_20.md](REFERENCE_INTAKE_2026_10_20.md).
A korábbi „nincs feltöltve” bejegyzések a tervezett production útvonalakra továbbra is igazak; a forrásképek elérhetőségi blokkolója megszűnt. A GIF nem Godot-animáció.
