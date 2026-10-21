# WASD kivezetése — automatikus séta (REVIEW)

**Döntés:** 2026-10-20 tulajdonosi döntés (`DECISION_LOG.md`, 4. pont): nincs szabad billentyűs mozgás; marad a kattintásos falutérkép, a filmes átvezetés és a VN. **Állapot:** implementálva, Godot-ban még nem futtatva.

## Működés
- `actor.gd`: nem olvas billentyűt. Két mozgásforrás van: a jelenetek által adott `scripted_axis` (filmes), és az automatikus séta (`walk_to(pont)` → `arrived` jelzés). Futás nincs (a `run_v1` atlasz a repóban marad, használaton kívül).
- `street.gd`: `AUTOWALK_GOALS` (utca, híd, ház előtere, házbelső). A séta a vezérlés visszaadásakor (`enable_control`) és helyszínváltáskor (híd, ház) indul. A cél a `constrain_position`-on megy át.
- A játékos továbbra is **E**-vel dönti el, mikor lép tovább (híd, ház, Miyako, belépés, az este folytatása); a szakasz-hintek ezt írják.
- Elakadás-védelem: ha Akira 1,4 mp-ig nem halad, a célpontra ugrik és a séta véget ér (nem ragadhat be a jelenet).
- A híd közbeni mikro-jelenetnél (x > 290) a séta szünetel, majd folytatódik.
- Az input map-ből kikerült: `walk_left/right/up/down`, `run`. Marad: `observe` (E).

## Érintett fájlok
`scripts/opening/{actor,street,village_flow,sequence_runner,first_night_director,motion_review}.gd`, `scripts/ui/{pause_menu,main_menu}.gd`, `data/opening/village.json` (`ui.controls`), README, TESTER_README, PROGRESS.

## Tesztek
- Új segéd: `tests/support/walk_sim.gd` — a „tartott irány” helyett az automatikus sétán keresztül hajtja Akirát; ezzel álltak át a mozgásos tesztek (`opening/{regression,arrival,grounding}`, `ui/{night_day,miyako_hallway,vn_dialogue,interior}`).
- Átírva: `opening/gate_flow_regression` (a séta a kapu utáni szakaszban automatikus; nincs WASD/run action), `ui/pause_run_regression` (futás-ellenőrzések helyett szünet/VN-zár/úthatár), `ui/village_walk_regression`.
- **Nem futtatva** (nincs Godot a munkamenetben). Nálad: importálás, majd a fenti tesztek, valamint a kuroe/quiet cameo tesztek (ezek most az automatikus séta közben is trigger-elhetnek). Az `opening/regression` régi, a 66 mp-nél hosszabb nyitányt feltételező ellenőrzései (pl. „1,5–3 perc”) már korábban sem stimmeltek.
- Régi hibás tesztek (`vn_dialogue`, `interior`) tartalmi javítása még hátra van.

## Akira szemüveg-ellenőrzés (képi)
Szemüvegmentes: `vn_portraits/akira_{neutral,doctor,doctor_green_eye}_v1`, `staging_v3` spriteok, `home_day1` Katsuro-fotó, szoba/alvás CG, az új autós CG-k. **Eltérés:** `assets/opening/reference/AKIRA_FINAL_CHARACTER_DESIGN_V1.png` karakterlapján az „Opcionális változatok” sorban van egy szemüveges változat; ez a 2026-10-20 döntéssel elavult. A képet nem módosítottam (referencia-lap); javaslat: új lapon kiszedni, vagy a lap mellé jelölést tenni.

## Nyitott
- A híd–ház út még nem kapott külön filmes képet (`car_v3/village_walk_REVIEW.png` kész, nincs bekötve).
- Az automatikus séta sebessége (70 px/s) és a célpontok a Godot-ban kézzel nézendők.
