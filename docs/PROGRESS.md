# Tsukimori — Development Progress

**Utolsó frissítés:** 2026-09-24

**Történeti forrás rögzítve:** a feltöltött Ren’Py-projekt fő útja az irányadó. A részletes megfeleltetés és a még különálló Ren’Py-prototípusok leírása: `docs/RENPY_CANON.md`. A Godot route-rendszere ettől még nincs megvalósítva.

## Aktuális fázis

**Vertical Slice Implementation**

Az első hegyi játékszakasz review-zott.
Az első utca kibővített blockoutja elkészült, az **Ambient Animation Pass 1** működik a hosszabb falurészben is.
Az utcai narratív reakciók F5 bejárása sikeres volt; a következő körben a házak és az erdő saját, részletesebb blockoutjai készültek el.

## Mérföldkövek

| Mérföldkő | Állapot |
|---|---|
| Visual target | ✅ LOCKED |
| Camera / display mode | ✅ LOCKED |
| Technical 2.5D pipeline | ✅ LOCKED |
| Art Bible v0.1 | ✅ LOCKED |
| Akira model/proxy spec | ✅ DONE |
| Vertical slice plan | ✅ DONE |
| Godot project bootstrap | ✅ DONE |
| Directed camera system | ✅ REVIEW PASSED |
| Camera-relative WASD | ✅ IMPLEMENTED — REVIEW |
| Akira Proxy v0.2 | ✅ REVIEW PASSED |
| Portable procedural Akira fallback | ✅ IMPLEMENTED |
| Mountain Path Blockout 2.0 | ✅ REVIEW PASSED |
| Mountain Path Narrative Pass 1 | ✅ REVIEW PASSED |
| Mountain Path Animation Pass v0.2 | ✅ REVIEW PASSED |
| Tsukimori First Street Blockout 1.0 | ✅ IMPLEMENTED |
| Extended village street blockout | ✅ IMPLEMENTED — REVIEW |
| First Street Ambient Animation Pass 1 | ✅ REVIEW PASSED |
| Animated villager humanoid proxies | ✅ REVIEW PASSED |
| Godot Asset shortlist | ✅ CURATED |
| Asset sandbox evaluation | ⏳ WHEN NEEDED |
| Miyako first encounter staging | ✅ IMPLEMENTED — REVIEW |
| First Street Narrative Pass | ✅ REVIEW PASSED |
| House and forest visual pass | ✅ IMPLEMENTED — REVIEW |
| Miyako + Akira shared home visual prototype | ✅ ANIMATED PASS — F5 REVIEW |
| Clinic blockout | ✅ IMPLEMENTED — F5 REVIEW |
| Evening visual pass and shared-home GLB | ✅ GENERATED — F5 REVIEW |
| Opening slice title beat | ⏳ PLANNED |

## Jelenlegi játszható szakasz

**Hegyi ösvény → első furcsa jel → kilátópont → falukapu → „Szél?” → falusiak közt végigjárt utca → Shion háza → patakhíd → Miyako és Akira közös háza → erdei utak**

Működik:

- emberarányos Akira proxy;
- Blender GLB hiányában automatikus humanoid Akira fallback;
- locomotion blending / fallback locomotion;
- kamera-zónák;
- képernyőirányú WASD, lenyomva tartott gomb mellett stabil mozgással;
- hegyi környezeti ambient mozgás;
- narratív trigger timing;
- kapu-anomália;
- tizenhárom faluoldali és két túlparti házból álló, továbbjárható blockout;
- patak a bejárt falu túlsó peremén, ütközéssel rendelkező híddal;
- Shion otthona a falusi oldalon; a túlpart második háza Miyako és Akira közös otthona, Katsuro egykori háza;
- az erdőben három névtelen ház, elágazó utak és cédrus blockoutok;
- kétoldalt lejtő tetővel, favázzal, ablakokkal részletezett házak, háromrétegű cédruskoronák és aljnövényzet;
- négy mellékutca és kerítések;
- hat animált fényű lámpa;
- mozgó textil-, szirom- és növényproxyk;
- nyolc animált humanoid falusi proxy;
- négy pár, akik Akirát figyelik, majd egymáshoz fordulnak és suttogó mozdulatot tesznek;
- négy külön, egyszeri falusi reakció és a patakhídnál lezáruló narratív feliratsor;
- Miyako humanoid proxyja Katsuro házának küszöbénél;
- irányított első találkozás, kánon szerinti első mondattal és folytatható vezérléssel;
- a Ren’Py I. fejezetéből átvett első házbelső beszélgetés, két döntés és a döntésnek megfelelő Miyako / Gyógyulás érték; a VN-kép után visszatér a Godot-pálya;
- Miyako találkozása után E-vel elérhető rendelő a közös ház híd felőli oldalszárnyában, bejárható váróval és vizsgálóval;
- generált, Godotba betöltött közösház-GLB és ugyanahhoz a geometriához szerkeszthető Blender-forrásgenerátor; hideg esti fény, nedves utcakő, mozgatott eső és talajköd;
- GameState flag-ek.

## Asset irány

Külön shortlist készült:

`docs/GODOT_ASSET_SHORTLIST.md`

Elsőként vizsgálandó:
- Kominka Modular Home Pack;
- Tree3D;
- ScatterShot;
- Dialogue Manager 3.

A már működő directed camera rendszert nem cseréljük le automatikusan kész pluginra.

## Aktuális review

**Tsukimori — házak és erdő látványa**

Akira végigmegy a falun a figyelő, összesúgó lakók között, elhalad Shion háza mellett, átkel a patakon, majd az első túlparti ház után Miyakóval a közös otthonuknál találkozik. A kamera fordulását és a WASD képernyőirányú mozgását összehangoltuk: a mozgás gombnyomás alatt stabil marad. A ház mögött erdei úthálózat következik. Hana és a többi főszereplő otthonának helyét a történeti térkép alapján később rögzítjük. A közös ház sötét, kétszintes animált vizuális passza elkészült: veranda-lámpás, lassú fénylüktetés, szinte mozdulatlan szélcsengő, nedves anyagok és Katsuro ház alatti terének külső jele került be. Részletek: `docs/VILLAGE_LAYOUT.md` és `docs/SHARED_HOME_PROTOTYPE.md`.
Az új utcai reakciók sorrendjét és a híd melletti átmenetet a `docs/FIRST_STREET_NARRATIVE_PASS.md` írja le. A falusiak külön hangsávja későbbi hang pass feladata.
A házak új tetői és homlokzatai, valamint az erdei növényzet Godot F5 review-ra várnak. Különösen Miyako láthatóságát és a híd utáni gyalogos útvonalat kell ellenőrizni.
