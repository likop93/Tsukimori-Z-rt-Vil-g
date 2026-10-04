# Első éjszaka és a bevezető lezárása — REVIEW

2026-10-04. Tulajdonosi kérés: az első éjszaka teljes jelenetfolyamának kidolgozása; utána következik az első nap. A LOCKED döntések és a karakterdizájnok változatlanok.

## Játszható folyamat

A meglévő Miyako-beszélgetés után Akira szobájába lépünk. Rövid jóéjt-párbeszéd, majd szabad mozgás. E: ablak megfigyelése, orvosi táska, régi Akira–Katsuro fénykép, lefekvés. Bal szélen E visszavisz a nappaliba; Miyako már visszavonult. A nappali jobb szélén E visszahoz a szobába. A szobai tárgyakat a helyzetfüggő alsó felirat jelöli.

A fénykép megtekintése lezáráskor rögzül. Ha előbb lefekszünk, a rövid fényképes emlék ott kerül elő, majd folytatódik a lefekvés. A kapcsolódó személyes nyom így nem marad ki, nincs kötelező keresgélés.

Lefekvéskor a járó sprite eltűnik. Elsötétedés után fekvő Akira képe, esős ablak részlete, sötét szobafal, majd Akira képe követi a nyugtázott narrációt. Idegen házneszek, szél, hajnal előtti bizonytalan férfihang; nincs azonosított beszélő vagy előrehozott természetfeletti magyarázat. A szöveg nem időzítőre lép.

Az éjszaka végén külön „A bevezető vége” képernyő jelenik meg. „Reggel · folytatás”, E, Space vagy Enter indítja a meglévő reggeli jelenetet. Az előző párbeszédből tartott gombot előbb el kell engedni. A menü a lefekvés átmenetét és az éjszakai jelenetet is szünetelteti.

## Forrás és adaptáció

Alaptörténet: Tsukimori_teljes_megirt_tortenet_2026-10-04.pdf, 3. oldal, első éjszaka. A ház idegen neszei, töredezett alvás és érthetetlen férfihang ebből származik. A PDF alapváltozat; a tulajdonos külön megírt bővítései és jóváhagyásai is irányadók.

A korai Akira–Katsuro fényképet az „Emlékmentés folytatása” beszélgetésben jóváhagyott személyes nyom alapján használjuk. A jóéjt, ablak, táska és fénykép rövid összekötő szövege REVIEW adaptáció. Nem vezet be új háttértörténetet.

Ez a dokumentum felülírja a CHARACTERS_NIGHT_CLINIC_REVIEW.md korábbi, hárommondatos éjszakára és automatikus reggelre vonatkozó megvalósítási leírását. A meglévő reggeli/rendelési választások és két konzultáció változatlanok; a következő napi teljes ciklus külön milestone.

## Állapot

Belépés: visited_akira_room, first_night_started.
Nyugtázások: miyako_goodnight_seen, night_window_seen, night_bag_seen, katsuro_first_clue_seen.
A hang narrációja: night_voice_noticed.
Éjszaka lezárása: first_night_seen, opening_prologue_complete.
Az éjszaka vége önmagában nem állítja be a first_clinic_day_started jelzőt. Új játék törli az állapotot. Komplex mentés, inventory, combat és új route-rendszer nincs.

## Assetek és pontos production hiányok

akira_sleep_REVIEW.png: új REVIEW / PLACEHOLDER alvási CG, jóváhagyott Akira és meglévő szoba alapján. A két szobarészlet az akira_room_REVIEW.png kivágása, nearest szűréssel; nem új helyszín. A világítás finoman változik, a képek nem csúsznak törtpixelen.

A fénykép egy feliratozott technikai papírlap; még nincs rajta az Akira–Katsuro fotó. Hiányzik a jóváhagyott közös fénykép CG és Katsuro arcreferenciája. Nem találtunk ki új arcot.

Az orvosi táska szöveges interakció, külön production prop nélkül. Hiányzik a végleges szobai tárgykészlet és a lefekvés animáció. A fa/szél/mormolás procedurális technikai hang; nem végleges hangfelvétel vagy érthető szinkron. A teljes folyosó, Miyako-szoba és Katsuro-dolgozó topológiája továbbra is külön feladat.

## Generálási napló

Provider: OpenAI built-in imagegen. Források:
- assets/home_day1/akira_room_REVIEW.png
- assets/opening/reference/AKIRA_FINAL_CHARACTER_DESIGN_V1.png

Eredeti kimenet megőrizve: C:/Users/likop/.codex/generated_images/01a0de06-53bf-7c60-8a17-b76aceffe7c1/exec-32a5b75d-c3e6-4549-94a1-c0b861cdfe1d.png. A projektes asset ennek másolata.

Pontos prompt:

Edit image1, the established Tsukimori bedroom, into a new nighttime cinematic bedside view. Use image2 strictly for approved adult Dr Akira identity: same black tousled hair, same mature 32-year-old face and slim build. He rests awake with eyes half-open on the established futon on the RIGHT of the room, under the existing blanket, wearing the plain grey undershirt already in his approved design, no jacket or shoes in bed. His expression is quietly tired and uneasy, no pose of panic. Medium wide horizontal composition, rain-blue window and dark shoji on the LEFT, wooden bedside lamp amber dim on right, unchanged room architecture, no other characters, no ghosts, no supernatural manifestations, no new symbols. Crisp fine cinematic PIXEL ART matching image1, restrained light, readable facial identity, not blurry or coarse retro pixels. Keep important face above upper two thirds, reserve bottom quarter for game dialogue but do not draw any UI. 16:9 no text/watermarks. REVIEW adaptation of first-night restless sleep, no character redesign.

## Ellenőrzés

Godot 4.7.2 grafikus futás: night_day_regression és interior_regression. Szoba/nappali oda-vissza, megfigyelések és fénykép nyugtázása, lefekvéskor sprite elrejtése, szüneteltetett áttűnés, külön lezárás, tartott input kizárása, valódi Space folytatás, mindkét reggeli/rendelési döntési ág és két konzultáció. A hosszabb narráció illeszkedik a szövegpanelbe.

REVIEW képek: review/night_room_REVIEW.png, night_photo_REVIEW.png, night_sleep_REVIEW.png, night_complete_REVIEW.png.
