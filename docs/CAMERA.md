# Rendezett kamera – jelenlegi blockout

A kamera lágyan követi Akirát, a forgásától függetlenül. A WASD az aktuális
kameranézet talajra vetített irányai szerint mozgat: W előre/felfelé, S hátra/lefelé,
A balra, D jobbra. Átlósan sem gyorsabb a mozgás. Akira látható teste a tényleges
mozgás felé fordul. Kameraváltás közben is folyamatosan az aktuális nézet számít.

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

A kamerafordulás miatt az ösvény a képernyőn ferdén is futhat: ilyenkor WASD-vel
az út képernyőn látható irányát kell követni. Ez még blockout, végleges kompozíciót
a későbbi kanyarokkal/kilátóponttal együtt kap. Nincs szabad kameraforgatás,
irányításelvétel vagy új átvezető jelenet.

## Ellenőrzés

`godot --headless --path . --script res://tests/camera_regression.gd`

A teszt valódi player/world jelenetet és billentyűbemenetet használ: követés,
forgásfüggetlenség, oda-vissza zónaváltás és prioritás, képernyő szerinti WASD,
átlós sebesség, megállás, fordulás közbeni irányítás, egyszeri kaputrigger/HUD/FOV.

Kézi játékpróba: F5, induláskor W; az ösvény közepén figyeld az oldalra fordulást,
a kapu közelében az alacsonyabb/közelebbi képet, majd fordulj vissza. Az átmenetek
alatt Akira maradjon követhető, a WASD a látható képhez igazodjon.
