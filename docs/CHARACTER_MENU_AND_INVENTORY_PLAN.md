# Karakterlapok, kapcsolati státusz és későbbi inventory

2026-10-04. Státusz: tulajdonosi igény rögzítve / IMPLEMENTATION PLAN. Ez a dokumentum jövőbeli menübővítést készít elő; nem jelent elkészült funkciót vagy új történeti lockot.

## Következő menübővítés: Karakterek

A játék közbeni menüből megnyitható karakterlista és részletes karakterlap szükséges: jóváhagyott portré, megismert név, rövid leírás, az eddig megtudott információk és aktuális kapcsolati státusz. A képek és szövegek authority-ja a CHARACTER_BIBLE, DECISION_LOG, VISUAL_REFERENCE_INDEX és a már megjelenített történeti forrás. Az ismeretek fokozatosan bővülnek a valóban lejátszott találkozásokkal.

Javasolt spoiler-védelem: még nem látott szereplő rejtve; név nélküli cameo után név és életrajz nélkül, ismeretlen alakként szerepelhet. A hana_cameo_seen, shion_cameo_seen és kuroe_cameo_passed nem jelentenek bemutatkozást. Miyako nevét és történeti szerepét az első tényleges találkozás után szabad feltárni. A referencia-board feliratai nem használhatók automatikusan karakterleírásként.

## Kapcsolati státusz

Első verzióban a meglévő történeti jelzők és választások olvasható összefoglalója jelenjen meg. A met_miyako, miyako_first_dialogue_seen, miyako_interior_dialogue_seen és miyako_first_choice már rendelkezésre áll; az aff_miyako változást a meglévő választás kezeli. A lap megnyitása nem módosít kapcsolatot vagy játékállapotot.

Javasolt kezdeti megjelenítés: találkozás/beszélgetés állapota és az ismert események rövid összefoglalója. Bizalom, vonzalom, barátság vagy kapcsolatfokozatok csak történeti forrással és jóváhagyott küszöbökkel vezethetők be. Egyetlen pozitív választásból nem következhet romantikus kapcsolat. Kitalált százalékok, szívecskék vagy új route-változók nem részei ennek az előkészítésnek.

## Későbbi lépés: inventory

A tulajdonos idővel tárgylistát is kér. Ez külön későbbi implementáció; a jelenlegi build nem kap tárgyrendszert. A menü szerkezete később bővíthető Tárgyak lappal. Tárgynevek, leírások, képek, megszerzés és felhasználás a konkrét történeti jelenetekből származzanak. Levelek, nyomok és egyéb tárgyak csak jóváhagyott tartalom alapján kerülhetnek bele. Nincs előre feltöltött fiktív tárgykészlet, crafting, combat-equipment vagy összetett mentési rendszer.

## Implementációs sorrend és ellenőrzés

1. Karakterlap-adatok és felfedési szabályok a már megvalósult találkozásokhoz.
2. Karakterlista/részletes lap a szünetmenüből; egér, nyilak, Enter és Esc, helyes fókusz-visszaadás.
3. Kapcsolati státusz a meglévő GameState alapján, olvasási műveletként.
4. Később történethez kötött tárgylista.

Ellenőrzéskor szükséges: új játék ne fedjen fel ismeretlen neveket/titkokat; cameo ne nyisson teljes életrajzot; VN alatt továbbra is valódi szünet maradjon; a lap nem módosíthat affinityt vagy választást; új játék törölje az előző futás adatait. A meglévő intró, Miyako-beszélgetés, két választás, szünetmenü és futás megmarad.
