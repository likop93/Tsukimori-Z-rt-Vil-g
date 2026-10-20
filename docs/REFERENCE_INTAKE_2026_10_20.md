# Mashiro és Ayame — referenciák átvétele
Dátum: 2026-10-20. Forrás: a tulajdonos által ebben a fejlesztési chatben megadott két helyi ZIP. Újragenerálás nem történt.

## Integritás és státusz
- Mashiro: 29 médiafájl (27 PNG, 1 JPG, 1 GIF); Ayame: 2 PNG.
- Mind a 31 fájl dekódolható; a ZIP-ben kapott manifeszt mind a 31 SHA-256 értéke egyezik a kibontott példánnyal.
- Az eredeti fájlnevek, forrás-ZIP hash, kép-/képkockaméretek és másolati nevek a két leltárban szerepelnek: [Mashiro](../reference/incoming/2026-10-20/mashiro/inventory.json), [Ayame](../reference/incoming/2026-10-20/ayame/inventory.json).
- A számozott másolatok eredeti bájtokat őriznek. Az eredeti ZIP és a szinkronizált sources mappa változatlan.
- A reference/incoming/2026-10-20/.gdignore kizárja a nyers referenciacsomagot a Godot automatikus importjából. Egyedül Ayame bolti forrásának változatlan másolata kerül a futó REVIEW jelenethez az assets/home_day3 mappába.
- Ez tulajdonosi referenciabeérkezés, nem ellenőrzött, külső szolgáltatói production package. Nincs önkényesen megadott SPDX licenc vagy game-dev admission receipt. A helyi game-dev parancs nem érhető el; a csomag saját hash-manifesztjét helyi ellenőrzés hitelesítette, nem a plugin admission folyamata.

## Mashiro hozzárendelési jelöltek — REVIEW, nem új design-LOCK
| Eredeti referencia másolata | Tartalom / felhasználás |
|---|---|
| mashiro/18.png | Nappali/éjszakai karakterlap; a LOCKED bible leírt fehér haj, szemüveg, emberi/róka identitás szerinti referencia. |
| mashiro/25.png | Bővített többpaneles karakterlap, oldal/hátsó nézetek és részletek. |
| mashiro/22.png | Másik többpaneles lap; eltérő ruházat/kompozíció, supporting REVIEW. A generált feliratok nem új életrajz. |
| mashiro/05.png és 24.png | Virágcsokros találkozás, Akira és Miyako jelenlétével; a FIRST_MEETING CG lehetséges forrásai. Két változat, nem két implementált esemény. |
| mashiro/21.png, 26.png, 27.png | Nappali üvegházi találkozás-változatok. A konkrét első látogatás rögzített ruháját és Akira megjelenését külön egyeztetni kell. |
| mashiro/17.png | Holdfényes rókaalak, többpaneles kompozíció; nem kész teljes képernyős CG. |
| mashiro/19.png | Két nő közös képe; önmagában nem bizonyítja a másik nő Sayuri-identitását vagy a titkos route teljes kánonját. |
| mashiro/29.gif | Pásztázó előnézet. A LOCKED bible kifejezetten nem hagyta jóvá production animációként; fájlnévben a LOCKED szó ezt nem írja felül. |
| További képek | Korábbi romantikus jelenetváltozatok, eredeti referenciaként archiválva. Nem kerültek automatikusan route-ba vagy galériába. |

A runtime szétválasztott, átlátszó teljes alak, reakciórétegek, blink/fül/farok animáció és a végleges CG-azonosítók továbbra is hiányoznak. A beérkezett képek nem új spritesheetek.

## Ayame
- ayame/02.png: bolti első találkozás. A képen beégetett szövegdoboz és négy válasz található. A felirat nem automatikus történeti authority.
- ayame/01.png: éjszakai küszöb-kompozíció, a későbbi éjszakai találkozás referenciája. Nincs a 3. napba bekötve; az első Hetedik Éjszaka még nincs implementálva.
- A 3. napi REVIEW megjelenítés a 02.png változatlan másolatának felső 1672×650 részét mutatja AtlasTexture-rel. A megrajzolt UI nem látszik, nem állítunk mögé második dialógusrendszert. A kép fennmaradó részét nem szerkesztettük át.
- Hiányzik a UI nélküli production CG, átlátszó egész alak és reakciókészlet. Félalakos kivágattal nem helyettesítettük a kért egész alakos karakterlapot. A karakterlap és a teljes romance route még nincs bekötve.

A runtime eredmények és a 3. nap: [DAY3_VILLAGE_REVIEW.md](DAY3_VILLAGE_REVIEW.md).
