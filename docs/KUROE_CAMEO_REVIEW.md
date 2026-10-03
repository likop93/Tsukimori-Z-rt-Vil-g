# Kuroe első cameo — 2026-10-03 REVIEW

A jóváhagyott karakterreferencia alapján külön REVIEW járó- és pillantó atlasz készült. A hosszan lila haj, fekete kabát/ruha, hajdísz és ametiszt részletek megmaradnak. A generálás és technikai csomagolás az assets/opening/kuroe_cameo/generation.md fájlban dokumentálva.

A falusi kontrollátadás után, Akira y <= 245 pozíciójánál indul a négy másodperces áthaladás. Kuroe a házköz felőli háttérsávban (455,177) → (615,177) halad. 1.3–2.1 másodperc között a közelben lévő Akira felé néz; a járás nem áll meg. Nincs névtábla, párbeszéd vagy kontrollzár. Nem kerül az ambient szövegező NPC-listába. A befejezés vagy helyszínelhagyás eltünteti, kuroe_cameo_passed flaget állítja. Új játék törli.

Meglévő y-sort és előtér-rétegek, nearest szűrés, rögzített talppont, kontaktárnyék. A be- és kilépés rövid áttűnéses technikai megoldás; végleges házköz-maszk és kézzel finomított járás még hiányzik. Nem végleges production animáció.

Teszt: tests/opening/kuroe_cameo_regression.tscn: nincs korai indulás az intróban, trigger, mozgás közbeni pillantás, változatlan játékoskontroll, szövegdoboz hiánya, egyszeri lefutás és eltűnés.
