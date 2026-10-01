# Megőrzött 3D prototípus

Archiválva: 2026-10-01. Ez térbeli és technikai referencia, nem az aktív production irány. A 3D modellek és képek változatlan bájtokkal maradtak meg; a migration_manifest.json az eredeti útvonalakat és archiválás előtti SHA-256 értékeket tartalmazza. Szöveges hivatkozások és import metaadatok az új helyükhöz igazodtak.

A repó gyökerében lévő project.godot megnyitása után az archive/legacy_3d/scenes/main.tscn külön F6-tal futtatható. Nem önálló Godot-projekt: a gyökér GameState autoloadját használja. Nincs .gdignore, így az editor továbbra is importálhatja és ellenőrizheti.

A generátorok archive/legacy_3d/assets alá mentenek. A Blenderben megnyitott szkriptet innen, mentett fájlból futtasd. A shared-home generátor Pythonból is használható. Az Akira GLB korábban sem volt verziókövetett; hiányában a meglévő procedurális proxy működik.

Régi tesztek a projekt gyökeréből: Godot --headless --path . --script res://archive/legacy_3d/tests/first_street_regression.gd (illetve camera_regression.gd és portable_proxy_regression.gd).

Az archívum nem írja felül a gyökér docs mappájának kreatív authorityját. A régi 2D-s automatikus érkezés dokumentuma nem került a 3D archívumba.

Ellenőrzés: az archivált 3D főjelenet betölt, a first_street_regression egy hibát jelez a klinika padlójára érkezésnél (Clinic entry did not land on a walkable floor). Ugyanez a teszt az archiválás előtti 2cd2600 példányon ugyanitt, ugyanilyen hibával végződik. Ez megőrzött korábbi hiba, nem sikeres teljes 3D regresszió. A jelenlegi pixel-art nyitási, felirat- és grounding tesztek sikeresek.
