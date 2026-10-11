# Reina — első játékbeli integráció REVIEW

**Dátum:** 2026-10-11

## Mit tettünk be

Reina bekerült a playable buildbe a jelenleg implementált korai történeti blokk végére. A meglévő Hana → Miyako → éjszakai látogató → Shion → pecsét → Miyako esti tea láncot nem írtuk át.

Az esti tea után megjelenik egy új explicit folytatás:
**„Következő szabad délután · Reina”**.

Ez időugrás egy későbbi szabad délutánra; nem állítja, hogy Reina ugyanazon az estén érkezik.

## Első jelenet

Helyszín: a meglévő klinika REVIEW háttere.  
Funkció:
- Reina saját maga mutatkozik be;
- a helyi iskola tanárnője;
- motoros sisakkal érkezik;
- meghívja Akirát az iskolába egy későbbi egészségügyi beszélgetésre;
- megfogalmazza a testi autonómia témáját;
- előkészíti az iskola és a későbbi szabadidős loop egyik ágát.

Az első jelenet nem teszi Reinát pácienssé és nem ad neki természetfeletti problémát.

## Állapot

Új flag-ek:
- `met_reina`
- `reina_first_meeting_seen`

A `met_reina` feloldja Reinát a karaktermenüben.

## Vizuális asset

- `assets/opening/vn_portraits/reina_teacher_v1_REVIEW.webp`

Ez REVIEW VN-portré a tulajdonos által jóváhagyott Tsukimori-stílusú Reina sheetből. Nem új character authority és nem írja felül az eredeti sheetet.

Fontos: a generált character sheeteken megjelenő automatikus számok/feliratok nem kánonok. Production kánon: 29 év, kb. 177 cm, modern tanárnő, Tsukimori-születésű, városi múlt, motoros oldal.

## Következő Reina batch

- iskola külső/belső pixel-art háttér;
- Reina tiszta transparent VN cutout + expression variánsok;
- motor melletti world sprite;
- első iskolai egészségügyi jelenet;
- későbbi szabadidős motor/kávé esemény;
- kapcsolatérték csak akkor, amikor a közös relationship-state rendszer elkészül.

A jelenlegi integráció szándékosan kicsi és izolált, hogy ne ütközzön a fő történet már implementált részeivel.
