# Esti látványpassz — közös ház, rendelő, első utca

**Státusz:** a Godot-jelenethez szerkesztett art pass; Blender-render és F5 bejárás még szükséges, ezért nem végleges assetjóváhagyás.

Az első, sötét ködös falukép hangulatát követjük. Kékes holdfény és mélyebb köd fogja össze a pályát, meleg shoji ablakok és lámpások jelölik az utat. Az utcakő nedves, de Akira útvonala és a kamera-kompozíció nem változott. A közös ház híd felőli kisebb rendelőszárnya saját oldalsó bejárattal megmaradt.

## A modell

- A játszható projektben már szerepel: `assets/buildings/shared_home/tsukimori_shared_home.glb`. Godot ezt a közös ház jelenetében automatikusan betölti, és a régi, egyszerűbb látható geometriát elrejti. A meglévő ütközés, a Miyako-jelenet és az animált lámpás, szélcsengő, eső és köd Godot-csomópontjai érintetlenek.
- A ház modelljét a `tools/blender/create_shared_home.py` állítja elő. A jelen ZIP-ben a Blender nélküli futtatás által készített GLB van. A **szerkeszthető Blender-forrás elkészítéséhez** a projekt gyökerében futtasd: `blender -b --python tools/blender/create_shared_home.py`; Blender Scripting munkaterületén is futtatható, ha a fájlt a projektből nyitod meg. Ez létrehozza az `assets/buildings/shared_home/tsukimori_shared_home.blend` fájlt, és frissíti a GLB-t.
- A közös modell két tetőszintből, kerámiacserepek tagolásából, ereszgerendákból, favázból, rácsozott shoji ablakokból, küszöbből, verandából és Katsuro ház alatti zárt terének külső jeléből áll. A rendelő oldalszárnyát és berendezését jelenleg a Godot-kód építi ugyanahhoz az épülethez; a végleges arányok későbbi kreatív ellenőrzés után rögzíthetők.

## F5 bejárás

1. A kaputól sétálj végig a falun. A nedves utcakő és a tócsák mutassanak fényt anélkül, hogy a falusiakat eltakarnák.
2. Menj át a hídon. Miyako és a közös ház külön látható legyen, a kamera ne forduljon az új tető mögé.
3. A közös ház híd felőli oldalán ellenőrizd a kisebb rendelőszárny és a lakóház tetőkapcsolatát; **E** a külön ajtónál.
4. A váróban és vizsgálóban ellenőrizd a járhatóságot, a meleg beltéri fényt és a kilépést.
5. Figyeld az esőt, talajködöt, lámpásokat és cédruskoronákat: mozogjanak, de a feliratokat és Akirát ne zavarják.

Technikai ellenőrzés Blender nélkül: `python3 tools/blender/create_shared_home.py` ugyanabból a geometriából újraépíti a GLB-t. A Blender-kimenet és a generált GLB statikus formája egyezik; a Blenderben véglegesített anyagokat külön kell vizuálisan jóváhagyni. A szereplők végleges modelljei, textúrái és portréi következő art feladatok.
