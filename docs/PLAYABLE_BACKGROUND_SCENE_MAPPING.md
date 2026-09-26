# Tsukimori — Playable Background Scene Mapping v1

**Dátum:** 2026-09-26  
**Státusz:** APPROVED PLAYABLE BACKGROUND BASES

## Cél

Ez a dokumentum a jelenlegi négy jóváhagyott pixel-art hátteret konkrét játéktéri szerephez köti.

A képek **nem FINAL shipping assetek**, de:
- használhatók az első playable slice-ban;
- használhatók kamera-, sprite-, parallax- és interaction teszthez;
- vizuális alapként tovább finomíthatók;
- nem írhatják felül a LOCKED térbeli kánont.

Kötelező vizuális authority:
- `docs/PIXEL_ART_PRODUCTION_DIRECTION.md`
- `docs/CHARACTER_BIBLE.md`
- `docs/VISUAL_REFERENCE_INDEX.md`

---

# 1. VILLAGE_STREET_PIXEL_V1

Library:
`/Tsukimori Visual References/backgrounds/VILLAGE_STREET_PIXEL_V1.png`

## Játéktéri szerep
**Első falusi főutca / kapu utáni bejárható szakasz.**

Feladata:
- megmutatni Tsukimori első igazán lakott arcát;
- rögtön létrehozni a hideg éjszaka + meleg belső fény kontrasztot;
- biztosítani az első szabadabb exploration-szakaszt;
- háttérben jelezni, hogy a falu jóval nagyobb, mint amit Akira elsőre lát.

## Walkable lane
A fő járható sík az alsó-középső nedves kőút.

A karakter:
- ne járhasson fel a házlépcsőkre automatikusan;
- ne mehessen le a mélyebb háttérbe;
- a háttérhíd / magasabb falurész ne legyen közvetlenül elérhető ebből a képből.

## Interakciós pontok
- bal oldali házbejárat;
- lámpa / útjelző;
- opcionális NPC-hely;
- távoli torii / magasabb falurész megfigyelési pont;
- út folytatása a híd felé.

## Fontos korrekció
A képen látható torii/pagoda-szerű magasabb építészeti elem **vizuális háttér**, nem automatikus térképi kánon.

---

# 2. BRIDGE_PIXEL_V1

Library:
`/Tsukimori Visual References/backgrounds/BRIDGE_PIXEL_V1.png`

## Játéktéri szerep
**A patakhíd — nagy vizuális és narratív átmenet a falu és Miyako/Akira háza között.**

Ez a hely:
- a falusi oldal és a túlpart közötti határ;
- tempóváltó jelenet;
- fontos atmoszférikus beat;
- későbbi természetfeletti események egyik erős helyszíne.

## Walkable lane
A híd teljes felső járófelülete.

A játékos:
- balról jobbra / jobbról balra kelhet át;
- rövid ideig megállhat a híd közepén;
- nem mehet le a vízhez ezen a scene-en belül.

## Interakciós pontok
- híd közepe: víz-megfigyelés;
- korlátnál rövid Akira-look / belső monológ;
- túlparti házfény mint destination cue;
- később Shion / Katsuro / fekete víz kapcsolódású események.

## Kamera
A híd ne csak közlekedőhely legyen.
Kell:
- enyhe kamera-hold a közepén;
- vízreflexió;
- köd;
- foreground növény / korlát takarás;
- távoli meleg fények.

---

# 3. MIYAKO_HOUSE_EXTERIOR_PIXEL_V1

Library:
`/Tsukimori Visual References/backgrounds/MIYAKO_HOUSE_EXTERIOR_PIXEL_V1.png`

## Játéktéri szerep
**Miyako és Akira közös háza / Katsuro egykori háza — külső hero location.**

Ez legyen az első nagy „megérkeztél” pillanat a túlparton.

## Kötelező térbeli értelmezés
- a ház a patak túloldalán van;
- a rendelőszárny ugyanennek az ingatlannak a része;
- a rendelőnek külön, híd felőli publikus bejárata van;
- a lakóbejárat és a rendelőbejárat vizuálisan elkülöníthető.

## Walkable lane
Az előkert / kőjárda alsó-középső része.

Lehetséges:
- főbejárat;
- rendelőbejárat;
- oldalkert / később zárható irány;
- ablak / veranda megfigyelési pont.

## Interakciós pontok
- főajtó;
- rendelőajtó;
- verandafény;
- Katsurohoz köthető apró tárgy / jel;
- Miyako first-encounter trigger.

## Első találkozás
Itt történik a beauty-target jelenet:
**„Dr. Akira. Már vártam.”**

---

# 4. SHARED_HOME_CLINIC_INTERIOR_PIXEL_V1

Library:
`/Tsukimori Visual References/backgrounds/SHARED_HOME_CLINIC_INTERIOR_PIXEL_V1.png`

## Játéktéri szerep
**Közös lakótér + rendelő közötti első belső hub.**

A jelenlegi kép nem egy teljes floorplan, hanem egy **hero interior slice**.
Feladata:
- megadni a ház belső pixel-art nyelvét;
- definiálni a fa / shoji / lámpafény / klinikai részlet arányát;
- prototípusban már járhatóvá tenni a nappali–folyosó–rendelő kapcsolatot.

## Járható zónák
Első implementációban:
- bal: lakótér / átmenet;
- közép: közös nappali / beszélgetőtér;
- jobb: rendelő / vizsgáló irány;
- hátsó folyosó: későbbi szobákhoz vezető átmenet.

## Interakciós pontok
- teaasztal;
- komód / Katsuro tárgy;
- folyosóajtó;
- rendelőbejárat;
- vizsgáló / orvosi szekrény;
- később zárt szobák.

## Fontos
A teljes ház floorplan külön room-scene-ekből épüljön.
Ezt a hátteret nem kell erőltetetten minden helyiség egyetlen képeként használni.

---

# 5. Első playable sequence

A négy háttér javasolt sorrendje:

1. **Village Street**
2. **Bridge**
3. **Miyako House Exterior**
4. **Shared Home / Clinic Interior**

Ez közvetlenül támogatja a jelenlegi első slice-ot:

**falu → híd → ház → első találkozás → belső felfedezés**

---

# 6. Parallax / layer bontás

Minden külső scene-nél minimum:

1. sky / moon;
2. distant mountain;
3. far village;
4. background architecture;
5. midground architecture;
6. walkable lane;
7. foreground occluders;
8. rain / mist / particles;
9. light/reflection overlay.

Belső scene-nél minimum:

1. deep interior / window background;
2. back wall / architecture;
3. furniture back layer;
4. walkable floor;
5. interactive furniture;
6. foreground furniture / frame;
7. light / dust / atmosphere overlay.

---

# 7. Production státusz

Mind a négy kép:

**APPROVED PLAYABLE BASE**

Nem FINAL.

FINAL előtt kötelező:
- layer separation;
- walkable lane validation;
- pixel-density consistency;
- sprite scale review;
- collision/interactions;
- foreground occlusion;
- lighting integration;
- loopable VFX;
- in-game review Akira FINAL pixel sprite-tal.

