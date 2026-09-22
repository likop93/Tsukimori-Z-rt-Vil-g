# Tsukimori — Development Progress

**Utolsó frissítés:** 2026-09-22

## Aktuális fázis

**Vertical Slice Implementation**

Az első hegyi játékszakasz review-zott, a kapun túli első utca pedig játszható és review-ra kész állapotban van.

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
| Mountain Path Blockout 2.0 | ✅ REVIEW PASSED |
| Mountain Path Narrative Pass 1 | ✅ REVIEW PASSED |
| Mountain Path Animation Pass v0.2 | ✅ REVIEW PASSED |
| Tsukimori First Street Blockout 1.0 | ✅ IMPLEMENTED — REVIEW |
| Miyako first encounter staging | ⏳ PLANNED |
| Clinic blockout | ⏳ PLANNED |
| Opening slice title beat | ⏳ PLANNED |

## Jelenlegi játszható szakasz

**Hegyi ösvény → első furcsa jel → kilátópont → útjelző → falukapu → „Szél?” → első utca → Miyako találkozási tere**

Működik:

- emberarányos Akira proxy;
- locomotion blending;
- kamera-zónák;
- világirányú WASD;
- környezeti ambient mozgás;
- narratív trigger timing;
- kapu-anomália;
- hat házból álló első utcai blockout;
- két mellékutca, kerítések és négy lámpa;
- hat falusi NPC-hely;
- Miyako találkozási helyőrzője;
- GameState flag-ek.

## Aktuális review

**Tsukimori — Első utca Blockout 1.0**

A következő döntést a teljes hegyi út és az első utca egyben történő végigjátszása után hozzuk meg. Végleges NPC-rutin, Miyako-jelenet és dialógus még nincs a buildben.
