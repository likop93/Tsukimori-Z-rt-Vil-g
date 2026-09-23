# Miyako és Akira közös háza — vizuális prototípus

**Dátum:** 2026-09-23  
**Állapot:** BLOCKOUT — F5 review szükséges

## Vizuális irány

A ház a kiválasztott első atmoszférakép hangulatát követi: hideg kékes-lilás alkony, ködös cédruserdő, nedves kő és visszafogott meleg fény a papírablakokban. A geometria egy sötét, régi japán falusi házat idéz, két tetőszinttel, fa vázzal, fedett verandával és az utca felé néző bejárattal.

## Mi került be

- kétszintes, keskenyebb felső szintű háztömeg;
- két külön lejtésű, sötét indigó tetőszint cserépszegélyekkel;
- kopott vakolat, látható faváz és meleg, emisszív shoji ablakok;
- utcafronti `KatsuroDoor`, küszöb és veranda;
- `WarmEntryLight`, hogy a ház olvasható maradjon a ködös alkonyban;
- Akira és Miyako emberarányát jelző külön F6 preview kockák.

## Pályaillesztés

A közös ház ugyanazon a világpozíción maradt a híd utáni távolabbi házként. A meglévő `StaticBody3D` és `CollisionShape3D` továbbra is a szülőházon van, ezért a járhatóság és az encounter trigger nem változik. A régi látható blockout mesh elrejtve marad, a részletesebb modell a `SharedHomeExterior` gyermekben épül fel.

## Ellenőrzés

- F5: sétálj át a falun, kelj át a hídon, haladj el az első túlparti ház mellett, majd közelíts a közös házhoz.
- F5-ben ellenőrizd, hogy Miyako a ház előtt olvasható marad, és a találkozási kamera nem takarja el.
- F6: a `scenes/dev/shared_home_preview.tscn` külön, sötétebb atmoszférájú vizuális ellenőrző jelenete.

Ez még nem végleges asset. A végleges házelrendezést és a környező részleteket a vizuális irány jóváhagyása után rögzítjük.
