# Hana és Shion cameo — 2026-10-04

Státusz: REVIEW / PLACEHOLDER. A LOCKED design és a FIRST_VILLAGE_10_15_MIN_FLOW jelenetirány változatlan.

Hana a Village Street bal oldali, meleg fényű bejárata mellett áll (375,231), 1.25 skálával. A kontrollátadás után látható. Akira 155 px közelségére egyszer felpillant, 2.4 másodpercig szemkontaktust tart, majd visszatér a ruhaigazító pózhoz. Nincs névtábla, dialógus, collider vagy kontrollzár.

Shion a híd falusi oldalán, a járósáv mellett áll (183,165), 0.80 skálával. Előbb figyel, majd Akira x>=150 és 75 px közelségére elfordítja a tekintetét. A talppontja végig helyben marad. A házhoz váltás azonnal elrejti. Nincs névtábla, dialógus vagy kontrollzár.

Mindkét karakter külön sprite, y-sort, nearest szűrés, rögzített baseline és kontaktárnyék mellett. Az ambient szövegezés nem ad nekik idegen mondatokat. A hana_cameo_seen és shion_cameo_seen runtime jelzők csak a reakció után állnak; új játék törli őket. Ezek nem route/affinity változók.

Források és pontos generálási promptok: [generation.md](../assets/opening/hana_shion_cameos/generation.md). Hiányzik a végleges, köztes képkockás gesztusanimáció és a production karakter-review; a kétpózos váltás szándékosan ideiglenes.

Ellenőrzés: tests/opening/quiet_cameos_regression.tscn — intró alatti rejtés, skip utáni láthatóság, közelségi reakció, kontroll megőrzése, stabil talppont, átlátszó atlasz, helyszínváltás. Grafikus rögzítések: review/hana_cameo.png, review/shion_watching.png, review/shion_cameo.png.

Futtatási eredmény: quiet_cameos, kuroe_cameo, gate_flow és main_menu teszt PASS, exit 0. A 66 mp-es természetes intró, minden skip-pont, hídátkelés és Miyako találkozása sikeres. Nincs parse/runtime script-hiba. A Godot környezeti root certificate store diagnosztikája és a tesztleállításkor jelentkező ObjectDB figyelmeztetés továbbra is előfordul; nem állítunk teljesen figyelmeztetésmentes naplót.
