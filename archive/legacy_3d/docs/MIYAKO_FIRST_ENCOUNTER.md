# Miyako első találkozása — térbeli animációs próba

> **Aktuális rendezési authority:** a véglegesebb beauty-target staginget a `docs/BEAUTY_TARGET_AKIRA_MIYAKO_ARRIVAL.md` rögzíti. Ez a dokumentum a korábbi működő próba technikai alapját írja le; a következő implementáció a beauty-target tervet rétegzi rá, nem bontja vissza a működő encountert.

Akira a hegyi ösvényről érkezve **először végigsétál a falun**. A falusi párok figyelik, összenéznek és összesúgnak, ahogy elhalad mellettük. Shion háza a patak falusi oldalán áll. Akira átmegy a hídon, elhalad egy névtelen ház mellett, majd Katsuro egykori házához érkezik: itt **Miyako és Akira együtt laknak**. Miyako az utcai bejárat előtt, takarás nélkül várja; a találkozás kamerája oldalról fogja be őket.

- A találkozás egyetlen alkalommal indul, amikor Akira a ház elé ér.
- Akira rövid időre megáll; a kamera Miyakóra vált, aki felé fordul, enyhén meghajol és nyitott kézmozdulattal fogadja. A mozdulat visszatér nyugalmi helyzetbe, majd a kamera és az irányítás visszaáll.
- Ez a jelenet csak a mozgás és a kamera ritmusát próbálja ki. A Ren’Py kánon szerinti első mondatát, házbelső beszélgetését és két döntését később illesztjük a véglegesebb Godot-jelenetformába; sem dialógust, sem kapcsolati pontot nem ad ez a próba.
- A `met_miyako` jelzőt az animáció végén állítjuk be, így az oldalsó rendelőajtó ezután érhető el. Az első éjszaka és a második reggel még nem játszható.

Review: F5-tel menj végig a falun, kelj át a hídon, haladj el az első túlparti ház mellett, és érkezz Miyako és Akira közös házához. Figyeld a láthatóságát, a fordulás és az üdvözlő mozdulat ritmusát, valamint hogy utána visszatér-e a mozgás és nyitható-e a rendelő. A mozdulat a jelenlegi humanoid proxyval készül; Akira FINAL modellje és animációi külön jóváhagyásra várnak.
