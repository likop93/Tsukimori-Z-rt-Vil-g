# CODEX BRIEF — Tsukimori vertical slice

## Feladat
A repository technikai alapjának stabilizálása Godot 4.x alatt.

## Kötelező governance / authority

Minden implementáció előtt ellenőrizd:

1. `docs/DECISION_LOG.md`
2. `docs/STORY_CANON.md`
3. `docs/CHARACTER_BIBLE.md`
4. `docs/CREATIVE_BIBLE.md`
5. `docs/ART_DIRECTION_LOCK.md`
6. `docs/VERTICAL_SLICE_SCOPE.md`
7. `docs/VISUAL_REFERENCE_INDEX.md`

A `LOCKED` döntést sem technikai egyszerűség, sem Ren'Py-forrás, sem korábbi blockout, sem generált asset nem írhatja felül automatikusan.

Ha a feladat ütközik egy LOCKED döntéssel:
- ne módosítsd a kánont;
- ne rendezd át automatikusan a pályát;
- dokumentáld az ütközést;
- csak kifejezett tulajdonosi döntés után változtass rajta.

A Ren'Py az események, dialógusok, döntések és route-ok történeti forrása, **nem automatikus pálya-, kamera- vagy art-direction terv**.

### Konkrét képi referenciák

A jóváhagyott képek kanonikus példányai a ChatGPT Library `/Tsukimori Visual References/` mappában találhatók; a pontos fájlnevek, státuszok és SHA-256 értékek:
- `docs/VISUAL_REFERENCE_INDEX.md`
- `docs/PLAYABLE_BACKGROUND_SCENE_MAPPING.md`

Ha a Work/Codex környezet a binary képet nem tudja közvetlenül elérni, **ne helyettesítse saját új designnal**. Használja a production specet fallbackként és jelezze a reference-sync hiányát.

A képeken lévő automatikusan generált feliratok nem történeti authorityk.


### Akira szakmai szerepe — LOCKED

Akira **orvos, nem kizárólag terapeuta**. A terápiás/pszichológiai kompetencia megmaradhat, de a rendelő és a történeti jelenetek tervezésénél valódi orvosi vizsgálat/ellátás is támogatandó. A pontos szakirányt ne találd ki automatikusan.

### Akira FINAL karaktermunka

Ha Akira FINAL modelljét, rigjét, animációját vagy materialját érinti a feladat, kötelező forrás:
- `docs/AKIRA_PRODUCTION_SPEC.md`

Proxy vagy korábbi generált Akira asset nem írhatja felül ezt a specifikációt.


### Beauty target — Akira érkezése Miyakóhoz

Ha a Miyako első találkozását, a közös ház előtti encountert, kamerát, világítást, animációt vagy dialógus-staginget érinti a feladat, kötelező rendezési forrás:
- `docs/BEAUTY_TARGET_AKIRA_MIYAKO_ARRIVAL.md`

A jelenlegi működő encountert ne bontsd vissza. A beauty-target rendezést rétegezd a meglévő trigger/kamera/ház struktúrára. Miyako ebben a jelenetben Design A — Primary FINAL megjelenést használjon.

### Miyako FINAL karaktermunka

Ha Miyako modelljét, rigjét, animációját, materialját vagy outfit variánsát érinti a feladat, kötelező forrás:
- `docs/MIYAKO_PRODUCTION_SPEC.md`

Design A az elsődleges FINAL alapmodell. Design B megtartott ceremonial/detail variáns; nem írhatja felül Design A-t, és a referencia-lapon szereplő „házvezető / szentélyi gondozó” szerepleírásokat nem szabad történeti kánonként átvenni.

### Shion FINAL karaktermunka

Ha Shion modelljét, rigjét, animációját, materialját vagy outfit variánsát érinti a feladat, kötelező forrás:
- `docs/SHION_PRODUCTION_SPEC.md`

