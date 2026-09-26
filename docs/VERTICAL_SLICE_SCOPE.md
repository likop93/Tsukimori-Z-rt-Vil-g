# Vertical Slice v0.0.1 — Scope / Progress

## Production irányváltás — LOCKED 2026-09-26

A tulajdonos a teljes játék végleges megjelenését **high-detail cinematic pixel-art / 2.5D** irányban rögzítette.

Kötelező:
- `docs/PIXEL_ART_PRODUCTION_DIRECTION.md`
- `TSUKIMORI_PIXEL_ART_VISUAL_TARGET_V1.png`

A fent felsorolt 3D blockout/animation munka:
- továbbra is használható spatial/layout referenciának;
- nem törlendő;
- nem FINAL production render target.

A következő vertical-slice vizuális cél:
**village street → bridge → Miyako house → first encounter**, teljesen koherens pixel-art 2.5D pipeline-nal.

Review fókusz:
- pixel density consistency;
- karakterazonosság;
- parallax;
- contact shadow / occlusion;
- hideg külső + meleg belső fény;
- eső/köd/víz rétegek;
- dialógus/UI pixel-art integráció;
- ne legyen „karakter egy festmény előtt” érzés.

## Elkészült és review-n átment

1. Hegyi ösvény blockout
2. Akira humanoid proxy v0.2
3. Idle / WalkStart / Walk / WalkStop locomotion
4. 3/4 rendezett követőkamera
5. Kamera és mozgás vezérlésének első review-ja (a későbbi kameraorientált módosítást külön ellenőrizzük)
6. Tsukimori kapu blockout
7. Mountain Path Narrative Pass 1
8. Papírcsík-furcsaság
9. Tsukimori-kilátópont rendezett kamera-pillanata
10. Útjelző: 月守村 — Tsukimori
11. Kapu előtti finom térbeli anomália
12. Akira rövid kapureakciója + „Szél?”
13. Cédrus / köd / tábla / szirom ambient mozgás
14. Minimális GameState
15. Fejlesztői HUD + subtitle prototípus

**Mountain Path Animation Pass v0.2: REVIEW PASSED — 2026-09-22**

## Elkészült — review alatt

### Tsukimori — Első utca Blockout 1.0

Implementált tartalom:

- a kapun túli első, folyamatosan bejárható falurész;
- keskeny főutca hat ütközéssel ellátott háztömeggel;
- két rövid mellékutca és két kerítésszakasz;
- négy meleg fényű utcai lámpa;
- hat háttér-NPC elhelyezési pontja;
- Miyako első megjelenésének és találkozásának kijelölt tere;
- három, a falusi területhez igazított rendezett kamera-zóna;
- folytatódó ritmus: **szép → csendes → furcsa → személyesen nyugtalanító**.

## Még nincs implementálva

- harc
- inventory
- Black Kamui
- route rendszer
- dinamikus főmenü
- teljes köd-navigáció
- végleges NPC rutin
- végleges dialógusrendszer
- mentés/töltés
- végleges audio
- végleges grafika
- végleges Akira modell és final animation set
- Miyako végleges karaktere és találkozási jelenete

## Következő review kérdések

Az első utcánál ezt nézzük:

- természetes-e a kapuból a faluba való térbeli átmenet;
- megfelelő-e az utca mérete Akirához képest;
- olvasható-e a fő haladási irány;
- kellően lakottnak érződik-e hat háttérfigurával;
- a kamera megtartja-e a rendezett filmes jelleget;
- Miyako belépési pontja természetesnek, nem „spawnnak” érződik-e.
