# Tsukimori — első falubejárás REVIEW

**Dátum:** 2026-10-12

## Helye

Első két konzultáció → Katsuro rendelői füzet → **Ismerd meg Tsukimorit** → esti Miyako → Hana-hang → második nap.

A meglévő Hana → Miyako → éjszakai látogató → Shion → pecsét → esti tea láncot ez nem írja át.

## Első orientációs pontok

- Iskola — Reina formális bemutatkozása.
- Vegyesbolt — Aoi.
- Fogadó — Sora.
- Ritsu hangszerkészítő műhelye.
- Piactér — Hana névtelen, ismerős glimpse.
- Patak / kishíd — Shion helyének előkészítése.
- Zenei mellékutca — Kuroe tease, teljes találkozás nélkül.
- Szentélyhez vezető út — Oto távoli jelenléte; a lezárt rész és a Mélység nem nyílik meg.

A játékos a sorrendet szabadon választja, majd a nyolc pont után hazatér Miyakóhoz.

## State

Discovery:
`village_tour_started`, `school_discovered`, `shop_discovered`, `inn_discovered`, `workshop_discovered`, `market_discovered`, `stream_discovered`, `music_house_discovered`, `shrine_approach_discovered`, `village_tour_complete`.

Karakter:
`met_reina`, `reina_first_meeting_seen`, `met_aoi`, `met_sora`, `met_ritsu`, `hana_market_glimpse_seen`, `shion_stream_place_discovered`, `kuroe_music_place_discovered`, `oto_shrine_glimpse_seen`.

## Vizuális korlát

Első passzban a village street és bridge szolgál REVIEW stand-inként. Külön iskola/bolt/fogadó/műhely/patak/szentély production hátterek még hiányoznak.

Reina a jóváhagyott REVIEW portrét használja. Aoi/Sora/Ritsu/Oto számára ez a commit nem talál ki új vizuális authorityt.

## Sétálható REVIEW változat — 2026-10-12

A helyszínválasztó menü helyett Akira ténylegesen mozog. Az utcán az iskola,
bolt, fogadó és piac jelölése érhető el; a patakparti összekötőn a műhely,
patak, zenei mellékutca és szentélyhez vezető út. Ezek technikai belépési
pontok, nem végleges településtérkép vagy új épületdesignok.

- WASD / nyilak: séta; Shift: futás; E: közeli pont megnyitása.
- Utca alsó közepe ↔ híd bal széle: kétirányú átjáró.
- Mind a nyolc pont után a híd jobb szélén hazatérés Miyakóhoz.
- Beszélgetés után az előző hely és nézési irány áll vissza.
- Párbeszéd közben az ambient szereplők, korlátok és jelölések rejtve maradnak.
- A nyitány Hana/Shion/Kuroe cameói itt nem játszódnak újra.
- Közvetlen teszt: Fejezetválasztó → III. Falubejárás · Reina és a többiek.

Az eredeti JSON-szövegek és discovery flagek változatlanok. A bejárt pontok
nem ismételhetők; Kuroe személyes találkozása és Oto kiléte továbbra sem nyílik meg.

### Még hiányzó production assetek

- Az utca és híd már külön délutáni REVIEW változatot használ, az eredeti
  képek elrendezéséből és bemért mozgássávjából. A háttér és a korlátkivágatok
  ugyanarra a napszakváltozatra váltanak. A nyitány eredeti éjszakai képei megmaradnak.
- Külön iskola, bolt, fogadó, műhely, piac, patakpart, zenei ház és szentélyút
  hátterek, saját járhatósági és takarási adatokkal.
- Reina nagy felbontású jóváhagyott VN-kivágata: a repo kis felbontású preview-ja
  látható; nem végleges beszélgetésportré.
- Sora: `/Tsukimori Visual References/characters/SORA_FINAL_CHARACTER_SHEET_V1.png`.
- Oto: `/Tsukimori Visual References/characters/OTO_DAY_NIGHT_FINAL_CHARACTER_DESIGN_V1.png`.
- Aoi és Ritsu jóváhagyott production VN-kivágatai. Ezek nélkül a meglévő,
  portré nélküli találkozások maradnak; új karakterdesign nem készült.

A Library-masterek binárisai ebben a munkakörnyezetben nem hozzáférhetők.
Authority: `reference/characters/manifest.json`; minden LOCKED státusz megmarad.

Új képek: `assets/village_day1/`; a teljes prompt és forráskép párosítása a
`generation_manifest.json` fájlban. Beépített image_gen, két külön lighting-weather
szerkesztés. Ezek nem nyolc új helyszíntervként, hanem a meglévő utca és híd
napszakváltozataként kerültek be.

Hozzáférés-ellenőrzés: a GitHub friss main ágán nincs Sora/Oto FINAL képfájl;
az „Emlékmentés folytatása” chat ezt szövegesen is rögzíti. A „Folytatás írása”
chatből a rendelkezésre álló olvasó csak feloldatlan képhivatkozásokat ad vissza,
mellékletet nem. A böngészős Libraryhez nincs aktív bejelentkezés. A teljes
képi integráció ezért továbbra is a tényleges jóváhagyott fájlátadásra vár.

### Ellenőrzés

Godot 4.7.2: import, valódi bemenetes séta, megállási irány, szünet,
nyolc E-interakció, VN-visszatérés, oda-vissza átjáró, esti folytatás;
karakterlista és mind a tíz fejezetválasztó belépés.
A futási képek: `review/village_walk_*_REVIEW.png`.
Az első éjszaka → rendelés → falubejárás → esti Miyako teljes lánc mindkét
tesztelt választási ágon lefutott. Parse/runtime hiba nincs. A teljes lánc
tesztjének lezárásakor megmaradt a korábban is látott két ObjectDB-példányra
vonatkozó kilépési figyelmeztetés; ezt a változtatás nem javította.

## Következő lépés

Jóváhagyott masterek átvétele, nappali helyszínart és a technikai belépési pontok
lecserélése saját helyszínekre. A későbbi szabadidős rendszer külön lépés.
Himiko külön érkezési eseménye csak később, kb. a 3–4. játéknapon.

## 2026-10-13 — Újabb implementáció
A korábbi két térképre helyezett nyolc pontot a VILLAGE_HUB_REVIEW.md-ben
leírt, kilenc kültéri szakaszból és három belsőből álló falubejárás váltja.
A dokumentum fenti teszteredményei a korábbi dd89c4c állapotra vonatkoznak.
