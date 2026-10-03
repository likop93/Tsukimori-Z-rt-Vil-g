# Főmenü — technikai REVIEW, 2026-10-03

A felhasználó aktuális kérése alapján a projekt főmenüvel indul. Ez a korábbi menühalasztás feloldása erre a szűk feladatra; a LOCKED történeti és karakterdöntések nem változnak.

- Játék indítása: rövid sötét átúszás, futásállapot törlése, az eredeti nyitó cinematic indítása.
- Beállítások: főhangerő (0% némítás), teljes képernyő. A beállítások a user://settings.cfg fájlban maradnak meg.
- Irányítás: az aktuális játékgombok leírása.
- Kilépés: alkalmazás bezárása.
- Egér, nyilak, Enter; Esc az almenükből visszalép. A háttérgombok az almenük alatt letiltva, visszalépéskor a fókusz helyreáll.

Kép: a meglévő assets/opening/short_intro_v1/forest_gate_REVIEW.png, nearest szűréssel, sötétítéssel. Meglévő időjárás és halk esőhang. Nincs új karakterdizájn vagy új véglegesített grafika. A menü és a háttér REVIEW státuszú. Folytatás/játékállás-mentés és játék közbeni szünetmenü nincs ebben a változatban.

Ellenőrzés: tests/ui/main_menu_regression.tscn valódi billentyűeseményekkel vizsgálja a navigációt, beállításokat, némítást, mentést/újratöltést, a cinematic tényleges betöltését, a régi flag-ek törlését és az állapotbiztos intro-skipet. A review/menu_main.png, menu_settings.png és menu_controls.png grafikus futtatásból származó képek. A teszt végén visszaállítja a tesztprofil eredeti beállításait.
