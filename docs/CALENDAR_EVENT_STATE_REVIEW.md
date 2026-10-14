# Nap- és eseményállapot — 2026-10-14
Státusz: IMPLEMENTED / Godot-teszttel ellenőrizve; nem teljes 10 napos történet.

## Megvalósult
A meglévő GameState bővült, nincs második állapotkezelő vagy dialógusrendszer.
- 0. nap: megérkezés és prológuséjszaka. 1. nap: első rendelés, falu, este.
- 2. nap: Hana, délutáni Miyako, éjszakai látogató. 3. nap: Shion, pecsét, esti tea.
- 1–120 nap, reggel/rendelés/délután/este/éjszaka; előrefelé léptetés. Új játék nulláz.
- Évszakok: 1–30 tavasz, 31–60 nyár, 61–90 ősz, 91–120 tél.
- weather_anomaly nem állítható igazra a közös flag API-n a 30. nap előtt. A 30. nap csak jogosultságot ad; nincs kitalált időjárási jelenet.
- Látogatási napló nap/napszak/helyszín szerint; a felfedezés és a karakter megismerése külön állapot.
- Egyszeri eseményfeltételek: napintervallum, napszak, helyszín, szükséges/kizáró flagek.
- Valós döntésnapló külön az eddigi affinitástól és horrorértékektől. Utazás és tesztbelépés nem ad pontot.
- Mashiro meghívása 5–10. napon, otthon; első látogatás legkorábban másnap délután. Másnap/pár napos/késői látogatás külön állapot. A teljesített látogatás időzítése később nem romlik.
- Komoly másik kapcsolat és mindkét hárem-elköteleződés kizárja Mashiro True-route jogosultságát; barátság/flört nem. Kölcsönös kizárás. Nincs automatikus ending.
- 5+ napos késés overdue állapot, nem önkényesen végleges route-lezárás: a kánon szerint ilyenkor lezárulhat.
- A route-elköteleződés API jelenleg infrastruktúra, nem új, korai játékosválasztás.

## Ellenőrzött futások
Godot 4.7.2 stable.
- tests/state/calendar_regression.tscn → review/calendar_regression.log: PASS. Mind a 120 nap, évszakhatárok, 29/30 időjárás, eseménykapuk, késési esetek, kizárólagosság, nullázás.
- tests/ui/night_day_regression.tscn → review/calendar_night_day.log: PASS, valódi grafikus futás. Meglévő éjszaka → első rendelés → térkép → esti folytatás, naptárállapotokkal.
- tests/ui/hana_day_regression.tscn → review/calendar_hana.log: PASS, négy döntéskombináció, 2. napi rendelés.
- tests/ui/tea_regression.tscn → review/calendar_tea.log: PASS, kilenc meglévő változat, 3. napi esti checkpoint.
Ezekben a futásokban nincs parse/runtime hiba.

## Határok és források
A naptár egy futáson belüli tartós állapot; lemezre mentés még nincs. Nincs új horrorjelenet, karakterkép vagy folyosóimplementáció.
Mashiro végleges bináris képei hiányoznak; MASHIRO_ASSET_MANIFEST.md irányadó.
Az eredeti Ren'Py-forrás helyben megtalálva: Downloads/Tsukimori_RenPy_Prototype/game/Tsukimori/game. Régi jelenetsorrendje nem írhatja felül a 120 napos handoffot, a javított Hana-szöveget vagy az új vizuális döntéseket.
A 4–10. nap teljes, jóváhagyott jelenetsorának portja még nincs kész. Nem minősítjük kész történetnek a puszta napléptetést.
