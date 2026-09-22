# Rendezett kamera – Mountain Path Blockout 2.0

A kamera továbbra is lágyan követi Akirát, a karakter forgásától függetlenül. A játékos által már elfogadott irányítási elv változatlan:

- W = −Z
- S = +Z
- A = −X
- D = +X

A kameraváltás nem módosítja a WASD világirányait. Ez szándékos, mert a korábbi kameraorientált megoldás játék közben nehezen kezelhetőnek bizonyult.

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
- a fix világirányú WASD továbbra is jól használható-e.

A végleges értékeket csak Akira proxyval végzett kézi review után zárjuk le.
