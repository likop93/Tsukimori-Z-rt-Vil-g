# Tsukimori — faluelrendezés (történeti blockout)

Akira a hegyi úton érkezik a falu egyik szélére, majd **végigsétál a lakott utcán**. A falusiak figyelik, párban összenéznek és összesúgnak. Katsuro és Miyako háza az utca **távolabbi, csendes peremén** áll, a patakkal szemben. Shion a túlparton, Hana Miyako mellett lakik. Ez térbeli blockout, a házak belseje és a végleges építészeti forma még nincs kidolgozva.

| Hely | Jelenetbeli csomópont | Viszony |
|---|---|---|
| Miyako és Katsuro háza | `Houses/KatsuroMiyakoHome` | A bejárt falu túlsó pereme, patak közeli partja; bejárata a patak felé néz. |
| Shion háza | `Houses/ShionHome` | Szemközti part, Miyako házával szemben; bejárata a patak felé néz. |
| Hana háza | `Houses/HanaHome` | Miyako közvetlen szomszédsága, ugyanazon a parton. |
| A falu többi háza | `Houses/House*` | Egyelőre névtelen blockout; a többi főszereplő helye nincs eldöntve. |
| Falusi párok | `NPCSlots/Villager01`–`Villager08` | Az utcán négy helyen Akira felé fordulnak, majd egymáshoz hajolnak. |

A patak a helyi `z = -98` vonalon fut, a híd a főút tengelyén keresztezi. Akira belép az utcára `z ≈ 0` felől, a falusiak mellett halad el, és csak `z ≈ -89` körül találkozik Miyakóval. A házak és a patak helyi koordinátái a `scripts/first_street.gd` fájlban vannak; a jelenet a hegyi pályán `z = -32` világpozíción áll. A pataknak ez az átvezetése a mostani játékszakaszt szolgálja; a végső falutérképhez a teljes történeti geográfiát együtt kell áttekinteni.
