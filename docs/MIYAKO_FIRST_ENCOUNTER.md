# Miyako első találkozása — Ren’Py-jelenet

Akira a hegyi ösvényről érkezve **először végigsétál a falun**. A falusi párok figyelik, összenéznek és összesúgnak, ahogy elhalad mellettük. Shion háza a patak falusi oldalán áll. Akira átmegy a hídon, elhalad egy névtelen ház mellett, majd Katsuro egykori házához érkezik: itt **Miyako és Akira együtt laknak**. Miyako az utcai bejárat előtt, takarás nélkül várja; a találkozás kamerája oldalról fogja be őket.

- A találkozás egyetlen alkalommal indul, amikor Akira a ház elé ér.
- Akira mozgása megáll, Miyako felé fordul, majd a kánon első mondata jelenik meg: **„Dr. Akira. Már vártam.”**
- Enter vagy Space után a Ren’Py I. fejezetéből átvett VN-jelenet indul: az eredeti első találkozási kép, majd a ház belsejének eredeti képe, a szöveg és az első döntés. A képernyőn kattintással, Enterrel vagy Space-szel lehet továbbmenni; a választás egérrel, 1/2 gombbal vagy a kijelölt gombon Enterrel működik.
- A csendes válasz `aff_miyako +1` és `akira_gyogyulas +1` változást ad. A visszakérdezés nem módosítja ezeket; mindkét ág a Ren’Py eredeti sorait követi. A döntést a `GameState.miyako_first_choice` tárolja, és nem lehet kétszer érvényesíteni.
- Az ág végén a VN-kép bezárul, az utcai kamera és Akira irányítása visszatér. A Ren’Py első éjszakai jelenete és a további fejezetek még nincsenek átültetve.

Review: F5-tel menj végig a falun, kelj át a hídon, haladj el az első túlparti ház mellett, és érkezz Miyako és Akira közös házához. Ellenőrizd Miyako láthatóságát és az első mondat időzítését. Enter/Space után nézd végig a házbelső jelenetét, válaszd ki az egyik döntést, majd ellenőrizd, hogy az irányítás visszatér és a rendelő elérhető. Új játékindításkor próbáld ki a másik ágat is.
