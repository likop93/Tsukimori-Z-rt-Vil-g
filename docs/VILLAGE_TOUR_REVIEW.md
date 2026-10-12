# Tsukimori — első falubejárás REVIEW

**Dátum:** 2026-10-12

## Helye

Első két konzultáció → Katsuro rendelői füzet → **Ismerd meg Tsukimorit** → esti Miyako → Hana-hang → második nap.

A meglévő Hana → Miyako → éjszakai látogató → Shion → pecsét → esti tea láncot ez nem írja át.

## Első orientációs pontok

- Iskola — Reina formális bemutatkozása.
- Vegyesbolt — Aoi.
- Fogadó — Sora.
- Ritsu hangszerkészítő műhelye.
- Piactér — Hana névtelen, ismerős glimpse.
- Patak / kishíd — Shion helyének előkészítése.
- Zenei mellékutca — Kuroe tease, teljes találkozás nélkül.
- Szentélyhez vezető út — Oto távoli jelenléte; a lezárt rész és a Mélység nem nyílik meg.

A játékos a sorrendet szabadon választja, majd a nyolc pont után hazatér Miyakóhoz.

## State

Discovery:
`village_tour_started`, `school_discovered`, `shop_discovered`, `inn_discovered`, `workshop_discovered`, `market_discovered`, `stream_discovered`, `music_house_discovered`, `shrine_approach_discovered`, `village_tour_complete`.

Karakter:
`met_reina`, `reina_first_meeting_seen`, `met_aoi`, `met_sora`, `met_ritsu`, `hana_market_glimpse_seen`, `shion_stream_place_discovered`, `kuroe_music_place_discovered`, `oto_shrine_glimpse_seen`.

## Vizuális korlát

Első passzban a village street és bridge szolgál REVIEW stand-inként. Külön iskola/bolt/fogadó/műhely/patak/szentély production hátterek még hiányoznak.

Reina a jóváhagyott REVIEW portrét használja. Aoi/Sora/Ritsu/Oto számára ez a commit nem talál ki új vizuális authorityt.

## Következő lépés

Külön helyszínart + valódi hub-kapcsolatok + későbbi free-time destination rendszer. Himiko külön érkezési eseménye csak később, kb. a 3–4. játéknapon.
