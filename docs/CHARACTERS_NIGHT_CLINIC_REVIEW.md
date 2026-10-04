# Karaktermenü és első éjszaka / rendelési nap — REVIEW

2026-10-04. Tulajdonosi kérés: karakterlapok, leírások, kapcsolati státusz, majd az előkészített első éjszaka és első rendelési nap. Inventory később; nem része ennek a változásnak. LOCKED döntések és karakterdizájnok változatlanok.

## Működés

Tab / Menü → Karakterek: Akira; Miyako személyes találkozás után; Hana, Kuroe és Shion névtelen megpillantott nőként, amíg ténylegesen nem mutatkoznak be. Portrék keret nélkül, jóváhagyott forrásokból. Kapcsolati státusz és események csak megtörtént flag/döntés alapján jelennek meg; a menü semmit nem módosít. Nincsenek új kapcsolatpontok, route-küszöbök vagy rejtett történeti spoilerek.

Benti Miyako-dialógus → jobbra E → Akira bejárható szobája. Íróasztal (x250–380) E: régi Akira–Katsuro fénykép szöveges technikai helye; csak nyugtázás után katsuro_first_clue_seen. Jobbra x>460 E: eredeti hárommondatos első éjszaka → második reggel Miyakóval → első rendelési attitűd-választás → rendelő. A fénykép opcionális; nincs mesterséges történeti kapu.

Rendelő középső sávja x240–390, E: első konzultáció; lezárás után ismét E: második konzultáció. Szöveg csak olvasói nyugtázásra lép, VN alatt mozgás zárolva, menü megállítja az időt. A két konzultáció után bejárható rendelőben maradunk; az egész esti/szabadidős ciklus még nincs megvalósítva.

## Forrás és történeti korlátok

Olvasott eredeti: Downloads/Tsukimori_RenPy_Prototype/game/Tsukimori/game/canonical_html_story.rpy, I. fejezet első éjszakája; II. fejezet 186–218 és válogatott 229–326 / 435–496; III. fejezet két első konzultációjának dialógusai. A konzultációk első narrátori sora rövid technikai összekötő adaptáció, nem új klinikai történet.

A másik chat („Emlékmentés folytatása”) friss emberi kérései: megírt pácienseket használjunk, figyeljünk az egész történetre; korai személyes Akira–Katsuro fénykép és napi rendelő/falu/este ciklus. A Chiasa/Sayo témáknak megfelelő eredeti III. fejezeti két páciens egyelőre névtelen marad. A Hana-első vs. eredeti sorrend tisztázása folyamatban. A galactorrhoeáról szóló Hana-jelenet pontos jóváhagyott szövege nincs meg a talált helyi forrásban; nem készült helyette kitalált vizsgálat. Későbbi látomásokat nem hoztunk előre.

Reggeli stay: aff_miyako +1, akira_gyogyulas +1; withdraw: flag_miyako_tavolsag. Első rendelési empathy: aff_hana +1, aff_shion +1, akira_gyogyulas +1; clinical: flag_klinikai_tavolsag. Eredeti döntéshatások, egyszeri alkalmazással; a pontok nem fedik fel a karaktereket.

Jelzők: visited_akira_room, katsuro_first_clue_seen, first_night_seen, miyako_morning_seen, first_clinic_day_started, first_day_consultation_1_seen, first_day_consultation_2_seen, first_clinic_day_seen. Új játék mindent töröl; játékállás-mentés nincs.

## Asset státusz és pontos hiányok

