# Miyako és Akira közös háza — vizuális prototípus

**Dátum:** 2026-09-23  
**Állapot:** ANIMATED VISUAL PASS — F5 review szükséges

**Esti modellfrissítés:** a `assets/buildings/shared_home/tsukimori_shared_home.glb` már része a projektnek. A részletesebb tető, faváz, shoji és veranda modellt a `tools/blender/create_shared_home.py` forrás állítja elő; Blenderben futtatva szerkeszthető `.blend` is készül. A játék az importált modellt használja, az eredeti procedurális forma csak betöltési tartalék. A mozgó eső és talajköd Godotban fut. További bejárási szempontok: `docs/EVENING_VISUAL_PASS.md`.

## Vizuális irány

A ház a kiválasztott első atmoszférakép hangulatát követi: hideg kékes-lilás alkony, ködös cédruserdő, nedves kő és visszafogott meleg fény a papírablakokban. A geometria egy sötét, régi japán falusi házat idéz, két tetőszinttel, fa vázzal, fedett verandával és az utca felé néző bejárattal.

## Mi került be

- kétszintes, keskenyebb felső szintű háztömeg;
- két külön lejtésű, sötét indigó tetőszint cserépszegélyekkel;
- kopott vakolat, látható faváz és meleg, emisszív shoji ablakok;
- utcafronti `KatsuroDoor`, küszöb és veranda;
- egy meleg veranda-lámpás és finoman pulzáló `WarmEntryLight`, hogy a ház olvasható maradjon a ködös alkonyban;
- szinte mozdulatlan szélcsengő, amely csak nagyon lassan billen a veranda alatt;
- nedvesebb, fényesebb tető- és kőanyagok a hideg kékes-lilás környezetben;
- visszafogott külső jelzés Katsuro lezárt, ház alatti teréhez: ajtó, öt vájatú lemez és három nedves kőlépcső;
- Akira és Miyako emberarányát jelző külön F6 preview kockák.
- a ház híd felőli oldalához épített, alacsonyabb rendelőszárny saját oldalbejárattal és lámpásos táblával (F5 jelenet).

## Pályaillesztés

A közös ház ugyanazon a világpozíción maradt a híd utáni távolabbi házként. A meglévő `StaticBody3D` és `CollisionShape3D` továbbra is a szülőházon van, ezért a járhatóság és az encounter trigger nem változik. A régi látható blockout mesh elrejtve marad; a `SharedHomeExterior` gyermekben a GLB töltődik be, hiányában a procedurális változat látszik. A pontos házméret és a környező házak helye továbbra is F5 review után rögzítendő.

## Ellenőrzés

- F5: sétálj át a falun, kelj át a hídon, haladj el az első túlparti ház mellett, majd közelíts a közös házhoz.
- F5-ben ellenőrizd, hogy Miyako a ház előtt olvasható marad, és a találkozási kamera nem takarja el.
- F6: a `scenes/dev/shared_home_preview.tscn` külön, sötétebb atmoszférájú vizuális ellenőrző jelenete.

Ez még nem végleges asset. A végleges házelrendezést és a környező részleteket a vizuális irány jóváhagyása után rögzítjük.
