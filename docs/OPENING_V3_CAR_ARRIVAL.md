# Nyitány v3 — autós érkezés (REVIEW)

**Döntés:** 2026-10-20 tulajdonosi döntés (`DECISION_LOG.md`): Akira autóval érkezik, a falu szélén parkol, onnan gyalog megy Miyako házáig. **Állapot:** implementálva, Godot-ban még nem futtatva (lásd Ellenőrzés).

## Beat-lista (`data/opening/sequence.json`, `short_gate_handoff_v3_car`, ~66 mp, 8 beat)
| # | id | mp | tartalom |
|---|---|---|---|
| 0 | black | 3 | fekete, motorzaj |
| 1 | car | 19 | `car_v3/car_drive_REVIEW.png`, monológ (6 sor) |
| 2 | memory | 12 | változatlan |
| 3 | recover | 3 | ugyanaz a kép, arc-kivágás (`crop`), „És én mégis eljöttem." |
| 4 | parking | 8 | `car_v3/car_park_REVIEW.png`, motor leáll, ajtó, léptek; az autó ott marad |
| 5 | forest | 12 | változatlan |
| 6 | gate | 8 | változatlan |
| 7 | handoff | 1 | változatlan |

A beat-indexek megegyeznek a régivel, így a tesztek indexei nem változtak.

## Szövegváltozás (javaslat, a tulajdonos javíthatja)
1. „Órák óta vezettem, és az út egyre mélyebbre vitt a hegyek közé." (volt: eső az ablakon)
2. „Egyszer sem fordultam vissza, pedig minden kanyarban lett volna rá lehetőségem." (volt: sofőr)
3. „Talán már indulás előtt tudtam, hogy ezt a döntést elrontottam." (volt: „Talán ő is tudta…")
4–6. változatlan (Katsuro hívott vissza…).

## Kód
- `opening_stage.gd`: busz-sprite/ajtó/utasok és esőcsepp-rajz eltávolítva; `car` (lassú push) és `parking` (push Akira felé) mód.
- `ambience.gd`: `depart` → `engine_off` cue; `black/car` alatt halk eső (a képek szárazak, naplemente), `parking` alatt az eső fokozatosan visszatér.
- `sequence_runner.gd`: általános normalizált `crop`, `set_shot` teljes `res://` útvonalat is elfogad, `weather` csak az `forest`-től.
- Teszt: `tests/opening/cinematic_input_regression.gd` képnevek/üzenetek átírva.

## Képek (`assets/opening/car_v3/`, tulajdonos által küldve, REVIEW)
`car_drive`, `car_park`, valamint `village_walk` (**még nincs bekötve**: a Miyako-házig vezető filmes séta képe). A képek simított anime-render, nem pixel-kvantált mint a v2 CG-k; FINAL előtt a `PIXEL_ART_PRODUCTION_DIRECTION` szerint ellenőrizendő. A buszos képek: `archive/legacy_opening_bus/`.

## Ellenőrzés (nálad futtatandó)
Godot nem volt elérhető, ezért semmi nem futott. Először importáld újra a projektet (az új PNG-khez nincs `.import`), majd:
`tests/opening/cinematic_input_regression.tscn`, `tests/opening/gate_flow_regression.tscn`, és nézd végig kézzel a nyitányt. Figyelni: a `recover` kivágás, a `parking` → `forest` éles vágás (CG → pixel sprite), a hang szintje, a sorok olvashatósága.

## Nyitott
- A naplemente (száraz) kép és az erdei/kapu éjszakai eső közötti hangulatváltás tetszik-e; kell-e átúsztatás.
- `village_walk` bekötése a séta-átvezetéshez (külön lépés, a WASD-kivezetéssel együtt).
- Régi tools (`tools/opening/*`) még a buszos tábláról generálnak; nem része a futó játéknak.