A zöld szem, a hosszú fekete/ibolyás haj, a víz/holdfény vizuális nyelv és a visszafogott mozgás LOCKED. A referencia-lap automatikus életrajzi számai vagy hibás szövegei nem használhatók történeti kánonként.

### Hana FINAL karaktermunka

Ha Hana sprite-ját, portréját, animációját, 3D modelljét, materialját vagy outfit variánsát érinti a feladat, kötelező forrás:
- `docs/HANA_PRODUCTION_SPEC.md`
- `docs/VISUAL_REFERENCE_INDEX.md`

LOCKED jegyek:
- meleg tan bőr;
- nagyon hosszú hullámos sötét haj;
- vörösesbarna szem;
- arany virágos hajdísz;
- telt/buja felnőtt női testalkat;
- nagyon telt mellkas;
- fekete–bordó–arany, mély dekoltázsú japán ihletésű primary outfit.

Hana nem generikus „sexy NPC”. A testalkat, a ruha, a mozgás és a karakterjelenlét egyetlen koherens designrendszer.

### Himiko FINAL karaktermunka

Ha Himiko sprite-ját, portréját, animációját, 3D modelljét, materialját vagy outfit variánsát érinti a feladat, kötelező forrás:
- `docs/HIMIKO_PRODUCTION_SPEC.md`
- `docs/VISUAL_REFERENCE_INDEX.md`

LOCKED jegyek:
- kb. 200 cm-es vizuális karakterérzet;
- hosszú vörös haj;
- kék / majdnem fehér heterokrómia;
- monumentális Empress-sziluett;
- extrém nagy mellkas;
- fehér elegáns top;
- fekete magas derekú ceruzaszoknya;
- magassarkú;
- kontrollált, pszichológiailag domináns mozgásnyelv.

Himiko nem generikus „sexy doctor” NPC. A túlzó testarány a monumentális Empress-kisugárzás része, nem Hana vizuális másolata.

### FINAL visual production direction — LOCKED 2026-09-26

A teljes játék végleges vizuális production iránya:
**high-detail cinematic 2D/2.5D pixel-art narrative adventure**.

Kötelező forrás:
- `docs/PIXEL_ART_PRODUCTION_DIRECTION.md`
- `docs/VISUAL_REFERENCE_INDEX.md`

Primary visual target:
- `TSUKIMORI_PIXEL_ART_VISUAL_TARGET_V1.png`

Implementációs szabály:
- az új FINAL/production vizuális assetek pixel-art irányban készüljenek;
- a meglévő 3D világ ne törlődjön, de csak spatial/layout/blocking referencia;
- a LOCKED character reference-ekből pixel-art adaptáció készüljön, redesign nélkül;
- pixel texture filtering OFF / nearest-neighbor;
- pixel snapping és konzisztens pixel density;
- parallax foreground/midground/background;
- CG-k és narratív képek is ugyanabban a pixel-art nyelvben készüljenek;
- nyers AI render vagy egyszerű pixel-filter nem FINAL asset;
- első technikai canvas-teszt 640×360 → 1920×1080 3× integer upscale; ez working technical target, review alapján módosítható.


### Dialógus UI / portré rendszer — LOCKED

Primary képi referencia:
- `ui/TSUKIMORI_PIXEL_DIALOGUE_UI_V1.png`

Implementáció:
- rövid exploration/ambient dialógusnál a world sprite maradhat portré nélkül;
- fontos párbeszédnél nagy pixel-art portré/félalak jelenjen meg;
- a world scene maradjon látható és finoman dimmelődjön, ne váltson külön üres VN-háttérre;
- a portré a beszélő oldalához igazítható;
- a world sprite-ok maradjanak a scene-ben;
- expression/state rendszer támogasson több portréváltozatot;
- nagy route beat / climactic scene külön pixel-CG-t használhat;
- a portré nem redesign: kövesse a LOCKED character reference-et.

### First village 10–15 minute flow — APPROVED

Kötelező jelenetritmus-forrás:
- `docs/FIRST_VILLAGE_10_15_MIN_FLOW.md`

