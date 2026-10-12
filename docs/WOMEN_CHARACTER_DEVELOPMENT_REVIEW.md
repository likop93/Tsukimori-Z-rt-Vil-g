# Hana, Shion és Kuroe — karakterkidolgozás, 2026-10-12
Státusz: OWNER REQUEST / REVIEW. Ez a kör három karakter megkülönböztetett fejlődési tervét, teljes alakos hétköznapi ruhaképét és kipróbálható dialógusmintáját készíti el.

## Elkészült
Főmenü → Karaktergaléria · tervek. Hana / Shion / Kuroe, alap és hétköznapi ruha, görgethető saját karakterív, Beszélgetéspróba. Mindhárom minta három választ ad; mind a kilenc ág lezárható. Escape visszalép a próbából, majd a főmenübe.
A galéria szándékosan spoileres fejlesztési nézet. Nem fejezet, nem folytatja a fő történetet, nem állít be találkozást, affinitást, horrorértéket vagy ruhafeloldást. A normál karakterlap továbbra is csak a már megismert szereplőket és megtörtént döntéseket mutatja.
Adatforrás: data/ui/character_development.json. ÚJ jelenetvázlatok, nem az eredeti Ren'Py szöveg átiratai.

## Három eltérő karakterív
### Hana
Magabiztos humor → saját kívánságok kimondása → kölcsönös bizalom. A közelsége aktív választás legyen. A nyugtalanító ágon az önálló döntések fokozatos feladása a fő kontraszt, nem a Miyako-féle birtokló mosoly.
Új normál hétköznapi kép: a megszokott telt alapalkat, álló magabiztos póz, bordó hímzett top és farmer. A korábban elfogadott karcsúbb, engedélyt kereső V2 külön késői átalakulási referencia marad.
A prototípus jelenlegi két személyes határhúzása már csak elbizonytalanodásig vezet. Egy döntés még nem cseréli ki a portrét. Késői teljes változáshoz felgyűlt személyes nyomás ÉS hana_transformation_revealed esemény szükséges. Jelenleg egyik történeti jelenet sem állítja be ezt a jelzőt.
Minta: rendelésen kívüli séta, ahol ő választ útvonalat. Következő fő történeti integráció: külön időpont, nyitás és lezárás megírása; nem automatikus ugrás a kezelésből intimitásba.

### Shion
Csend → saját kezdeményezés → a jelenben létrejövő kapcsolat, amely nem csak az örökölt emlékektől függ. Zöld szeme és sötét haja változatlan.
Ruhája: füstös lila blúz és hosszú, sötét, finoman hímzett szoknya. A kimonós alapdesign megmarad.
Nyugtalanító terv: elnyúló hallgatás, eltérően őrzött közös emlék, majd jóval később lehetetlen víztükör/ismétlődő mozdulat. Nem Miyako átfestése. Testi torzulás még nincs kijelölve és generálva.
Minta: a patak falusi oldalán arról kérdez, milyen zenét választ Akira MOST. A terápiás döntés vagy a kazettához kért beleegyezés nem kap automatikus elutasítási büntetést.
Karakterlap: a dallamra adott tényleges válasz és a kazetta előtti beleegyezés megjelenik, ha megtörtént.

### Kuroe
Művészi kíváncsiság → őszinte vélemény elfogadása → befejezetlen munka megmutatása → csak később lehetséges személyes vonzalom. Shion korábbi barátnője; identitása és az Akirához kapcsolódó kivételes, lassú fejlődés megmarad.
Ruhája: fekete felső/nyitott ing, szilvaszínű szabott nadrág, bokacsizma, ametiszt részletek.
Nyugtalanító terv: túl sokszor ismétlődő ütem, a beszélgetés ritmusának kontrollálása, később a mozdulatot megelőző hang. Nincs azonnali agresszió vagy új testi redesign.
Minta: későbbi közös próba, nem első találkozás és nem vallomás. A teljes eredeti első találkozás a Ren'Py miyako_ix_v2.rpy canonical_kuroe_sequence részében létezik; ezt e kör nem helyettesíti.

