# Mountain Path — Blockout 2.0

## Cél

Az egyenes technikai tesztfolyosó helyett most már valódi jelenetritmus látszik. Minden elem továbbra is BLOCKOUT vagy PLACEHOLDER; ez még nem environment art pass.

## Jelenetritmus

**erdős indulás → első kanyar → szűkülő cédrusfolyosó → első furcsa jel → kilátópont Tsukimorira → levezető szakasz → régi útjelző → kapu**

A pálya alapja továbbra is egy egyszerű, sík járófelület. A vizuális tereptömegek és az út szélességének változása már magasságérzetet ad, de valódi járható lejtőt még nem vezetünk be. Ennek oka, hogy most nem akarjuk a slope/step kezeléssel megváltoztatni a már review alatt álló mozgásérzetet.

## Blockout-elemek

- öt egymásba futó út-szakasz;
- szélesebb kilátópont/clearing;
- cédrus proxy tömegek;
- sziklatömeg a kilátó szélén;
- külön kameraállás a kanyarhoz, kilátóhoz és kapuhoz;
- vékony papírcsík mint az első későbbi furcsaság vizuális helyőrzője;
- régi fa útjelző helye a `月守村 — Tsukimori` felirathoz;
- Tsukimori távoli háztömeg-preview;
- kapu és kaputrigger új végpontban.

## Review F5 után

Most nem a grafikai minőséget értékeljük. Menj végig Akirával oda és vissza, és figyeld:

1. természetesnek hat-e Akira mérete az út szélességéhez képest;
2. túl gyors vagy túl lassú-e a járás;
3. jó helyen nyílik-e ki a kép a kilátópontnál;
4. a kamera kilátóponti fordulása segít-e megmutatni a falut;
5. a kapu előtti közelebbi kép erősíti-e a megérkezést;
6. a fix WASD kezelhető marad-e akkor is, amikor a vizuális út kanyarodik;
7. van-e olyan pont, ahol Akira túl kicsi, túl nagy vagy takarásba kerül.

Ha ezek közül valamelyik rossz érzést ad, előbb a blockoutot/kamerát javítjuk, és csak utána kezdünk részletes environment asseteket gyártani.
