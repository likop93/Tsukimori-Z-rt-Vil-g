# Rendezett kamera – jelenlegi blockout

A kamera lágyan követi Akirát, a forgásától függetlenül. A WASD mindig azonos
világirányok szerint mozgat: W = −Z (a jelenlegi ösvényen a kapu felé), S = +Z
(visszafelé), A = −X, D = +X. Ezek a kezdő kameranézet előre/hátra/balra/jobbra
irányai. Átlósan sem gyorsabb a mozgás. Akira látható teste a tényleges mozgás
felé fordul. Kameraváltás, megállás, gombfelengedés vagy új gombnyomás sem
módosítja az irányrendszert; az irányítást csak a játékos gombválasztása határozza meg.

Három kompozíció van a jelenlegi, egyenes hegyi ösvényen:

| Szakasz | Yaw | Kamera helyzete a követett ponthoz képest | Dőlés |
| --- | ---: | --- | ---: |
| Kezdő / zónán kívüli nézet | 0° | (0, 7.2, 8.8) | −34° |
| Ösvény közepe – PathSide | 22° | (0, 6.4, 9.6) | −30° |
| Kapu – GateApproach | −12° | (0, 4.8, 8.2) | −18° |

A középső nézet z-tartománya −16…8, a kapué −32…−12. Az átfedésben a kapu
magasabb prioritása nyer. Visszafelé haladva az aktuális terület nézete áll vissza;
a zónákon kívül az alapnézet. A karakter ütközőjének széle is belépésnek számít.

Godotban a `MountainPath/CameraZones` alatti Area3D csomópontokon állítható a
terület mérete és helye, a yaw, a dőlés, a távolság/magasság és a prioritás.
Eltérő prioritásokat használjunk átfedő beállításoknál. Az alapnézetet a
`Player/CameraPivot/Camera3D`, a követési és átmeneti sebességet a `CameraPivot`
beállításai adják. A kapu meglévő FOV-effektjét a kamera nem írja felül.

A kamerafordulás miatt a W mozgásiránya a képernyőn ferdén is futhat, de az
ösvényen ugyanarra visz, felengedés és újraindulás után is. Ez még blockout, végleges kompozíciót
a későbbi kanyarokkal/kilátóponttal együtt kap. Nincs szabad kameraforgatás,
irányításelvétel vagy új átvezető jelenet.

## Ellenőrzés

`godot --headless --path . --script res://tests/camera_regression.gd`

A teszt valódi player/world jelenetet és billentyűbemenetet használ: követés,
forgásfüggetlenség, oda-vissza zónaváltás és prioritás, világirányú WASD mindhárom nézetben,
átlós sebesség, megállás, kameraváltás közben megtartott egyenes/átlós irány,
gombkombinációk, változatlan irány gyors újranyomás és teljes megállás után, egyszeri kaputrigger/HUD/FOV.

Kézi játékpróba: F5, induláskor W; az ösvény közepén figyeld az oldalra fordulást,
a kapu közelében az alacsonyabb/közelebbi képet, majd fordulj vissza. Az átmenetek
alatt a tartott W ne fordítsa el Akirát. Engedd fel az összes mozgásgombot, majd
nyomd meg újra a W-t: továbbra is ugyanarra haladjon az ösvényen.
