# Első benti beszélgetés — 2026-10-03 REVIEW

A külső VN lezárása után E indítja a házba lépést Akira találkozási pozíciójánál. Rövid elsötétedés után megjelenik az eredeti Library SHARED_HOME_CLINIC_INTERIOR_PIXEL_V1 háttér. A külső eső effekt eltűnik, az esőhang halkul. A referencia változatlan másolata bekerült a projektbe.

A keret nélküli Miyako-portréval futó benti VN a canonical_html_story.rpy canonical_html_chapter_1 eredeti szövegét és két választását használja. A hosszabb narráció csak oldalhatárokra bontva változott. Akira sorainál a névtábla Akirát jelzi, Miyako portréja halványul; külön Akira VN-portré még hiányzik.

Csendben marad: aff_miyako +1, akira_gyogyulas +1. Visszakérdez: az eredeti kérdés/válasz és elfordulás-narráció, pontnövekedés nélkül. A választás egyszer alkalmazható, új játék törli. Ezek futás közbeni történeti értékek, nem új route- vagy mentési rendszer. Jelzők: entered_shared_home belépéskor, miyako_interior_dialogue_seen a választott ág utolsó oldalának lezárásakor.

Az ablak nem lép tovább magától; mozgás zárolva a belépés és párbeszéd alatt. Billentyűzetes és egérrel kezelhető választógombok. Lezárás után a nappali első, konzervatív 125–500 x / 263–269 y járósávja használható. A teljes floorplan, további szobák, interakciók és az első éjszaka következő feladat; ezt a kép nem helyettesíti. A rendelő és a személyes lezárt dolgozószoba nem lett összevonva.

Ellenőrzés: tests/ui/interior_regression.tscn mindkét válaszág, pontos egyszeri állapotmódosítás, új játék törlése, explicit E-belépés, eső elnémítása/halkítása, szövegek elférése, padlóhatár és kontroll-visszaadás. A külső VN tesztje is sikeres. REVIEW háttérhasználat, karakteratlaszok és Miyako-portré; új végleges assetjóváhagyás nincs.
