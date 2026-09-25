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

Ha a Work/Codex környezet a binary képet nem tudja közvetlenül elérni, **ne helyettesítse saját új designnal**. Használja a production specet fallbackként és jelezze a reference-sync hiányát.

A képeken lévő automatikusan generált feliratok nem történeti authorityk.


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

### 2.5D prototype — jelenlegi státusz

A tulajdonos jóváhagyta egy külön 2D/2.5D cinematic narrative prototype elkészítését.

Visual target:
- `TSUKIMORI_2_5D_VISUAL_TARGET_V1.png`
- státusz: **APPROVED / REVIEW**, nem FINAL migration lock.

Szabály:
- a jelenlegi 3D projektet ne töröld;
- a 3D world layoutot használd térbeli referenciának;
- a 2.5D prototípust elkülönített scene/script/asset struktúrában építsd;
- hagyományos combatot ne implementálj;
- teljes production migration csak új tulajdonosi döntés után történhet.
