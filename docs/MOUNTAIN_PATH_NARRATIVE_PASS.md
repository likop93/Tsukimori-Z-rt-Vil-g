# Mountain Path — Narrative Pass 1

Ez a pass nem új játékrendszer, hanem a már működő hegyi út első történetmesélő rétege.

## Eseménysorrend

1. **Első furcsa jel**  
   Az ösvény mellett lógó papírcsík Akira elhaladása után, kis késéssel felé fordul. Nincs hangos effekt vagy jumpscare.

2. **Kilátópont**  
   A meglévő rendezett kamerazóna mellett egyszeri, nagyon enyhe FOV-légzés emeli ki Tsukimori első látványát. Az irányítás nem kerül elvételre.

3. **Régi útjelző**  
   A blockout táblán most ténylegesen szerepel: `月守村 — TSUKIMORI`.

4. **Kapu / első térbeli anomália**  
   A kapu előtti könnyű szirmok nem Akira felé sodródnak, hanem kis mértékben eltávolodnak tőle. A kamera rövid FOV-pulzust kap, majd Akira felirata megjelenik: **„Szél?”**

## Fontos rendezési elv

A jelenet továbbra sem horror-jelenet. A cél:

**szép → csendes → furcsa**

A furcsaságok legyenek észrevehetőek, de akár részben elmulaszthatók. Ne legyen hangos jumpscare, látványos varázslat vagy hosszú irányításelvétel.

## Technikai megjegyzés

A subtitle jelenleg egyszerű, helyi prototípus. Ez **nem** a végleges dialógusrendszer. A Narrative Pass 1 eseményei GameState flageket is beállítanak:

- `mountain_paper_oddity_seen`
- `saw_tsukimori_overlook`
- `gate_spatial_anomaly_seen`
- `entered_tsukimori`

## Review

F5 után menj végig normál tempóban, lehetőleg először úgy, hogy nem keresed tudatosan az effekteket. Azt kell eldönteni, hogy a három pillanat természetesen és fokozatosan építi-e a "valami nincs rendben" érzést.
