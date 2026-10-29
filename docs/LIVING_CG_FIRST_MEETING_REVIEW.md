# Akira–Miyako Living CG — technikai előkészítés

2026-10-29. Kiindulás: GitHub main `cea6a75`. **A kész, jóváhagyott képpel működő jelenet még NINCS elkészülve.** A vezérlő tesztelt, a konkrét CG hiányzik ebből a munkakörnyezetből. A normál játékban az új átvezetés kikapcsolt.

## Tulajdonosi irány és forrás

A fejlesztési chatbe bemásolt friss tulajdonosi átadás az első találkozásnál részletgazdag, sima anime-render / 16:9 Living CG-próbát engedélyez. Ez jelenetszintű kivétel, nem globális pixel-art migráció. Az október 22-i VN-elrendezés megmarad. Autós nyitány, exes emlék és új nap nem része ennek az egységnek. A PR #1 nincs egyesítve.

A `Folytatás írása` chat (`6acd09cd-9068-83eb-b5e1-9ab140be7541`) átadása megnevezi a `TSUKIMORI_LIVING_CG_AKIRA_MIYAKO_REVIEW_WORK_V1.zip` csomagot és az elsőként használandó `AKIRA_MIYAKO_LIVING_CG_01_USER_PREFERRED_REVIEW.png` képet. A chat szerint 1672×941-es, felirat nélküli kép, szemüveg nélküli Akirával és fekete garbós/szoknyás Miyakóval. A `02_LATEST_VARIANT_REVIEW.png` nem az elsőként kijelölt forrás.

Ezek a metaadatok a másik chat állításai: a bináris képet itt még nem nyitottuk meg, ezért hash, identitás-, helyszín- és kompozícióellenőrzés nem történt. A chat `sandbox:/mnt/data/...` linkje nem helyi Windows-fájl. A main, a V3/V4 csomag és a Letöltések ellenőrzése nem találta az új csomagot. A böngészős hozzáférési kísérlet app-approval timeouttal zárult; a kép nem lett letöltve. A régi beauty-reference és a tesztábra nem került helyettesítő történeti CG-ként a játékba.

## IMPLEMENTED — csak mechanika

- `scripts/opening/living_cg.gd`: 9 másodperc, legfeljebb 2,5% kameraközelítés, 0,35 másodperces beúszás és 0,8 másodperces áttűnés az eredeti VN-re. Nincs képtorzítás.
- `scripts/opening/living_cg_effects.gd`: külön mozgó szirmok és finom fényváltozás. A valódi lámpapozíciók a kép megtekintéséig nincsenek beállítva; a teszt mesterséges fényhorgonyt használ.
- CG alatt lineáris szűrés, ablakfelbontású `canvas_items` render. A teszt valódi viewport képe 1920×1080. Befejezéskor és jelenetmegsemmisítéskor az eredeti render mód visszaáll; a projekt alapbeállításai változatlanok.
- `scripts/opening/arrival_director.gd`: opcionális CG a meglévő VN elé. Áttűnés alatt nincs dialógusléptetés; utána a legelső mondat aktiválódik. Skip csak az átvezetést rövidíti, nem jelöli találkozottnak Miyakót.
- `data/opening/miyako_living_cg_REVIEW.json`: `enabled: false`, üres texture és pontos elvárt forrásnév. Hiányzó forrás esetén a korábbi működő találkozás indul. Nincs új GameState, kapcsolati hatás vagy történeti szöveg.

## REVIEW / MISSING

Hiányzik az eredeti kép átvétele, vizuális ellenőrzése, a hozzá igazított lámpahorgony, az atmoszféra finomhangolása és a tényleges CG–VN áttűnés szemrevételezése. A hétköznapi fekete ruha és a VN alapruhája közötti folytonosságot külön ellenőrizni kell; nem cseréltünk outfitet látatlanban.

Nincs külön háttér-, pislogó szem- vagy hajréteg, ezért nincs háttér-parallax, pislogás vagy hajanimáció. A szirmok eltérő sebessége nem háttér-parallax. A jóváhagyott képpel készült videó/GIF/képkockasorozat is MISSING. A [technikai kép](living_cg_mechanics_2026_10_29/living_cg_TECHNICAL_FIXTURE.png) feliratozott gradient-fixture, nem jelenet-előnézet vagy production placeholder.

## Tényleges tesztek

Godot 4.7.2 stable, Compatibility/OpenGL, grafikus futások külön ellenőrző példányban. [Eredmények](living_cg_mechanics_2026_10_29/results.json), mellettük a teljes naplók.

| Teszt | Eredmény |
|---|---|
| `tests/ui/living_cg_regression.tscn` | PASS, mechanika tesztábrával, `art_validated: false` |
| `tests/ui/vn_dialogue_regression.tscn` | PASS |
| `tests/ui/current_entry_audit.tscn` | PASS, két belső válasz |
| `tests/ui/chapter_select_regression.tscn` | PASS |
| `tests/opening/regression.tscn` | PASS, gate_flow, meglévő 66 másodperces nyitány |
| `tests/opening/cinematic_input_regression.tscn` | Assertions PASS; kilépéskor 4 ObjectDB instance leak warning |

Nincs parse/runtime ERROR. Az utolsó teszt nem figyelmeztetésmentes; a kilépési figyelmeztetést nem tekintjük megoldott hibának.

Az új teszt a természetes lejátszást és ismételt Skipet, szünet alatti időfagyást és tiltott Skipet, mozgástiltást, szűrést/felbontást, VN első mondatát és 78 pixeles elrendezését, befejezési flageket, változatlan affinitást/Miyako-állapotot, hiányzó forrás elutasítását és megszakítás utáni rendermód-visszaállítást ellenőrzi.

Következő szükséges lépés: pontos ZIP átvétele → forráshash és képi ellenőrzés → lámpahorgonyok → tényleges képpel természetes/Skip/Pause futás és képkockasorozat → csak ezután `enabled: true`. Ez a commit önmagában nem teljesíti a kész Living CG elfogadási feltételeit.
