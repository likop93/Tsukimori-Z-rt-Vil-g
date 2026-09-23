# Tsukimori — faluelrendezés (történeti blockout)

Akira a hegyi úton érkezik a falu egyik szélére, majd **végigsétál a lakott utcán**. A falusiak figyelik, párban összenéznek és összesúgnak. Katsuro és Miyako háza az utca **távolabbi, csendes peremén** áll, a patakkal szemben. Hana Miyako mellett lakik. A híd után két ház következik: a közelebbi Shioné, a távolabbi Akiráé. Akira háza után erdő, elágazó utak és három elszórt, egyelőre névtelen ház jön. Ez térbeli blockout; a házak belseje és a végleges építészeti forma még nincs kidolgozva.

| Hely | Jelenetbeli csomópont | Viszony |
|---|---|---|
| Miyako és Katsuro háza | `Houses/KatsuroMiyakoHome` | A bejárt falu túlsó pereme, patak közeli partja; patakra néző tornáccal és az utcáról látható bejárattal. |
| Shion háza | `Houses/ShionHome` | Szemközti part, Miyako házával szemben; bejárata a patak felé néz. |
| Hana háza | `Houses/HanaHome` | Miyako közvetlen szomszédsága, ugyanazon a parton. |
| Akira háza | `Houses/AkiraHome` | A túlpart második, távolabbi háza; a főútról külön rövid ösvény vezet hozzá. |
| A falu többi háza | `Houses/House*` | Egyelőre névtelen blockout; a többi főszereplő helye nincs eldöntve. |
| Falusi párok | `NPCSlots/Villager01`–`Villager08` | Az utcán négy helyen Akira felé fordulnak, majd egymáshoz hajolnak. |
| Erdő és elszórt házak | `ForestTrees`, `ForestHomes` | Akira háza után cédrusok, főút és három leágazás; a három ház lakói nincsenek kijelölve. |

A patak a helyi `z = -98` vonalon fut, a híd a főút tengelyén keresztezi. Akira belép az utcára `z ≈ 0` felől, a falusiak mellett halad el, és `z ≈ -89` körül találkozik Miyakóval. A túlparton Shion háza `z ≈ -107`, Akiráé `z ≈ -126`; az erdő `z ≈ -140` után kezdődik. Az utcai kamera a haladási irányt követi, a Miyakóval való találkozás külön, akadálymentes képet kap. A házak és a patak helyi koordinátái a `scripts/first_street.gd` fájlban vannak; a jelenet a hegyi pályán `z = -32` világpozíción áll. A végső falutérképhez a teljes történeti geográfiát együtt kell áttekinteni.