Első érkezési sequence:
- village gate / first street;
- ambient villagers;
- Hana cameo;
- Kuroe glimpse;
- Shion distant observation;
- bridge micro-event;
- Miyako full reveal at the house;
- interior transition.

**Canon rule:** Himiko ne jelenjen meg fizikailag ebben az első érkezési szakaszban, mert a jelenlegi történeti struktúra szerint később érkezik Tsukimoriba. Korai negyedik megfigyelőjelhez azonosítatlan observer / Loft-jel használható.

### Első playable pixel-art háttérkészlet — APPROVED

A Work az első bejárható slice-hoz a következő négy Library hátteret használja alapként:
- `backgrounds/VILLAGE_STREET_PIXEL_V1.png`
- `backgrounds/BRIDGE_PIXEL_V1.png`
- `backgrounds/MIYAKO_HOUSE_EXTERIOR_PIXEL_V1.png`
- `backgrounds/SHARED_HOME_CLINIC_INTERIOR_PIXEL_V1.png`

Ezek **APPROVED PLAYABLE BASE** státuszúak, nem FINAL shipping assetek.
Kötelező scene-role, walk-lane, interaction és parallax bontás:
- `docs/PLAYABLE_BACKGROUND_SCENE_MAPPING.md`

## Első technikai cél
A `scenes/world/mountain_path.tscn` hibamentesen induljon,
a Player WASD-vel mozogjon, a kamera kövesse, és a
VillageGateTrigger egyszer állítsa be:

`GameState.flags["entered_tsukimori"] = true`

## Korlát
NE implementálj még:
- combatot
- inventoryt
- route rendszert
- Black Kamuit
- dinamikus menüt
- komplex save/load rendszert

## Következő technikai review
1. scene parse / Godot startup hibák
2. player movement
3. collision
4. camera feel
5. trigger működés
6. project structure

## Refaktor-szabály
Ne írj történeti tartalmat közvetlenül player/world scriptbe.
A későbbi narratív rendszer adatvezérelt lesz.


### 2.5D story rework authority

A 2.5D történeti implementáció kötelező forrása:
- `docs/TSUKIMORI_2_5D_STORY_REWORK.md`
- `docs/TSUKIMORI_2_5D_NARRATIVE_PACING.md`

Fontos:
- az ott APPROVED/LOCKED elemek elsőbbséget élveznek a régi Ren'Py megoldással szemben a 2.5D verzióban;
- PROPOSED/nyitott elemet ne hardcode-olj végleges kánonként;
- az első nagy játékrész Akira végleges emlékezet-visszatéréséig tart;
- a teljes route-rendszert ne implementáld előre mereven;
- először adatvezérelt story-state és relationship-state alap készüljön;
- a Loft-megfigyelés korai háttérjel lehet;
- a Mélység ne kerüljön a korai vertical slice-ba;
- a többpartneres route csak későbbi, konszenzuális és karakter-kompatibilis állapotként kezelhető;
- jelenettervezésnél tartsd a pacing-elvet: minden fontos jelenet adjon választ, új kérdést vagy kapcsolati változást;
- a korai 30–45 perces vertical slice retention-célja: a játékos akarja tudni, miért hívta ide Katsuro Akirát, mit tud Miyako, és ki figyeli Akirát.

### 2.5D pixel-art production — jelenlegi státusz

A tulajdonos a teljes játék production migrációját **LOCKED** státuszban pixel-art 2D/2.5D irányra állította.

Visual target:
- `TSUKIMORI_PIXEL_ART_VISUAL_TARGET_V1.png`
- státusz: **LOCKED PRIMARY PRODUCTION VISUAL TARGET**

Szabály:
- a jelenlegi 3D projektet ne töröld;
- a 3D world layoutot csak térbeli referenciának használd;
- minden új production vizuális asset pixel-art / 2.5D legyen;
- hagyományos combatot továbbra se implementálj;
- a korábbi painterly/smooth-anime prototípus asset ne váljon automatikusan FINAL-lá.
