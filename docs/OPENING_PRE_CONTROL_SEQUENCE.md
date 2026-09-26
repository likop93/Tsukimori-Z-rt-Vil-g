# Tsukimori — Opening Pre-Control Sequence v1

**Dátum:** 2026-09-26  
**Státusz:** APPROVED WORKING SCENE SCRIPT

## Cél

Ez a jelenet közvetlenül a tényleges játékosirányítás előtt fut.

Feladata:
- Akira belső hangjának bevezetése;
- Tsukimori első filmes/pixel-art benyomásának megadása;
- Katsuro nevének azonnali súlyozása;
- annak érzékeltetése, hogy a falu már Akira érkezése előtt tudott róla;
- természetes átadás az első playable Village Street scene-be.

**Fontos:** ez az új pixel-art verzióhoz készített jelenet. Nem az eredeti Ren'Py intro szó szerinti rekonstrukciója, hanem annak funkcionális és hangulati továbbírása.

Kapcsolódó authority:
- `docs/FIRST_VILLAGE_10_15_MIN_FLOW.md`
- `docs/PIXEL_ART_PRODUCTION_DIRECTION.md`
- `docs/CODEX_IMPLEMENTATION_BRIEF.md`

---

# 1. Scene flow

## OPEN_00 — Black / rain

**Control:** locked  
**Duration:** ~5–8 sec

- kép: teljes fekete;
- audio: folyamatos eső;
- audio: távoli jármű/busz mély, tompa zaja;
- music: még nincs vagy csak nagyon halk drone.

Transition:
- lassú fade-in a járműablak / esős érkezési pixel-CG felé.

---

## OPEN_01 — Akira internal monologue

**Presentation:** narration / internal thought UI  
**Speaker label:** none

Recommended text:

> Az eső már órák óta verte az ablakot.  
> A sofőr egyszer sem kérdezte meg, biztosan itt akarok-e leszállni.  
> Talán ő is tudta, hogy ezt a döntést már jóval az indulás előtt elrontottam.

Pause: short.

> Katsuro hívott vissza.  
> Túl sok év után.  
> Túl kevés magyarázattal.  
> És én mégis eljöttem.

Camera:
- lassú cinematic drift;
- semmi gyors pan / zoom.

---

## OPEN_02 — Tsukimori establish

**Visual target:** high-detail pixel-art arrival shot

Must show:
- esős hegyi falu;
- nedves út;
- hideg kék/fekete külső;
- meleg ablakfények;
- köd;
- sötét cédrusok / hegyoldal;
- falubejárat vagy ahhoz vezető út.

Narration:

> Tsukimori ugyanolyan csendesnek tűnt, mint régen.  
> Csak a csendje lett nehezebb.

Visual beat:
- egy ablak mögött halvány alak;
- másik helyen függöny vagy shoji mögötti rövid mozdulat;
- ne legyen jumpscare;
- ne legyen felismerhető named character.

---

## OPEN_03 — The village already knows

Camera:
- lassú közelítés a kapu / első utca felé.

Narration:

> Mintha a falu már tudná, hogy megérkeztem.

Audio:
- járműhang elhalkul;
- eső + víz + távoli szél marad;
- rövid emberi nesz / ajtó vagy shoji csúszás opcionális.

Important:
- az observer figurák csak ambient residents / azonosítatlan jelenlétek;
- Miyako teljes revealje itt tilos;
- Himiko fizikailag itt nem jelenhet meg.

---

## OPEN_04 — Akira at the gate

Visual:
- Akira world sprite vagy rövid cinematic full-body pixel pose;
- a falu irányába néz;
- minimális mozgás;
- kontrollált testbeszéd.

Narration:

> Most már mindegy.  
> Innen már végig kell mennem rajta.

Pause:
- 0.6–1.0 sec.

UI:
- narration box fade out.

Audio:
- ambience marad folytonos.

---

## OPEN_05 — Control handoff

