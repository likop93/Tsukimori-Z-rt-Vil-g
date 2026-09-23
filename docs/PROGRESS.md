# Tsukimori — Development Progress

**Utolsó frissítés:** 2026-09-23

## Aktuális fázis

**Vertical Slice Implementation**

Az első hegyi játékszakasz review-zott.
Az első utca Blockout 1.0 elkészült, és most már **Ambient Animation Pass 1** réteget is kapott.

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
| First Street Ambient Animation Pass 1 | ✅ IMPLEMENTED — REVIEW |
| Animated villager humanoid proxies | ✅ IMPLEMENTED — REVIEW |
| Godot Asset shortlist | ✅ CURATED |
| Asset sandbox evaluation | ▶ NEXT |
| Miyako first encounter staging | ⏳ PLANNED |
| Clinic blockout | ⏳ PLANNED |
| Opening slice title beat | ⏳ PLANNED |

## Jelenlegi játszható szakasz

**Hegyi ösvény → első furcsa jel → kilátópont → útjelző → falukapu → „Szél?” → első utca → Miyako találkozási tere**

Működik:

- emberarányos Akira proxy;
- Blender GLB hiányában automatikus humanoid Akira fallback;
- locomotion blending / fallback locomotion;
- kamera-zónák;
- világirányú WASD;
- hegyi környezeti ambient mozgás;
- narratív trigger timing;
- kapu-anomália;
- hat házból álló első utcai blockout;
- két mellékutca és kerítések;
- négy animált fényű lámpa;
- mozgó textil-, szirom- és növényproxyk;
- hat animált humanoid falusi proxy;
- Miyako humanoid placement proxy;
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

**Tsukimori — Első utca Ambient Animation Pass 1**

A következő döntést a teljes hegyi út és az első utca egyben történő végigjátszása után hozzuk meg. Ezután külön sandboxban próbáljuk ki a legígéretesebb Godot asseteket, mielőtt bármelyiket beépítjük a fő jelenetbe.
