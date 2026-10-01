# Grafikai cél és otthoni eszközök

## Irány

Tsukimori sötét fantasy anime játék marad: mély kék alkony, nedves falu, ritka meleg ablakfény, a ködben jól olvasható útvonal. A cél a Persona 4 Golden léptékű és következetességű **játék közbeni** karakter-, épület- és környezetminőség. Ez minőségi referencia, nem annak szereplői, képei vagy UI-elemei kerülnek a játékba. A három most készülő falusi GLB, a helyben festett anyagok és az új fénypassz egy próbálható lépés, még nem igazolt végleges grafikai szint.

## Otthoni Windows gépen

| Sorrend | Eszköz | Miért kell | Link |
|---|---|---|---|
| 1 | Godot 4.7.2, Windows x86_64, **normál** kiadás | A GDScript projekt megnyitása, GLB import és F5 bejárás. A .NET verzióra nincs szükség. | https://godotengine.org/download/windows/ |
| 2 | Blender 5.2 LTS | A házak és későbbi karakterek GLB modelljeinek megnyitása, módosítása, saját `.blend` fájlok mentése. | https://www.blender.org/download/ |
| Később | Material Maker | Részletesebb saját PBR anyagok, normal és roughness textúrák. A jelenlegi játék futtatásához nem kell. | https://www.materialmaker.org/ |
| Később | Poly Haven | Válogatott CC0 kő, föld, fa és környezeti referenciák; csak a szükséges elemeket hozzuk be. | https://polyhaven.com/ |

A projektben lévő PNG és GLB fájlokat Godot közvetlenül beimportálja. A `tools/blender/create_village_houses.py` forrás újrafuttatásához Python 3 kell; a generátor nem feltétele a játék indításának. A régebbi `create_shared_home.py` Blenderben külön `.blend` forrást is tud menteni; az új falusi GLB-ket Blenderben a File → Import → glTF 2.0 menüből nyithatod meg, majd saját `.blend` példányként elmentheted.

## Pontos első próba

1. Töltsd le és bontsd ki a friss projekt ZIP-et, vagy frissítsd a GitHub munkamásolatot.
2. Indítsd a normál Godot 4.7.2 szerkesztőt, válaszd az **Import** gombot, és tallózd ki a kicsomagolt `Tsukimori/project.godot` fájlt.
3. Várd meg, amíg a FileSystem import végez a három `assets/buildings/village/kominka_*.glb` modellel és a képekkel, utána nyomj **F5**-öt.
4. Járd végig a hegyi ösvényt, az utcát, Shion házát, a hidat, Miyako és Akira közös otthonát, végül az erdőt. Nézd meg, látszanak-e az ablakok, és nincs-e kilógó modell vagy megakadó kamera.
5. Ha a Forward+ indulásnál képernyő vagy driver hiba jelentkezik, a parancssori `--rendering-method gl_compatibility` kapcsolóval külön ellenőrizhető a régi mód. A grafikai összehasonlítást Forward+ módban végezzük.

A saját, RTX 4070 Super kártyád alkalmas ahhoz, hogy a Forward+ fény- és árnyékhatásokat kipróbáljuk. Először a gépeden látott három jelenetről kérünk képet: **ösvény indulás**, **fő utca**, **híd utáni ház és rendelő**. Az arányokat és a kész animált ház végső kinézetét ezek után hangoljuk. Nem szükséges most fizetős asset vagy előfizetés.

## Következő látványkapuk

- Egy mintaház és egy mintacédrus végleges geometriája, anyaga és esti fénye; ellenőrzés az utcáról és a híd túloldaláról.
- Akira és Miyako karaktermodell, arcanimáció, ruhaanyag és mozgás minőségi összehangolása a környezettel.
- Kő, föld, fa és lombozat célzott normal/roughness anyagai, majd sűrűbb, de továbbra is járható környezet.
- Játékbeli képek és teljesítmény mérés után visszafogott utómunka; UI és portrék ugyanabba a színvilágba kerülnek.

Épülethelyeket csak akkor véglegesítünk, amikor a modellek mérete és kinézete a Godot kamerájából már jó.
