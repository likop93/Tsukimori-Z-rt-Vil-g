# Mountain Path — Animation Pass v0.2

Ez a pass a hegyi szakaszt már nem statikus blockoutként, hanem teljes, mozgó játékjelenetként kezeli. Továbbra sem FINAL animáció vagy FINAL environment art.

## Akira

A v0.2-es proxy-generátor most már:

- Idle
- WalkStart
- Walk
- WalkStop
- Lookout
- GateReact
- Run

animációkat készít.

A Walk súlyáthelyezést, medence- és mellkas-ellenmozgást, fejstabilizálást, lábfej/boka fázisokat és külön kabátcsontokat használ. Godotban az idle/start/walk/stop állapotok lágy blenddel váltanak, a walk playback pedig a tényleges sebességhez igazodik.

## Környezeti élet

A hegyi út folyamatos, visszafogott animációt kapott:

- a cédruskoronák eltérő fázisban mozognak;
- a köd sűrűsége nagyon enyhén változik;
- az útjelző táblája alig észrevehetően mozog;
- a papírcsík az anomália előtt finoman él a levegőben;
- a kapu szirmai lebegnek, majd az anomáliánál eltávolodnak Akirától.

## Narratív timing

- A papírcsík késleltetve fordul Akira felé.
- A kilátópont kamera-pillanata lassabb és kevésbé technikai.
- A kapunál Akira röviden lelassul/megtorpan.
- A szirmok eltérő késéssel és távolságra húzódnak el.
- Akira reakciója után jelenik meg: **„Szél?”**

A cél továbbra is:

**szép → csendes → furcsa**

Nem jumpscare, nem látványos varázslat.

## Review sorrend

1. Akira idle-je ne legyen szoborszerű.
2. Indulás/megállás ne pattanjon.
3. Járáskor legyen érzékelhető súly és ellenmozgás.
4. Forduláskor ne csússzon a teljes test.
5. A kabát mozgása legyen észrevehető, de visszafogott.
6. Az erdő mozogjon, de ne hullámozzon.
7. A kapu jelenet legyen furcsa, ne mágikus show.
8. Csak ezután lépünk tovább a kapu utáni első utcára.