Transition:
- az intro shotból közvetlen vagy nagyon rövid crossfade a playable Village Street scene-be;
- Akira ugyanazon logikai helyen álljon, hogy ne legyen térbeli ugrás.

At transition complete:
- player input enabled;
- HUD csak akkor jelenjen meg, ha tényleg szükséges;
- első ambient NPC-k már legyenek jelen;
- egyikük röviden Akira felé fordulhat.

Set story state:

`GameState.flags["opening_intro_seen"] = true`  
`GameState.flags["entered_tsukimori"] = true`

Then:
- start `FIRST_VILLAGE_10_15_MIN_FLOW`.

---

# 2. Data-driven scene example

A történeti tartalmat ne a Player vagy World scriptbe hardcode-oljuk.

Példa adatstruktúra:

```json
{
  "scene_id": "opening_pre_control_v1",
  "lock_player_input": true,
  "beats": [
    {
      "id": "open_00",
      "background": "black",
      "audio_start": ["rain_heavy", "vehicle_low"],
      "wait": 5.0
    },
    {
      "id": "open_01",
      "background": "opening_bus_rain",
      "transition": "fade",
      "lines": [
        "Az eső már órák óta verte az ablakot.",
        "A sofőr egyszer sem kérdezte meg, biztosan itt akarok-e leszállni.",
        "Talán ő is tudta, hogy ezt a döntést már jóval az indulás előtt elrontottam.",
        "Katsuro hívott vissza.",
        "Túl sok év után.",
        "Túl kevés magyarázattal.",
        "És én mégis eljöttem."
      ]
    },
    {
      "id": "open_02",
      "background": "tsukimori_arrival_night",
      "transition": "crossfade",
      "lines": [
        "Tsukimori ugyanolyan csendesnek tűnt, mint régen.",
        "Csak a csendje lett nehezebb."
      ],
      "ambient_events": [
        "window_silhouette_01",
        "shoji_motion_01"
      ]
    },
    {
      "id": "open_03",
      "camera_cue": "slow_push_to_gate",
      "lines": [
        "Mintha a falu már tudná, hogy megérkeztem."
      ]
    },
    {
      "id": "open_04",
      "show_actor": "akira_world",
      "actor_pose": "idle_down",
      "lines": [
        "Most már mindegy.",
        "Innen már végig kell mennem rajta."
      ]
    },
    {
      "id": "open_05",
      "transition_to_scene": "village_street",
      "unlock_player_input": true,
      "set_flags": {
        "opening_intro_seen": true,
        "entered_tsukimori": true
      }
    }
  ]
}
```

A konkrét kulcsnevek az aktuális story runnerhez igazíthatók; a lényeg az adatvezérelt felépítés.

---

# 3. Skip / replay szabály

Első játék:
- intro alapból végigfut;
- soronként gyorsítható;
- teljes skip csak megerősítéssel vagy már egyszer látott intro esetén javasolt.

Újrajátszás:
- ha `opening_intro_seen == true`, legyen Skip Intro lehetőség;
- skip esetén ugyanazokat a szükséges story flag-eket be kell állítani;
- skip ne törje meg az audio vagy scene state-et.

---

# 4. Vizuális asset lista

Minimum:
1. `OPENING_BUS_RAIN_PIXEL_V1`
2. `TSUKIMORI_ARRIVAL_NIGHT_PIXEL_V1`
3. optional foreground rain/window overlays
4. Akira world sprite
5. narration UI variant

A nyitó CG-k ugyanazt a high-detail pixel-art nyelvet használják, mint a playable jelenetek.

---

# 5. Acceptance criteria

A jelenet akkor kész review-ra, ha:
- 1.5–3 perc alatt lefut;
- nincs lore dump;
- Katsuro neve megmarad a játékosban;
- érezhető, hogy a falu figyel;
- nincs korai Miyako/Himiko reveal;
- a control handoff természetes;
- az első playable frame vizuálisan ugyanabból a világból folytatódik;
- az input lock/unlock hibamentes;
- skip esetén a szükséges GameState flag-ek helyesen állnak.

