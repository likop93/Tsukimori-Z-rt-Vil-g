# Miyako folyosói jelenet V1 — IMPLEMENTED / REVIEW

2026-10-14. Külön, opcionális technikai prototípus a tulajdonos átadott hárommondatos jelenetéhez. Nem új LOCKED történeti döntés és nem végleges production animáció.

## Elérés és beillesztés

Főmenü → Fejezetválasztás → II. Az első éjszaka → jóéjt-párbeszéd végigléptetése → **Kinézek a folyosóra · REVIEW**. Normál történeti végigjátszásban ugyanígy elérhető. Csak az első esti szobai választások közé került; a második/harmadik naphoz nincs automatikusan hozzárendelve. Kihagyható, a lefekvés változatlanul működik.

A 16 másodperces jelenet Akira szubjektív nézőpontja: nincs a folyosóra ráillesztett járó Akira-sprite. A kamera lassan előremozdul; Miyako távol, rögzített talpponton áll. 3–7 s fordulás, 7–11 s kitartott tekintet, 11–13 s finom közelítés/félmosoly és egyszeri enyhe lámpafény-ingadozás, 13–16 s pislogás és visszaállás. Nincs természetfeletti árnyalak, testi változás vagy időjárási effekt.

Utána az eredeti VN kezelő jeleníti meg az átadott három mondatot. E / Space / Enter / Tovább gomb léptet, nincs automatikus továbblépés. A párbeszéd alatt a folyosó élő Godot-képe megmarad. A mozgás tiltott, a Menü/ESC szüneteltet. Befejezéskor a szobai választások térnek vissza; a nappali továbbra is bejárható.

## Valós fájlok

- `scripts/opening/miyako_hallway_director.gd`: CanvasLayer + saját World2D/SubViewport, Camera2D, AnimationPlayer, PointLight2D, AudioStreamPlayer, öt különálló Sprite2D póz. Nem GIF/videó.
- `scripts/opening/first_night_director.gd`: opcionális belépés és visszatérés a meglévő szobai folyamatba.
- `data/home_day1/miyako_hallway_REVIEW.json`: pontos REVIEW párbeszéd, a meglévő `scripts/ui/vn_dialogue.gd` használatával. Nincs párhuzamos dialóguskezelő.
- `assets/home_day1/hallway/hallway_night_v1_REVIEW.png`: a jóváhagyott közös otthon alapján készített folyosóképréteg — REVIEW.
- `assets/home_day1/hallway/miyako_turn_v1_REVIEW.png`: normál Miyako öt teljes alakos póza — REVIEW / technikai PLACEHOLDER atlasz.
- `assets/home_day1/hallway/PROVENANCE_REVIEW.json`: források, eredeti generált fájlok, pontos promptok, atlaszrégiók.

A PNG-k eredetiek; az átlátszó margók vágása és a talppont-igazítás csak Godot AtlasTexture megjelenítés. Nearest szűrés, mipmap nélkül, meglévő 640×360-as képtér. A fordulás három póz közötti átúsztatás, nem csontvázanimáció. A félmosoly és a pislogás külön réteg. Az alapfigura opak marad az áttűnések alatt.

## Kánon és állapot

Források: `CHARACTER_PRESSURE_REVIEW.md`, `MIYAKO_TEA_WARDROBE_REVIEW.md`, `FIRST_NIGHT_IMPLEMENTATION_REVIEW.md`, `TSUKIMORI_120_DAY_STORY_AND_WORK_HANDOFF.md`; az új jelenetszöveg a tulajdonos Work-átadása.

Az egyetlen új állapot a `miyako_hallway_glimpse_seen`, amely csak a három mondat nyugtázása után lesz igaz. Indításkor és futás közben külön őrzés tiltja a duplázást; utána eltűnik a szobai menüpont. Új játék / fejezet-előkészítés a meglévő GameState törléssel visszaállítja. Félbehagyott jelenet nem számít végignézettnek.

Nem állítja be a `miyako_transformation_revealed` jelzőt. Barna haj/szem, normál arc, eredeti fekete gyászruha marad. Nem ad affinitást, Akira-statot, horrorértéket vagy személyes döntést. Nem módosít meglévő történeti flaget vagy időjárást; az 1–29. nap természetes időjárásának szabálya változatlan.

## Valódi ellenőrzés

Godot **4.7.2 stable**, Compatibility / NVIDIA OpenGL, látható grafikus tesztfutások, 2026-10-14:

- `tests/ui/miyako_hallway_regression.tscn` — **PASS**, üres hibalista. Valós idejű 16 s; fordulás, közelítés, pislogás; opak alapfigura; szünet alatt álló kamera/animáció/hang és VN; Space nem ugrik át a jeleneten; Akira nem mozog; olvasóra váró három mondat; visszatérő szobamenü és nappali mozgás; egyszeri flag; többi flag/stat/időjárás érintetlen; új játék törli. Log: `review/hallway_regression.log`.
- `tests/ui/night_day_regression.tscn` — **PASS**, mindkét választási ág. Az egyik ág kihagyja a folyosót, a másik végigjátssza, majd az eredeti első éjszaka → reggel → két konzultáció → nyolc falusi találkozás → esti folytatás láncot ellenőrzi. Log: `review/hallway_night_day_regression.log`.
- Godot editor import — **PASS**. A kezdeti SubViewport-beállítási hibát javítottuk; a végső fenti futásokban nincs parse/runtime hiba.
- Képi ellenőrzés: `review/hallway_01_REVIEW.png`, `hallway_03_REVIEW.png`, `hallway_07_REVIEW.png`, `hallway_12_REVIEW.png`, `hallway_blink_REVIEW.png`, `hallway_dialogue_REVIEW.png`. A szöveg és a Tovább gomb külön, olvasható területen marad.

## Production hiányok / következő döntés

Hiányzik a kézzel tisztított, sűrű köztes képkockás Miyako-fordulás és az egységesen regisztrált arcanimáció production atlasza. A mostani öt póz technikai próba; a távoli félmosoly szándékosan apró. A folyosó egyetlen festett réteg, nincs külön szerkesztett foreground/parallax/depth csomag. A nyikorgás a meglévő szintetikus `make_effect("wood")` hang, nem végleges hangfelvétel. Ezek asset-minőségi korlátok, a lejátszás nem blokkolt.

A jelenet végleges történeti elhelyezése és művészeti elfogadása REVIEW marad. Nem nyújtja előre Miyako átalakulását, és nem írja át az első éjszaka eredeti eseményeit.
