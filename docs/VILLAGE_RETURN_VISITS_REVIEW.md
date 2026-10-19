# Falusi helyszínek visszalátogatása — 2026-10-19
Státusz: IMPLEMENTED + tesztelt navigáció; REVIEW szövegek és meglévő REVIEW képek.

## Kész működés
- Az első bemutatkozás után Reina tanterme, Aoi boltja és Sora közös terme újra felkereshető. A meglévő, keret nélküli portrék és jóváhagyott megjelenések maradnak.
- Akira visszalátogatáskor orvosi portrét kap; a már történetileg megszerzett zöld jobb szem változatát a rendszer megőrzi.
- Ritsu műhelybejárata, a zeneszoba ajtaja, a patak falusi oldalának verandája, a piactér és a szentélylépcső külön látogatási azonosítót kapott.
- Ez öt külső találkozási pont, NEM öt elkészült új belső. A zeneszobába és a szentély belsejébe nincs önkényes beengedés.
- Otthonról külön gombbal elérhető a rendelőszárny. Innen vissza lehet térni otthonra, majd a faluba. Nem ismétlődik betegvizsgálat és nem nyílik ki Katsuro személyes dolgozószobája.
- Naptár a térképen, napi látogatási jelzés a célpontok súgójában.
- A bejárás nem ír át karakterismereti flageket, affinitást vagy horrorértéket. Első bemutatkozás továbbra is külön történeti esemény.

## Fájlok / assetstátusz
- data/home_day1/village_interiors.json: 3 belső + 5 külső pont + rendelő. Az új rövid visszatérési mondatok REVIEW összekötő szövegek, nem az eredeti Ren'Py szó szerinti idézetei.
- data/home_day1/character_locations.json: saját helyszín, hozzáférés, képi készültség. Hana piactere nyilvános találkozási pont, nem önkényesen kijelölt lakóház.
- scripts/opening/village_walk_director.gd: meglévő direktor és VN-rendszer bővítése.
- scripts/ui/village_map.gd: nap/napszak és napi látogatás.
Új képet nem generáltunk. A külső helyek meglévő területhátteret használnak. Ritsu végleges portréja/műhelybelsője, tiszta zeneszobaháttér, külön verandakép és Mashiro jóváhagyott bináris képei hiányoznak. Himiko és Renka helyszíne nincs késznek jelölve.

## Tényleges tesztek
Godot 4.7.2 stable / grafikus Compatibility futás.
- tests/ui/village_walk_regression.tscn → review/location_navigation.log: PASS. GUI-kattintások, 8 bemutatkozás, 8 visszalátogatási pont, külön rendelő, helyszínnapló, portrék, részleges/teljes hazatérés, pause/resume és átmenetek.
- tests/ui/night_day_regression.tscn → review/location_night_day.log: PASS. Eredeti első éjszaka → rendelő → kibővített falu → esti folytatás.
- Parse/runtime hiba nem jelent meg. A navigációs teszt kilépésekor 4 ObjectDB példány figyelmeztetése fennmarad; ez nincs megoldottnak állítva.
- Képi ellenőrzés: review/location_return_school_REVIEW.png, location_return_shop_REVIEW.png, location_return_inn_REVIEW.png, navigation_map_REVIEW.png.

## Még nincs kész
A 4–10. nap teljes történeti folytatása, a későbbi karaktertalálkozók, végleges production assetek és lemezre mentés. A naptár tesztje nem jelent tíz kész történeti napot.
