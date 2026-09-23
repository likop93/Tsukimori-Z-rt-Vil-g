# Tsukimori — Zárt Világ

Godot 4.x alapú 2.5D narratív RPG vertical slice.

## Aktuális állapot — 2026-09-23

Az első játszható hegyi szakasz technikai és animációs alapja **review-n átment**.

A kapun túli első falurész:
- **kibővített utcai blockout elkészült**
- **Ambient Animation Pass 1 review-n átment**
- **Miyako első találkozásának stagingje elkészült — review-ra kész**

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
- hat animált fényű utcai lámpa
- mozgó textil-, szirom- és növényproxyk
- nyolc animált humanoid falusi proxy
- a falun áthaladó Akirát figyelő és egymáshoz suttogó falusi párok
- négy egymásra épülő, egyszeri falusi reakció és csendes átmenet a hídnál
- Miyako külön humanoid proxyja Katsuro házának bejáratánál
- haladási irányt követő utcai kamera és elkülönített találkozási kompozíció
- az első találkozás külön kameraképe és a kánon szerinti első mondata
- minimális GameState flag-rendszer
- fejlesztői HUD + subtitle prototípus

## Review eredmény

**Mountain Path Animation Pass v0.2: PASSED**

A hegyi út stabil alap.

### Aktuális review

**Tsukimori — az első utca narratív bejárása és a közös ház vizuális prototípusa**

Az utcai párok reakciói F5 review-n átmentek. A közös ház animált, kétszintes atmoszférikus passza elkészült, most F5-ben a ház sziluettjét, léptékét és Miyako láthatóságát ellenőrizzük. Részletek: `docs/ASSET_EVALUATION_PLAN.md`, `docs/FIRST_STREET_NARRATIVE_PASS.md`, `docs/MIYAKO_FIRST_ENCOUNTER.md`, `docs/VILLAGE_LAYOUT.md` és `docs/SHARED_HOME_PROTOTYPE.md`.

A következő esti látványpassz Blender-modellje, Godot-betöltése és F5 ellenőrzőlistája: `docs/EVENING_VISUAL_PASS.md`.

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
