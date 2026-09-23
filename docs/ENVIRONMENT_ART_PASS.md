# Falusi környezet — anime realizmus, első anyagpassz

Az első alkonyati hangulat és a bejárható történeti útvonal marad az alap. Ezzel a passzal a falusi tér kapott anyagmélységet: a vakolat, a cédrusfa, a tető, a föld és a nedves kő saját, visszafogott, ismételhető színmintát használ. A textúrák helyben, rögzített maggal készülnek; nincsen külső licencfüggőség. A tető finom gerendákat, a shoji ablak további keresztrudakat kapott. Az erdei cédrusokon a szögletes látható törzs helyére keskenyedő törzs került, a korona szélét kisebb lombfürtök bontják meg.

Az út szélén néhány alacsony mohás, kavicsos folt oldja a korábbi egybefüggő síkot. Ezeken nincs ütközés. A házak és a cédrusok továbbra is vizuális prototípusok. Miyako és Akira közös házának jóváhagyott GLB-jét ez a passz nem építi újra; az oldalsó rendelő külső anyagai a falu anyagcsaládját követik. A járható felületek, házütközések, kameraállások és találkozási sorrend változatlanok.

## Forrás és futtatás

Az öt PNG forrása: `tools/art/generate_environment_textures.py`. Újragenerálás a projekt gyökeréből:

```bash
python3 tools/art/generate_environment_textures.py
```

Ehhez Python, Pillow és NumPy kell; a generált PNG-k már a projektben vannak, tehát **a Godotban történő futtatáshoz nem szükséges Python**. Godot 4.x alatt a `project.godot` megnyitása után F5. A `tests/first_street_regression.gd` Godot-val, headless módban futtatható, ha a futtatókörnyezetben elérhető a Godot bináris.

## F5 vizuális ellenőrzés

1. A falusi utcán az út nedves kövei és a kétoldali házak anyagai látszanak, de a lámpások mellett sem válnak rikítóvá.
2. A shoji keresztrudak, a tető peremei és a vakolat ugyanabban az esti fényben olvashatók.
3. A híd után a rendelő külső anyaga illeszkedik a környékhez; a külön ajtó és az E-vel belépés működik.
4. Az erdőben a cédrusok nem egyforma sima kúpok, a koronájuk továbbra is finoman mozog. Az utak járhatók, és Miyako látható marad a találkozási képen.

Az arányokat, a házak végső elrendezését és a kész animált ingatlan minőségét a végleges modellekkel lehet megítélni. A következő látványkörben érdemes a teljes környezet 3D épületeit és vegetációját véglegesíteni a jóváhagyott képi referencia alapján.