## Vizuális források és státusz
Az alap identitás authority: docs/CHARACTER_BIBLE.md, HANA_PRODUCTION_SPEC.md, SHION_PRODUCTION_SPEC.md, KUROE_PRODUCTION_SPEC.md. Hana késői karcsúbb iránya a tulajdonosi 2026-10-10 döntés szerint.
Új assetek assets/opening/vn_portraits alatt:
- hana_casual_confident_v1_REVIEW.png
- shion_casual_v1_REVIEW.png
- kuroe_casual_v1_REVIEW.png
Mindhárom teljes alakos, lábbelivel együtt, átlátszó PNG. A korábbi portraitok változatlanok. Ezek illusztrált VN REVIEW-források, nem FINAL pixel sprite-atlaszok.
Hiányzik még: hétköznapi ruhánként külön reakciósor, beszélgetés-CG, kézi production pixelpass és járóanimáció. Hana régi teltebb kimonós késői képe továbbra is ismert átmeneti asset; az elfogadott karcsúbb irányhoz igazítása külön feladat.
A távlati horrorágak új terveket tartalmaznak, nem LOCKED végjátékot.

## Pontos generálási promptok
Provider: beépített image_gen; mindhárom hívás transparent_background=true. Képszerkesztés vagy kivágás kóddal nem történt; az eredeti outputok megmaradtak.

### hana
Edit target: hana_neutral_v1_REVIEW.png; kizárólag ruha supporting reference: hana_casual_deferential_v2_REVIEW.png.
Eredeti output: exec-cf7418bb-1875-4dda-adec-4507550ca663.png.

> Identity-preserving everyday wardrobe edit for an adult visual novel character. First image is Hana's BASE identity and body authority: keep her mature face, warm tan skin, reddish brown eyes, long wavy brown hair and gold flower hair ornament, confident warm expression and established full adult silhouette. Second image is ONLY the outfit reference: burgundy feminine embroidered flutter-sleeve blouse with side tie and high-waisted cuffed denim shorts, brown belt. Dress BASE Hana in this outfit, do not copy the second image's slimmer transformed build or submissive pose. Relaxed upright confident standing pose, one hand resting naturally near a pocket, other at her side. Opaque everyday clothes with natural fit, no exaggerated anatomy. Keep the existing detailed VN illustration style. Full-body composition from hair to both shoes, simple brown sandals, comfortable blank margins, single character, transparent alpha background, no lettering or frame.

### shion
Edit target: shion_neutral_v1_REVIEW.png.
Eredeti output: exec-654d2ba7-f9d3-423d-9dfb-44c7a3fb9bca.png.

> Identity-preserving wardrobe edit of this mature adult Shion for the same illustrated visual novel. Preserve her exact delicate adult face, green eyes, long almost-black hair with subtle violet tones, green hair ornament and slim adult body proportions. Create her own understated everyday outfit: opaque muted smoky-lilac boat-neck blouse, softly draped three-quarter sleeves, tucked into a flowing charcoal ankle-length skirt with subtle botanical stitching, slim dark flat shoes. Collarbone visible but modest fully opaque coverage. Upright quiet standing pose, hands loosely resting together, small tentative warm smile, no submissive or childlike posing. Full-body from hair to both shoes with blank margins. Same detailed illustration technique. Transparent alpha background, no frame or text. Preserve her identity, no horror transformation.

### kuroe
Edit target: kuroe_neutral_v1_REVIEW.png.
Eredeti output: exec-7e023cf4-6088-4c5f-af34-ebc0563720a2.png.

> Identity-preserving wardrobe edit of the adult Kuroe reference for the same visual novel. Keep exact mature face, amethyst eyes, very long dark aubergine hair and black-violet floral bow ornament, original adult hourglass silhouette without changing proportions. New understated artist's everyday outfit: opaque black fitted square-neck top, deep plum high-waisted tailored wide-leg trousers, open lightweight black shirt with sleeves rolled to forearms, original small amethyst pendant and one restrained bronze chain at waist, black ankle boots. Relaxed confident standing pose, one hand loosely in trouser pocket, other at side. A subtle dry half-smile, cool intelligent gaze. Full body from hair to both boots with safe blank margins. Same detailed illustrated VN style. Transparent alpha background, no scene, frame or text. No horror distortion, no change in identity.
Az eredeti outputok mappája: C:/Users/likop/.codex/generated_images/01a0de06-53bf-7c60-8a17-b76aceffe7c1.

## Ellenőrzés
Godot 4.7.2 import; character_gallery_regression: három karakter, két ruha, kilenc ág, állapotváltoztatás kizárása, szövegméret, menübelépés és Escape. character_pressure_regression: Hana és Miyako korai/késői különbsége, karakterlap és reset. chapter_select_regression: korábbi fejezetválasztás.
A korábbi ObjectDB kilépési figyelmeztetés a pressure-teszt végén még előfordul; nem lett megoldottként állítva.

