# TSUKIMORI — Work integrációs utasítás, egy szűk kör
**NE újraírás. NE új tervezési kör.** A kreatív munka és az assethivatkozások itt készültek; a Work elsődleges feladata tényleges Godot-integráció és mérhető teszt.

## Átadott referenciák
`01_KANONIKUS_KEPREFERENCIA/` mappában 3 **eredeti, tulajdonos által átadott fájl**. A fájlokhoz ne nyúlj, új karakterazonosságot ne generálj. Az `02_KARAKTERKANON_ES_MIMIKA_V3.md` mondja ki a személyazonossági és korai ruházati szabályokat.

## Work feladatának első etapja
1. Ellenőrizd a valós legfrissebb helyi Godot/GitHub állapotot, és sorold be a shotlist P0 elemeit `REUSE`, `FIX`, `MISSING` csoportba. Ne feltételezd, hogy a meglévő assetek hiányoznak.
2. A nyitó folyamatban busz helyett személyautó. Parkolás a faluszélen, gyalogos cinematic eljutás a hídon túl lévő Miyako-házig. Nincs WASD, nincs walking sprite; csak click/continue/cinematic.
3. A látható Akira CG-kben a felhasználói, szemüveg nélküli, sötét kabátos + szürke kapucnis identitás. Minden régi szemüveges/öltönyös CG potenciálisan `FIX`, nem automatikusan beépíthető.
4. Miyako korai megjelenése pontosan a tulajdonos sötét ruhás portréja; a felsorolt arckifejezésekből először 5. A normál tea és a korai első jelenetek érzelmei váltakozzanak. A későbbi ezüst/kék transzformáció ne jelenjen meg.
5. Az aktuális VN CG megjelenítő `cg` supportját használd; ne írj új dialogue core rendszert. Minden teljes jelenet-CG felirat/UI nélküli, az UI Godotban fölé kerül. Ne poszter/collage.
6. A meglévő map, visszatérés, klinikai páciens-flagek, beszélgetések és napállapotok tovább működnek. Az ismert korai pszichológiai spoilert külön szövegauditban javítsd, ne írj minden dialógust át.
7. Kérj/tarts owner review-t az először beépített **3 kulcsjelenet** után: `CG00_02` vezetés, `CG00_09` Miyako találkozó, `CG_EARLY_TEA` Miyako pecsét utáni esti tea. A további P1/P2 képeket addig ne kezeld FINAL-nak.

## Pontos működési ellenőrzés (PASS/FAIL + screenshot)
- busz se szövegben, se képen, se menüben ne legyen; kocsi a falu szélén marad
- semmilyen kézi karaktermozgás ne kelljen a 0–3. naphoz; minden helyszín gombbal elérhető
- Akira az 1–3 első kulcsjelenetben teljesen szemüveg nélküli; **nem** fekete öltönyös és nem orvosi köpenyes
- Miyako az eredeti fekete ruháját és barna szem/sötét haj azonosságát őrzi; legyen legalább nyugodt és meleg (nem kizárólag komor) reakció
- a híd két oldala és a közös otthon helye ugyanaz marad
- a két első rendelési páciens változatlan, köpeny csak rendelőben
- a CG-váltás nem tüntet el párbeszédet, nem léptet át választást, és nem indít duplán eseményt
- meglévő `review` képernyőképekkel összevethető új képernyőképek; tulajdonosi jóváhagyás előtt státusz `REVIEW`

## Fájlprioritások
- `docs/STORY_CANON.md`, `docs/DECISION_LOG.md` érvényben maradó szabályai.
- `docs/MIYAKO_VN_REVIEW.md`, `docs/MIYAKO_TEA_WARDROBE_REVIEW.md`, `docs/DIALOGUE_PORTRAITS_REVIEW.md` a meglévő megvalósítás leírására.
- `docs/FIRST_NIGHT_IMPLEMENTATION_REVIEW.md`, `docs/VILLAGE_DESTINATION_NAVIGATION_REVIEW.md` idő-, jelenet-, navigáció- és kaputényekre.
- `data/opening/miyako_first_dialogue.json`, a meglévő night/day/director, `vn_dialogue.gd`; új jelzőt csak ott adj hozzá, ahol feltétlen szükséges.

A forrásképek fájlnevei az átadási csomagban tudatosan megkülönböztethetők a Godot régi REVIEW állományaitól. Ne írj felül LOCKED döntést automatikusan; a nyitás és közvetlen irányítás változtatása friss tulajdonosi döntés.
