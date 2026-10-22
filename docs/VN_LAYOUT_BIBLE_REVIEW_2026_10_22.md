# Első Miyako-találkozás — elrendezés és bibliaellenőrzés

2026-10-22 · IMPLEMENTED és tesztelt rendezési javítás, grafika továbbra is REVIEW.

A tulajdonos az `edce08b` próbájának elrendezését nem fogadta el. Pontosítása: a szövegdoboz mérete a probléma, és a karakterek beállítása következetesen igazodjon a képhez. A korábbi technikai PASS nem képi jóváhagyás.

## Ellenőrzött GitHub-forrás

Az `origin` a `likop93/Tsukimori-Z-rt-Vil-g` repó; a frissen lekért `main` az ellenőrzéskor `edce08b` volt. Nem volt ennél újabb távoli bibliafrissítés. Átnézve: `CREATIVE_BIBLE.md`, a `CHARACTER_BIBLE.md` Akira/Miyako és használati részei, `STORY_CANON.md`, `DECISION_LOG.md` kapcsolódó döntései, `ART_DIRECTION_LOCK.md`, `PIXEL_ART_PRODUCTION_DIRECTION.md`, `VISUAL_REFERENCE_INDEX.md`, `VISUAL_ASSET_USAGE_MATRIX.md`, valamint a kapott V4 vizuális szabvány. A helyi eredeti UI- és beauty-reference képet is megnyitottuk.

Konkrét következtetések:

- A LOCKED hibrid UI szerint a világ és a kis figurák megmaradnak, de dimmelve; ezt a korábbi próba nem teljesítette. Most külön háttérhalványítás kerül a portrék alá, a világ állapotának átírása nélkül.
- A beauty-reference Akirát bal oldali érkezőként, Miyakót jobbra, a bejáratnál rendezi. A próba indokolatlanul fordított beállítását korrigáltuk. A UI-reference alapvetően egy beszélő félalakot mutat; a későbbi tulajdonosi kérés miatt Akira portréja is megmarad, keret nélkül.
- A Creative Bible külön narratív kompozíciót és tiszta, olvasható UI-t ír elő. A doboz 116 helyett 78 logikai pixel magas; felül több hely jut a szereplőknek. A betűméret 14, a szövegterület 38 pixel magas, a továbblépés külön alsó sorban marad. A jelenet mindhárom tényleges mondata elfér.
- A Character Bible régi 3D-/CharacterBody3D-részei nem mai renderutasítások: a későbbi pixel-art lock felülírja őket. Az opcionális szemüveg régi variánsleírása nem írja felül a most kapott, szemüveg nélküli A0-forrást. Nem módosítottunk önállóan karakterkánont.
- A beauty/UI referencia kompozíciót ad, nem engedélyt a V4 A0/M0 arca vagy ruhája helyett új dizájnt használni. A két portréfájl változatlan maradt; nem készült új kép.

## Változás és hatókör

`scripts/ui/vn_dialogue.gd`: választható `cinematic_two_shot` elrendezés a meglévő presenterben. A portrék 264×396-os aránytartó félalakos beállítást kapnak; Akira balra, Miyako jobbra, befelé tájolva. Az eredeti kivágatok nem módosulnak. A szereplők helye, mérete és tükrözése a három oldal között állandó; csak a beszélő hangsúlya változik. A hallgató arca is olvasható marad. A háttér és a kis figurák 40%-os sötétítő rétegen át továbbra is látszanak.

`data/opening/miyako_first_dialogue.json`: csak a prezentáció és a képernyőoldal változott. `scripts/opening/arrival_director.gd`: a helyszínfejléc a VN alatt rejtett, utána a meglévő visszatérés visszaállítja. A menü elérhető marad.

Ez a javítás az első találkozásra van bekapcsolva. Más jelenetek saját kompozícióját nem cseréli globálisan ugyanarra: Hana bal oldala és a meglévő CG-k megmaradnak. A belső jelenet külön korábbi beállítása továbbra is létezik; az összes beszélgetés képi referencia szerinti egységesítése nem ennek a kis javításnak az elkészült eredménye.

A közös presenter újrafelhasználásakor az alapméret és a dimmelés is visszaáll, ezért a próba nem változtatja meg véletlenül a következő jelenetet. Szöveg, választások, affinitás, idő, nap és történeti flagkezelés változatlan.

## Tényleges ellenőrzés

Godot 4.7.2 stable, Compatibility, grafikus futás, 640×360 natív canvas, 1920×1080-ra indított ablak. **4 suite PASS:** VN, valós hazajutás mindkét belső válasszal, fejezetválasztó, teljes Hana-konzultáció ágai és CG-i. A végleges naplókban nincs ERROR/WARNING. A presenter újrafelhasználását ellenőrző tesztben a renderer befejezésének megvárása szükséges volt kilépés előtt; a végleges futás már nem jelent erőforrás-szivárgást.

Ellenőrzött: szöveg és vezérlősor külön marad, fej nem vágódik, karakterhely és méret állandó, szünet, léptetés, mozgástiltás, befejezési flagek, eredeti Miyako stage 0, vezérlés/fejléc visszaadása, más prezentációra visszaállás.

[Eredmények és naplók](vn_layout_review_2026_10_22/results.json) · [előtte](vn_layout_review_2026_10_22/before.png) · [utána](vn_layout_review_2026_10_22/after_0.png) · [hosszabb narráció](vn_layout_review_2026_10_22/after_2.png).

A portrék alfapereme és egységes production pixel-art kidolgozása továbbra is REVIEW. Az új elrendezés technikailag tesztelt, tulajdonosi képi jóváhagyása még nincs.
