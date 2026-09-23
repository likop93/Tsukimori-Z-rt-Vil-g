# Tsukimori — faluelrendezés (történeti blockout)

Akira a hegyi úton érkezik a falu peremére. A patak közeli partján találkozik Miyakóval Katsuro házánál; a híd a faluba vezet. A túlparton Shion háza áll, Miyako mellett pedig Hana lakik. Ez térbeli blockout, a házak belseje és a végleges építészeti forma még nincs kidolgozva.

| Hely | Jelenetbeli csomópont | Viszony |
|---|---|---|
| Miyako és Katsuro háza | `Houses/KatsuroMiyakoHome` | Falu pereme, patak közeli partja; bejárata a patak felé néz. |
| Shion háza | `Houses/ShionHome` | Szemközti part, Miyako házával szemben; bejárata a patak felé néz. |
| Hana háza | `Houses/HanaHome` | Miyako közvetlen szomszédsága, ugyanazon a parton. |
| A falu többi háza | `Houses/House*` | Egyelőre névtelen blockout; a többi főszereplő helye nincs eldöntve. |

A patak a helyi `z = -21` vonalon fut, a híd a főút tengelyén keresztezi. A házak és a patak helyi koordinátái a `scripts/first_street.gd` fájlban vannak; a jelenet a hegyi pályán `z = -32` világpozíción áll. A pataknak ez az átvezetése a mostani játékszakaszt szolgálja; a végső falutérképhez a teljes történeti geográfiát együtt kell áttekinteni.
