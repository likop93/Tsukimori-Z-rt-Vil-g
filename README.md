# Tsukimori — Zárt Világ

## Opening + Village Street — 2026-09-27

F5 starts the pixel opening and a live arrival cinematic through Village Street, the bridge and Miyako's greeting (about 2.5 minutes total). Movement unlocks in the house forecourt after the greeting. ESC skips the full arrival safely. Side-view levels remain supported; the village camera is not a global rule. Current details: [Arrival cinematic REVIEW](docs/ARRIVAL_CINEMATIC_REVIEW.md).
WASD/arrows: move. Enter/Space: advance narration. Esc: confirm intro skip.
E: observe a nearby resident. F1: show/hide controls.

**TECHNICAL REVIEW / PLACEHOLDER ART.** Four ambient women, camera, three-quarter
stone-lane boundaries, rain, foreground rail occlusion and state-safe handoff are implemented.
The four approved individual NPC sheets now play idle/look/walk poses.
Akira now uses a 16-frame REVIEW atlas with directional walking and distance-based gait.
The playable street now follows the owner's attached overhead three-quarter image;
the plate is still a REVIEW asset and separate production parallax layers are missing.
Current visual target and exact provenance: [Village Street owner target v4](docs/VILLAGE_STREET_OWNER_TARGET_V4_REVIEW.md).
Previous visual review: [Staging v3](docs/STAGING_V3_REVIEW.md).
Closer *Until Then* proportion study: [Village Street proportions REVIEW](docs/UNTIL_THEN_PROPORTIONS_REVIEW.md).
NPC integration: [NPC v2 review](docs/NPC_V2_INTEGRATION.md).
Prior conversation decisions: [continuity notes](docs/CONTINUITY_NOTES.md).
Asset gaps, governance mapping and validation: [Opening milestone review](docs/OPENING_MILESTONE_REVIEW.md).
The older 3D milestone below is retained as historical/spatial reference.

### Megnyitás a letöltött ZIP-ből

1. Csomagold ki a ZIP-et egy saját mappába; ne a ZIP-en belül indítsd.
2. Godot 4.7.2-ben válaszd az **Import** lehetőséget és a kicsomagolt `project.godot` fájlt.
3. Várd meg az első automatikus asset-importot, majd **F5**: teljes nyitás és játszható utca.
4. Közvetlen utcai próba: nyisd meg a `scenes/dev/npc_animation_review.tscn` jelenetet, majd **F6**.

A csomag tartalmazza a képeket és forrásokat; külön bővítmény vagy letöltés nem szükséges.
A `.godot` gyorsítótárat az editor helyben hozza létre. Az új grafika REVIEW állapotú.

Godot 4.x alapú 2.5D narratív RPG vertical slice.

## Aktuális állapot — 2026-09-24

**Történeti forrás:** a tulajdonos Ren’Py-projektje. A történeti eseményeket, párbeszédeket és route-okat innen visszük át, de a már LOCKED Godot-világépítést nem írja felül automatikusan. A projekt teljes kánon- és kreatív hierarchiáját a négy governance-dokumentum rögzíti.

A részletes történeti jelenettérkép és a következő átültetési feladatok: `docs/RENPY_GODOT_STORY_MAP.md`.


### Kötelező projekt-governance

Minden új történeti, vizuális, karakter-, pálya- vagy FINAL asset döntés előtt:

- `docs/CREATIVE_BIBLE.md` — Tsukimori Visual Target v1 és vizuális quality bar
- `docs/STORY_CANON.md` — kánonhierarchia és Ren’Py/Godot szerepkör
- `docs/CHARACTER_BIBLE.md` — karakterkánon és animációs nyelv
- `docs/DECISION_LOG.md` — IDEA → PROPOSED → APPROVED → LOCKED döntések

**LOCKED döntést csak kifejezett tulajdonosi döntés módosíthat.**

Az első játszható hegyi szakasz technikai és animációs alapja **review-n átment**.

A kapun túli első falurész:
- **kibővített utcai blockout elkészült**
- **Ambient Animation Pass 1 review-n átment**
- **Miyako első találkozásának néma animációs stagingje elkészült — F5 review-ra kész**

Jelenlegi játszható ív:

**hegyi ösvény → első furcsa jel → kilátópont → kapu → falusiak között végigjárt utca → Shion háza → patakhíd → Miyako és Akira közös háza → erdei utak**

## Már működő alapok

