# Játék közbeni menü és futás — 2026-10-04 REVIEW

A meglévő kezdőmenü megmarad. Új szünetmenü: Folytatás, Beállítások (hangerő/teljes képernyő), Irányítás, Főmenü. Esc megnyitja játék közben, Tab vagy a jobb felső Menü gomb az intróban is. Intró alatt az Esc továbbra is az eredeti kihagyás-megerősítést nyitja. A szünet megállítja a SceneTree-t: mozgás, cinematic idővonal és VN szöveg is megáll. Almenüből Esc előbb visszalép; főmenübe visszatérés külön megerősítést kér a nem mentett előrehaladás miatt. Folytatás visszaadja a korábbi VN gombfókuszt. A Space szünet alatt nem aktiválja véletlenül a Folytatás gombot.

Shift nyomva tartása: futás, 118 px/s a 70 px/s sétával szemben. Gyorsulás 420 px/s² futáskor, fékezés 500 px/s², normalizált átlós input, meglévő collision és járható úthatárok. Külön négyfázisú REVIEW oldalfutó atlasz; balra tükrözve. A ciklus tényleges megtett távolságot követ, a kontaktárnyék a talajon marad. Shift csak szabad játékoskontrollnál hat; a scripted cinematic és VN mozgás nem változik. Front/back run továbbra is ideiglenes, az eredeti atlaszt használja gyorsabb ütemben.

Források, pontos promptok, hiányzó production animáció: [generation.md](../assets/opening/run_v1/generation.md).

Teszt: tests/ui/pause_run_regression.tscn. Intró-szünet, folytatás, intró/VN futásblokkolás, sebességkülönbség, fékezés, menü-szünet, hangerő, Esc almenü, VN szöveg befagyasztása, ház úthatárai és főmenübe visszatérés. Mért 0.7 mp-es sáv: séta 40.16 px, futás 67.00 px. A főmenü és Miyako VN meglévő tesztjei is sikeresek. Godot import/indítás nem adott parse/runtime script-hibát; a környezeti certificate-store és kilépési ObjectDB diagnosztika továbbra is előfordul.
