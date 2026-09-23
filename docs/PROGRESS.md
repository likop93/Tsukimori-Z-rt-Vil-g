# Tsukimori — Development Progress

**Utolsó frissítés:** 2026-09-23

## Aktuális fázis

**Vertical Slice Implementation**

Az első hegyi játékszakasz review-zott.
Az első utca kibővített blockoutja elkészült, az **Ambient Animation Pass 1** működik a hosszabb falurészben is.

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
| Fixed-world WASD | ✅ REVIEW PASSED |
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
| Clinic blockout | ⏳ PLANNED |
| Opening slice title beat | ⏳ PLANNED |

## Jelenlegi játszható szakasz

**Hegyi ösvény → első furcsa jel → kilátópont → útjelző → falukapu → „Szél?” → falusiak közt végigjárt utca → Miyako a patakparton → híd**

Működik:

- emberarányos Akira proxy;
- Blender GLB hiányában automatikus humanoid Akira fallback;
- locomotion blending / fallback locomotion;
- kamera-zónák;
- világirányú WASD;
- hegyi környezeti ambient mozgás;
- narratív trigger timing;
- kapu-anomália;
- tizennégy házból álló, továbbjárható falusi blockout;
- patak a bejárt falu túlsó peremén, ütközéssel rendelkező híddal;
- Miyako és Katsuro otthona a közeli parton, Shioné szemben a túlparton, Hana háza Miyako mellett;
- négy mellékutca és kerítések;
- hat animált fényű lámpa;
- mozgó textil-, szirom- és növényproxyk;
- nyolc animált humanoid falusi proxy;
- négy pár, akik Akirát figyelik, majd egymáshoz fordulnak és suttogó mozdulatot tesznek;
- Miyako humanoid proxyja Katsuro házának küszöbénél;
- irányított első találkozás, kánon szerinti első mondattal és folytatható vezérléssel;
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

**Tsukimori — Miyako első találkozásának stagingje**

A történet szerint Akira végigmegy a falun, ahol a lakók megnézik és összesúgnak, csak azután érkezik Katsuro és Miyako házához a csendes patakparti peremen. A következő végigjátszás ezt a sorrendet, Hana szomszédságát, Shion túlparti házát és Miyako találkozásának kameráját vizsgálja. A többi főszereplő otthona egyelőre nincs hozzárendelve a névtelen házakhoz. Részletek: `docs/VILLAGE_LAYOUT.md`. Külső assetet a jelenet konkrét igénye alapján próbálunk ki.