- Godot 4.x projektstruktúra
- Akira humanoid proxy v0.2
- automatikus procedurális Akira fallback, ha a Blender GLB nincs a gépen
- Idle / WalkStart / Walk / WalkStop locomotion
- fallback humanoid walk / idle / coat motion
- sebességhez igazított walk playback
- lágyabb testfordulás és finom body lean
- 3/4-es rendezett követőkamera
- területenkénti kamera-kompozíciók
- képernyőirányú WASD; a lenyomva tartott irány stabil marad kamera-fordulás közben
- Mountain Path Blockout 2.0
- ambient cédrus- és ködmozgás
- papírcsík-furcsaság
- Tsukimori-kilátópont
- 月守村 — TSUKIMORI útjelző
- kapu előtti szirom/tér-anomália
- „Szél?” reakció
- Tsukimori kibővített falurésze tizenhárom faluoldali házzal, két túlparti házzal és négy mellékutcával
- a patak és járható híd a falu túlsó peremén; Shion a falusi oldalon, Miyako és Akira közös otthona a túlpart távolabbi háza
- a közös ház után cédruserdő, elágazó utak és három névtelen, elszórt ház
- lejtős tetők, favázas homlokzatok, papírablakok és külön bejárat a közös házon; réteges cédruskoronák és erdei aljnövényzet
- Miyako és Akira közös otthonának kétszintes, sötét alkonyati animált vizuális passza; veranda-lámpással, lassú fénylüktetéssel és szinte mozdulatlan szélcsengővel
- Miyako és Akira közös házának kisebb, híd felőli rendelőszárnya: külön oldalsó ajtóhoz rövid kövezett ösvény és lámpásos tábla vezet; E-vel belépés, váró és vizsgáló megfigyelése, majd kilépés
- új, Godotba betöltött közösház-GLB részletezett cseréptetővel, favázzal, shoji ablakokkal és verandával; szerkeszthető Blender-forrás ugyanabból a generátorból készíthető
- esti holdfény és mélyebb köd, nedves kőburkolat és tócsák, mozgó ereszalji eső és alacsony talajköd, lassan hajló erdei cédrusok
- festett, ismételhető anime-stílusú talaj-, kő-, vakolat-, fa- és tetőanyag az utcán és a rendelő külső részén; tagoltabb cédruskoronák, finomabb tető- és shoji-részletek
- három beágyazott textúrás, Godotba importált falusi házváltozat verandával, részletes tetővel és sötét shoji-ablakokkal; részletesebb hegyi ösvény, Forward+ fény- és árnyékpassz
- hat animált fényű utcai lámpa
- mozgó textil-, szirom- és növényproxyk
- nyolc animált humanoid falusi proxy
- a falun áthaladó Akirát figyelő és egymáshoz suttogó falusi párok
- négy egymásra épülő, egyszeri falusi reakció és csendes átmenet a hídnál
- Miyako külön humanoid proxyja Katsuro házának bejáratánál
- haladási irányt követő utcai kamera és elkülönített találkozási kompozíció
- az első találkozás külön kameraképe és Miyako visszafogott, forduló/meghajló üdvözlő mozgása; utána visszatér az irányítás
- a Ren’Py dialógusai és döntései a történeti jegyzékben vannak, később kerülnek át a Godot-jelenetekbe; a korábbi teljes képernyős VN-próbát kivettük
- minimális GameState flag-rendszer
- fejlesztői HUD + subtitle prototípus

## Review eredmény

**Mountain Path Animation Pass v0.2: PASSED**

A hegyi út stabil alap.

### Aktuális review

**Tsukimori — az első utca narratív bejárása és a közös ház vizuális prototípusa**

Az utcai párok reakciói F5 review-n átmentek. A közös ház animált, kétszintes atmoszférikus passza elkészült; most Miyako néma mozdulatát, a találkozás kameráját és az irányítás visszatérését ellenőrizzük F5-ben. Részletek: `docs/ASSET_EVALUATION_PLAN.md`, `docs/FIRST_STREET_NARRATIVE_PASS.md`, `docs/MIYAKO_FIRST_ENCOUNTER.md`, `docs/VILLAGE_LAYOUT.md` és `docs/SHARED_HOME_PROTOTYPE.md`.

A következő esti látványpassz Blender-modellje, Godot-betöltése és F5 ellenőrzőlistája: `docs/EVENING_VISUAL_PASS.md`.

A falusi környezet új, helyben generált anyagai és F5 vizuális ellenőrzése: `docs/ENVIRONMENT_ART_PASS.md`.

Persona 4 Golden léptékű grafikai cél, konkrét otthoni telepítési lista és bejárási sorrend: `docs/GRAPHICS_TARGET_AND_SETUP.md`.

## Godot asset stratégia

Külön shortlist készült:

`docs/GODOT_ASSET_SHORTLIST.md`

Amikor a jelenet igényli, első körben vizsgálandó:
- Kominka Modular Home Pack
- Tree3D
- ScatterShot
- Dialogue Manager 3

Az asseteket először külön tesztjelenetben próbáljuk ki. Nem cserélünk le működő rendszert csak azért, mert van kész plugin.

## Irányítás

- W / A / S / D — mozgás
- E — belépés a rendelőbe, megfigyelés a két térben, kilépés
- a WASD a képen látható irányok szerint mozgat; egy gombnyomás alatt a kamera fordulása nem görbíti el az útvonalat

## Asset szabály

Minden primitív vagy generált tesztasset státusza:

**PLACEHOLDER → BLOCKOUT → REVIEW → FINAL**

Semmi nem válik automatikusan FINAL assetté.