assets/home_day1/*.png: REVIEW / PLACEHOLDER, nem FINAL production jóváhagyás. 1672×941 képek nearest megjelenítéssel, járható lábsáv y272–280; szoba x85–535, rendelő x85–495. Bútorokon keresztüljárás megelőzve. A nappali meglévő járósávja változatlan.

Hiányzik: végleges rétegezett szoba/rendelő és teljes folyosó/váró topológia; Akira–Katsuro fénykép CG (nincs kitalált Katsuro-arc); ágyba fekvés/alvás animáció és éjszakai férfihang; két korai páciens production sprite/keret nélküli portré és jóváhagyott bemutatkozás; Hana eredeti klinikai szövege/sorrend; napközbeni szabad falu és esti továbblépés. A mostani páciensek szöveges VN-ben jelennek meg, nincs új karakterdizájn.

## Generálási adatok

Provider: OpenAI built-in imagegen. Mindhárom eredeti generált fájl megőrizve; a projekten belüli fájlok másolatok.

Akira szoba: image1 eredeti Ren'Py images/imported/rework/ch1_first_night_reworked.png; image2 assets/opening/reference/SHARED_HOME_CLINIC_INTERIOR_PIXEL_V1.png. Kimenet exec-28e29223-d543-404f-ab22-6bcd460d6b05.png → akira_room_REVIEW.png.

Prompt:

Use case: style-transfer / precise-object-edit. Create an EMPTY playable Akira bedroom background for the same Tsukimori Japanese wooden shared house. Image1 is original bedroom composition and architecture reference. Remove ALL people. Image2 is mandatory detailed cinematic pixel art rendering and shared-house material/lighting authority. Preserve moonlit rainy window left, dark wooden shoji walls, futon toward rear right, a modest bedside lamp, folded jacket and doctor's bag. Recompose with ALL bed/furniture behind a clear horizontal walkable floor strip across the lower-middle at 74-79% image height, x10-90%, unobstructed from left entry to right sleeping interaction; leave foreground floor empty, no bags or furniture across this strip. Add small writing desk at rear center with a closed modest photograph frame lying flat; no visible photographed faces, text, clues or invented character designs. Human-scaled lived-in quiet room, restrained blue moonlight and warm small lamp, readable dark details, crisp high-detail cinematic pixel art, not blurred, no retro coarse blocks. Wide16:9, no people, sprites, UI, labels, text or watermark. This is REVIEW environment extension only.

Rendelő: image1 eredeti Ren'Py images/imported/rework/office_reworked.png; image2 ugyanez a jóváhagyott shared-home referencia. Kimenet exec-779154d2-97c4-4bfc-b337-41acc183e9ee.png → clinic_REVIEW.png.

Prompt:

Create a detailed cinematic pixel-art EMPTY daytime medical consultation room in the same Japanese wooden Tsukimori shared home clinic wing. Image1 provides actual clinic architecture and furniture, image2 is pixel rendering/material style authority. Not a new house: left interior sliding door links to living area, a separate right rear entry links to public waiting area. Old dark wood, cream shoji, soft overcast morning window left, medical books and anonymous closed patient folders, anatomical wall charts WITHOUT readable text, two consultation chairs at rear middle, desk and compact covered examination couch at rear right, basic stethoscope/blood pressure cuff, practical discreet clinic not fantasy lab. Recompose every furniture item behind a CLEAR unobstructed horizontal floor strip at 74-80% frame height from x10% to90%, so player can walk in front of furnishings. No chair/table legs on this strip, no foreground clutter. Eye-level side-view playable 2.5D plate, human-scale, same crisp fine pixel-art treatment as image2, no blur, no coarse lowres blocks, calm morning colors, wide16:9. No people, bodies, sprites, UI, signs, labels, watermark. REVIEW room extension only; Katsuro private study is a DIFFERENT room, do not imply this is his personal study.

Reggel: az eredeti shared-home referencia fenti fájlja. Kimenet exec-14c7b778-dd05-4f02-a83b-4baf7884d39d.png → morning_REVIEW.png.

Prompt:

Edit this exact Tsukimori shared-home pixel background into overcast MORNING. Preserve composition, furniture, architecture, crisp fine pixel technique and clear floor. Soft cool daylight outside instead of night, dim lanterns, readable quiet warm wooden interior. No people, no new furniture, no text/UI. REVIEW daytime lighting variant, no redesign.

## Ellenőrzés

Godot 4.7.2 import és grafikus futás. character_journal_regression: megismerési határok, eredeti választás leképezés, csak olvasás, menü visszalépés. night_day_regression: mindkét reggeli és rendelési ág, egyszeri hatások, konzultációnkénti nyugtázás, lábsáv, minden szöveg illeszkedése. interior_regression: valódi E-belépés és E-lefekvés, Miyako melletti mindkét irányú átjárás. REVIEW screenshotok a review/ alatt. A környezet Windows root certificate store diagnosztikája ismert; nem játék-script hiba.
