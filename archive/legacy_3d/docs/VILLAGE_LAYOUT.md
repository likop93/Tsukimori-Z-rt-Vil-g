# Tsukimori — faluelrendezés (történeti blockout)

A történeti forrás a Ren’Py-projekt (`docs/RENPY_CANON.md`). A már elfogadott Godot-elrendezés megmarad: a Ren’Py I. fejezete Katsuro házát a falu csendesebb részén említi, a hidat nem rögzíti, ezért a híd utáni csendes perem ezzel összeegyeztethető. Kisebb eltérés miatt nem rendezzük át automatikusan a falut; lényegi történeti ellentmondást előbb egyeztetünk.

Akira a hegyi úton érkezik a falu egyik szélére, majd **végigsétál a lakott utcán**. A falusiak figyelik, párban összenéznek és összesúgnak. Shion háza a patak falusi oldalán áll. Akira átmegy a hídon; a túlparton két ház van. Az első egyelőre névtelen, a távolabbi Katsuro egykori háza, ahol **Miyako és Akira együtt laknak** és ahol az első találkozás történik. Ezután erdő, elágazó utak és három elszórt, egyelőre névtelen ház jön. Ez térbeli blockout; a házak belseje és a végleges építészeti forma még nincs kidolgozva.

| Hely | Jelenetbeli csomópont | Viszony |
|---|---|---|
| Shion háza | `Houses/ShionHome` | A patak falusi oldalán; bejárata a patak felé néz. |
| Túlparti első ház | `Houses/House04` | A híd utáni közelebbi, egyelőre névtelen ház. |
| Miyako és Akira közös háza | `Houses/MiyakoAkiraHome` | A híd utáni távolabbi, elszigeteltebb ház; Katsuro egykori otthona. |
| Rendelő | `Houses/MiyakoAkiraHome/Clinic` | A közös ház kisebb, híd felőli oldalszárnya; külön oldalbejárattal. |
| A falu többi háza | `Houses/House*` | Egyelőre névtelen blockout; Hana és a többi főszereplő helye később kerül történet szerint kijelölésre. |
| Falusi párok | `NPCSlots/Villager01`–`Villager08` | Az utcán négy helyen Akira felé fordulnak, majd egymáshoz hajolnak. |
| Erdő és elszórt házak | `ForestTrees`, `ForestHomes` | A közös ház után cédrusok, főút és három leágazás; a három ház lakói nincsenek kijelölve. |

A patak a helyi `z = -98` vonalon fut, a híd a főút tengelyén keresztezi. Akira `z ≈ 0` felől érkezik; Shion háza `z ≈ -89`, a közelebbi túlparti ház `z ≈ -107`, Miyako és Akira közös háza `z ≈ -122` helyen áll. Az erdő `z ≈ -140` után kezdődik. A WASD az aktuális kamera alapján mintavételezi a képernyő irányait minden új gombnyomáskor, a kamera pedig az utcán Akira haladási irányát követi; a találkozás külön, akadálymentes képet kap. A házak és a patak helyi koordinátái a `scripts/first_street.gd` fájlban vannak; a jelenet a hegyi pályán `z = -32` világpozíción áll.
