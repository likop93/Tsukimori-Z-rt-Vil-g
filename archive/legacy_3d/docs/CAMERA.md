# Rendezett kamera – Mountain Path Blockout 2.0

A kamera továbbra is lágyan követi Akirát. Az új képernyőirányú vezérlés a következő:

- W = a képen előre
- S = a képen hátra
- A = a képen balra
- D = a képen jobbra

Az irányt minden új billentyűálláskor a kamera pillanatnyi nézetéből rögzítjük. Ha a követőkamera közben fordul, a lenyomva tartott gomb nem kezdi körbevezetni Akirát. A falusi és erdei szakaszon a kamera Akira haladási irányába áll; a Miyako-találkozás külön rögzített beállítás.

A falusi főút mozgás előtti kameraszöge az út tengelyéhez igazodik. Így a falun és a hídon újonnan lenyomott W a főút mentén indítja Akirát; oldalra fordulva a kamera követi őt.

## Jelenlegi kompozíciók

| Szakasz | Yaw | Kamera offset | Dőlés | Prioritás |
|---|---:|---|---:|---:|
| Kezdő / zónán kívüli | 0° | (0, 7.2, 8.8) | −34° | — |
| Első kanyar | 18° | (0.4, 6.7, 9.2) | −30° | 10 |
| Kilátópont | −28° | (1.8, 7.0, 9.8) | −27° | 20 |
| Kapu megközelítése | −10° | (0, 4.9, 8.3) | −19° | 30 |

A magasabb prioritású zóna nyer átfedés esetén.

A kamera célja most nem a végleges filmes kompozíció, hanem annak ellenőrzése, hogy az emberarányos Akira proxy mellett:

- olvasható marad-e a sziluett;
- természetes-e a követési távolság;
- nem túl erős-e a nézetváltás;
- a képernyőirányú WASD forgó kamerával is következetes marad-e.

A végleges értékeket csak Akira proxyval végzett kézi review után zárjuk le.
