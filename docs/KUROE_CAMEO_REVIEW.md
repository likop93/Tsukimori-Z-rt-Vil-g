# Kuroe első cameo — 2026-10-03 REVIEW

## Frissített mozgás és takarás

Az alábbi első változat áttűnése felülírva: Kuroe most (380,177) → (685,177) útvonalon halad 45 px/s sebességgel, a két végén már a házak takarásában. A karakter és árnyéka világkoordinátás, ferde épületszél-maszkot használ; nincs alfa-áttűnés. A pillantás az x=500–536 szakaszon történik, a járás fázisának megszakítása nélkül. A teljes technikai út 6.78 másodperc, ebből a két takart végszakasz nem látszik.

Az atlasz felsőtestének vízszintes igazítása a fej stabil középpontját követi, nem a támaszkodó láb váltakozó helyét. A talajszint változatlan. A forráscellák alsó bal szélén átlógó, idegen cipőpixelek eltávolítva. A járás továbbra is négyfázisú REVIEW, nem végleges kézi animáció.

A cameo-teszt és a külön belépő/kilépő grafikus rögzítések sikeresek: review/kuroe_occlusion_425.png és review/kuroe_occlusion_625.png.

A jóváhagyott karakterreferencia alapján külön REVIEW járó- és pillantó atlasz készült. A hosszan lila haj, fekete kabát/ruha, hajdísz és ametiszt részletek megmaradnak. A generálás és technikai csomagolás az assets/opening/kuroe_cameo/generation.md fájlban dokumentálva.

A falusi kontrollátadás után, Akira y <= 245 pozíciójánál indul a négy másodperces áthaladás. Kuroe a házköz felőli háttérsávban (455,177) → (615,177) halad. 1.3–2.1 másodperc között a közelben lévő Akira felé néz; a járás nem áll meg. Nincs névtábla, párbeszéd vagy kontrollzár. Nem kerül az ambient szövegező NPC-listába. A befejezés vagy helyszínelhagyás eltünteti, kuroe_cameo_passed flaget állítja. Új játék törli.

Meglévő y-sort és előtér-rétegek, nearest szűrés, rögzített talppont, kontaktárnyék. A be- és kilépés rövid áttűnéses technikai megoldás; végleges házköz-maszk és kézzel finomított járás még hiányzik. Nem végleges production animáció.

Teszt: tests/opening/kuroe_cameo_regression.tscn: nincs korai indulás az intróban, trigger, mozgás közbeni pillantás, változatlan játékoskontroll, szövegdoboz hiánya, egyszeri lefutás és eltűnés.
