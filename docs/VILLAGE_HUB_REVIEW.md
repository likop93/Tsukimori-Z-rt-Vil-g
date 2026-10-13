# Első szabad délután — összekötött falu
2026-10-13 · IMPLEMENTED / REVIEW

A főtér kilenc egymással összekötött kültéri pályarész központja.
WASD/nyilak: járás, Shift: futás, E: közeli átjáró vagy találkozás,
M: olvasható falutérkép, Esc/Tab: meglévő szünetmenü.
Fejezetválasztó: **III. Falubejárás · Reina és a többiek**.

## Térszerkezet
- Főtér ↔ iskola: Reina, első bemutatkozás.
- Főtér ↔ vegyesbolt: Aoi, első bemutatkozás.
- Főtér ↔ fogadó: Sora, első bemutatkozás.
- Főtér ↔ piactér: Hana név nélküli felvillanása.
- Főtér ↔ műhelyek utcája: Ritsu műhelye és Kuroe zenés ablaka.
- Főtér ↔ patakpart: Shion verandája a **falu felőli** parton.
- Patakpart ↔ szentélyút: az idős Oto név nélküli, korlátozott megpillantása.
- Patakpart ↔ híd → Miyako/Akira otthona, a nyolc találkozás után.
- Az iskola, bolt és fogadó a beszélgetés után belülről is megnézhető
  ugyanannál az E pontnál. A belsők VN kompozíciók; nincs aránytalanul
  kicsi irányítható figura a háttérre téve.

Minden átjáró E-re működik. Nyomva tartott gomb nem pattogtat két hely között.
A visszatérés őrzi az adott terület utolsó helyét és Akira nézési irányát.
A térkép nem teleportál; megmutatja az összeköttetéseket és a bejárt pontokat.
A helyszínadatokat a `data/home_day1/village_layout.json` tartalmazza.

## Karakterek és képi források
Az eredeti feltöltések változatlanul:
`reference/incoming/2026-10-12/`.
A három új névvel megismert karakter saját, keret nélküli VN-kivágatot és
karakterlapi képet kapott: Reina, Aoi, Sora. Ritsu megismerhető, de jelenleg
szöveges karakterlapja van; jóváhagyott képet nem helyettesítünk új dizájnnal.

| Runtime kép | Forrás | Státusz |
|---|---|---|
| reina_v1_REVIEW.png | 03_reina_teacher_rider_sheet.png, School outfit | REVIEW |
| aoi_v1_REVIEW.png | 06_aoi_shopkeeper_character_sheet.png | REVIEW |
| oto_v1_REVIEW.png | 05_oto_day_night_character_sheet.png, kizárólag idős nappali forma | REVIEW |
| sora_v1_PLACEHOLDER.png | VILLAGE_NPC_PACK_V1_WOMEN_ONLY.png / 1. SORA — INNKEEPER | PLACEHOLDER / REVIEW |
| Hana, Shion, Kuroe felvillanások | meglévő jóváhagyott cameo atlaszok | korábbi REVIEW |

A portrék egész alakos PNG-k. Beszélgetésben csak a megjelenítés kivágása
változik, hogy a fejek és a testek aránya illeszkedjen Akirához.
A fájlok nincsenek utólag átfestve vagy újratervezve. Új képek: built-in
image_gen; promptnapló: `assets/village_day1/PRODUCTION_PROMPTS.json`.
A névvel szereplő új világfigurák egyelőre stabil, kontaktárnyékos álló
kivágatok, **nem kész járó/söprő animációk**. Az ambient falusi nők a meglévő
idle/look/slow-walk atlaszokat használják. A tér és a piac négy ambient
nőt tartalmaz; a csendesebb utcák kevesebbet.

## Látvány és geometria
Nyolc külön kültéri háttér + a már ellenőrzött délutáni híd; három új belső.
A `places/*_v1_REVIEW.png` mind REVIEW, nem tulajdonosi FINAL.
A kültéri járható sávok a festett talajhoz vannak mérve. Lépcső, épület,
víz és előtéri szélek nem járhatók. Pixel nearest és snapping megmaradt.
A méret az oldalnézetű szakaszokon állandó, az átjáró nem örökli a
perspektivikus nyitóutca méretszabályát. Előtéri virágfoltok és a híd korlátja
a szereplők elé kerülnek, lábpozíció alapján rendezett szereplőkkel.
A külön szakaszokon rögzített kamera van; új parallaxréteg nincs kész.

## Történet és állapot
A nyolc eredeti találkozás és flag megmarad. Shion verandájának mondata
a LOCKED falu felőli parthoz igazítva. Oto lépcsőalji stagingje a nappali
helyszínhez igazítva. A belsők két-két rövid, REVIEW környezetleírása nem
nyit új románcot, döntést vagy lore-t. Nincs inventory, harc vagy save/load.
Az eredeti nyitás, első nap és Miyako esti folytatása változatlanul elérhető.
A 2026-10-13-i GitHub main Mashiro dokumentumai átvéve; a nap 5–10-re
tervezett bemutatkozást ez az első napi bejárás nem hozza előre.

## Pontosan hiányzó production assetek
1. Sora FINAL sheet: `characters/SORA_FINAL_CHARACTER_SHEET_V1.png`,
   SHA-256 `ba9cc9576ae76d4f4418984dd7de33087a7d6fd0f22a557cb6fad65dad5c7dfc`.
   Nincs a most kapott hat melléklet között. A korábbi, már jóváhagyott
   Sora-panel adaptációja ideiglenes, nem váltja le a FINAL authorityt.
2. Ritsu jóváhagyott karakterlapja és külön transparent VN/world figurája.
   A találkozás megvan, képi helyettesítő új karakter nem készült.
3. Reina/Aoi/Oto/Sora külön arckifejezések, valódi idle/walk/gesztus frame-ek;
   Sora söprésloop. A referencialap nem kész sprite-atlasz.
4. Renka, a faluvezető és Mashiro későbbi helyszínjelenetei külön történeti
   batch; a hibás feliratú lapok nem írják felül identitásukat.

## Ellenőrzés
`tests/ui/village_walk_regression.tscn`: tényleges mozgás/futás bemenet,
minden kültéri átjáró és visszaút, nyolc találkozás, állapotmegőrzés,
térkép és szünet, három belső, karakterlapok, híd-korlát textúra és esti handoff.
Kapcsolódó teljes elsőéj/elsőnap és fejezetválasztó regressziók is futtatandók.
Képernyőképek: `review/town_*_REVIEW.png`.

### Ellenőrzési eredmény — 2026-10-13
Godot 4.7.2: import és szkriptellenőrzés sikeres. VILLAGE_WALK,
VILLAGE_TOUR_MERGE, CHAPTER_SELECT és NIGHT_DAY: passed=true.
A tesztek valódi Godot ablakban futottak, képernyőképeik ellenőrizve.
Parse/runtime hiba nem maradt. Néhány tesztfolyamat lezárásakor a korábban
is előforduló 2–4 ObjectDB cleanup figyelmeztetés látható.
