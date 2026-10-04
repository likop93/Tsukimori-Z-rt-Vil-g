# Rendelői Akira, VN-tájolás és Hana jelenetképei — REVIEW

2026-10-04, tulajdonosi kérés alapján. Az érkezési Akira-ruha megmarad az érkezés és otthoni beszélgetések alatt; a rendelőben és Hana terápiás jelenetében külön orvosi köpenyes változat jelenik meg. Arc, haj, életkor, testarány és kontrollált személyiség nem változik. Az orvosi outfit a kért rendelői variáns, nem az elsődleges design lecserélése; nem rögzítünk új szakirányt.

## Beszélgetés rendezése

Partner balra, Akira jobbra; a portrékat a forrásképek nézési iránya alapján egymás felé fordítjuk. A portréfájlok eredetiek: a tükrözés csak a Godot TextureRect flip_h megjelenítési tulajdonsága. Az aszimmetrikus dísz a képernyős staging miatt tükröződhet; ez nem új karakter-design authority. A source-facing és a helyzet külön konfigurálható. A páciensek átlátszó margóját továbbra is AtlasTexture vágja; kisebb, alacsonyabban ülő keretük közös alsó baseline-on illeszkedik a doktorhoz. Nem változik a nevük vagy a történetük.

Az első két páciens és Hana az akira_doctor_v1_REVIEW.png portrét kapja. Akira karakterlapja az első rendelési nap megkezdése után az orvosi képet mutatja. A kijelzőn mindkét partner keret nélkül áll, aktuális beszélő hangsúllyal.

## Hana öt történeti képe

| Szöveghez kötött pillanat | Kép | Visszatérés |
| --- | --- | --- |
| Hana leül a heverőre | hana_couch_v1_REVIEW | Miyako mit mondott rólam? |
| Az ajtóhoz indul és megtorpan | hana_door_v1_REVIEW | Hana visszaül |
| Megmutatja a kulcscsont alatti ötágú jelet | hana_mark_v1_REVIEW | Mióta van ott? |
| A füzet lapján megjelenik az AKIRA név | hana_notebook_v1_REVIEW | Hana feláll és a hegre szorítja tenyerét |
| Kerti elköszönés, visszapillantás | hana_farewell_v2_REVIEW | Fejezetlezárás |

Teljes jelenetképek, nem a korábbi cutoutok a változatlan háttérre rakva. CG alatt a két portré elrejtőzik. A felirat a CG-nél lejjebb, külön kezelőgombsorral jelenik meg; a hosszú szövegek továbbra is az eredeti oldaltöréseket használják. A füzet képe enyhén közelítve, alulhoz igazítva látszik, hogy az AKIRA név a felirat fölött maradjon. A kezelő és az idővonal ugyanaz: kézi lapozás, szünet, eredeti döntések. Sem új szöveg, sem kapcsolatpont, sem route nincs hozzáadva.

A névtelen régi barátnő nem kapott kitalált arcot. A heg képi megvalósítása az eredeti szöveg öt vékony, egy pontból induló legyezővonalának REVIEW adaptációja, nem új történeti lock. A kerti v1 első iteráció megmarad forrásként; a játék v2-t használja, ahol Hana a rendelő felé pillant vissza.

## Generálási napló

Built-in OpenAI imagegen, imagegen skill. Eredeti generált fájlok megőrizve, projektben külön verziózott másolatok. Minden új kép és rendezés REVIEW, production pixel-export/jóváhagyás még hátravan. A heverős kép végleges kísérlete deréktól fölfelé mutatja a szakmai beszélgetést; a korábbi sikertelen kísérlet nem került a játékba. A karaktereket az approved cutoutok, a rendelőt assets/home_day1/clinic_REVIEW.png határozza meg.

### assets/opening/vn_portraits/akira_doctor_v1_REVIEW.png

Forrás: assets/opening/vn_portraits/akira_neutral_v1_REVIEW.png

Eredeti kimenet: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-cf3338ba-5202-452e-9fcb-0050e5290a77.png

Pontos prompt:

> Use case: identity-preserve. Asset type: transparent Tsukimori clinic VN portrait, medical work outfit variant. Image 1 is edit target, adult Dr Akira age32. Preserve EXACT face, tousled black hair, brown grey eyes, mature slim adult proportions, head and body pose, framing, scale, lighting and detailed crisp illustration style. Change ONLY clothing for his clinic work: replace black outdoor hoodie/jacket and shoulder bag strap with a plain clean off-white open knee-length doctor's coat over the same light grey shirt and dark trousers. Retain simple wristwatch. No stethoscope, badges, logos, instruments or specialty markers. Quiet professional attentive expression remains identical. Three-quarter facing viewer LEFT for RIGHT side of dialogue. Single character from head through upper thighs, fully visible head, tall2:3 framing, isolated with ACTUAL transparent alpha background, no room, floor, border, text, no redesign. Clothing variant of approved Akira, REVIEW.

### assets/home_day2/hana_door_v1_REVIEW.png

Forrás: Hana approved cutout + clinic_REVIEW.png (notebook: only clinic reference)

Eredeti kimenet: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-114e1a6e-6b73-40f6-85ad-733e2479a4a2.png

Pontos prompt:

> Asset type: one 16:9 full-screen visual novel story CG, detailed crisp Tsukimori pixel illustration consistent with input artwork, intentional sharp clusters, no blurred photo treatment. Image 1 is adult Hana identity/outfit authority, age33: warm tan skin, long dense wavy dark brown hair, reddish-brown eyes, gold floral hair ornament, same black burgundy gold floral kimono and curvy adult body. Do not redesign, whiten skin, change outfit or add new named characters. Image 2 is clinic architecture/material/light reference. No UI, subtitles, borders, collage, watermark. Keep the narrative subject in upper two-thirds; bottom third can be covered by dialogue. Scene: Hana has stood up and stopped at the clinic door, adult woman on LEFT side of frame, hand resting on a bronze door handle, three-quarter back view with face turned toward RIGHT where doctor is offscreen. Her confidence has faded into guarded exhaustion. Wooden door, shoji daylight, familiar bookshelves beyond. Medium close composition, restrained psychological tension, no doctor or extra person in image.

### assets/home_day2/hana_mark_v1_REVIEW.png

Forrás: Hana approved cutout + clinic_REVIEW.png (notebook: only clinic reference)

Eredeti kimenet: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-6e2bef8e-0d3e-45e5-b141-ed7b456fb03d.png

Pontos prompt:

> Asset type: one 16:9 full-screen visual novel story CG, detailed crisp Tsukimori pixel illustration consistent with input artwork, intentional sharp clusters, no blurred photo treatment. Image 1 is adult Hana identity/outfit authority, age33: warm tan skin, long dense wavy dark brown hair, reddish-brown eyes, gold floral hair ornament, same black burgundy gold floral kimono and curvy adult body. Do not redesign, whiten skin, change outfit or add new named characters. Image 2 is clinic architecture/material/light reference. No UI, subtitles, borders, collage, watermark. Keep the narrative subject in upper two-thirds; bottom third can be covered by dialogue. Scene: clinical non-erotic close-up of Hana's face, shoulder and collarbone as she gently draws only her kimono collar slightly aside with one hand to show a faint curved mark JUST BELOW collarbone: five thin pale curved lines branching from one point like ribs of a half-open fan. Face vulnerable and serious looking toward viewer RIGHT. All breasts fully covered by clothing, no nudity, no cleavage emphasis, no gore, no examination touch. Neutral professional story framing of old mysterious skin mark. Clinic bookshelf softly simplified but crisp behind.

### assets/home_day2/hana_notebook_v1_REVIEW.png

Forrás: Hana approved cutout + clinic_REVIEW.png (notebook: only clinic reference)

Eredeti kimenet: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-d448d53c-6590-491c-8b10-c07516ce8eef.png

Pontos prompt:

> Use case: illustration-story. Asset type: one wide16:9 full-screen VN story CG. Image1 is clinic architecture, lighting, wooden floor and drawing style authority. A close low camera on an old anonymous notebook that has fallen open onto the familiar wooden clinic floor. Damp pale pages slightly buckled, very thin cracks in paper around a single written name, subtle water-dark lettering. Text VERBATIM on page: "AKIRA" in clear uppercase hand-written letters, central upper half, easy to read. No other legible text. A faint shelf shadow and offscreen warm-tan adult woman's hand at distant edge allowed but not necessary. Air has grown cold, subdued blue daylight with residual warm amber light. Keep subject upper two-thirds away from dialogue bottom. Detailed crisp illustrated pixel-art texture, no blur, no character redesign, no UI, borders, watermark, no collage.

### assets/home_day2/hana_farewell_v1_REVIEW.png

Forrás: Hana approved cutout + clinic_REVIEW.png (notebook: only clinic reference)

Eredeti kimenet: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-78163eb0-24b2-484a-ac37-255998fd1ca4.png

Pontos prompt:

> Asset type: one 16:9 full-screen visual novel story CG, detailed crisp Tsukimori pixel illustration consistent with input artwork, intentional sharp clusters, no blurred photo treatment. Image 1 is adult Hana identity/outfit authority, age33: warm tan skin, long dense wavy dark brown hair, reddish-brown eyes, gold floral hair ornament, same black burgundy gold floral kimono and curvy adult body. Do not redesign, whiten skin, change outfit or add new named characters. Image 2 is clinic architecture/material/light reference. No UI, subtitles, borders, collage, watermark. Keep the narrative subject in upper two-thirds; bottom third can be covered by dialogue. Scene: adult Hana on LEFT foreground of a wooden clinic veranda just outside the open clinic doorway, beginning to leave along a garden path toward Japanese village, glancing back over shoulder toward viewer RIGHT, small tired but sincere smile. Same exact hair, ornament and outfit, modest neutral pose, daylight late afternoon, flowering garden, lantern and roof details consistent with Tsukimori. Wide medium shot, doctor's presence implied offscreen to right. No new character, no nudity or erotic framing. A quiet farewell after honest conversation.

### assets/home_day2/hana_couch_v1_REVIEW.png

Forrás: Hana VN cutout + Akira doctor cutout + clinic_REVIEW.png

Eredeti kimenet: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-e6e91858-9fb8-4df7-a75a-3fb5fb176aeb.png

Pontos prompt:

> Create one 16:9 full-screen story illustration of a calm professional consultation in Tsukimori's wooden clinic. Input1 identifies adult33 Hana, preserve her exact face, warm tan skin, long wavy brown hair, gold flower ornament and burgundy black floral kimono. Input2 identifies adult32 Akira, preserve exact black hair and face, grey shirt and white doctor coat. Input3 defines the clinic. Frame BOTH seated adults from WAIST UP: Hana sits on a couch at LEFT, Akira sits on a chair at RIGHT across a low table. They are turned toward each other and making eye contact, Hana smiling conversationally, Akira listening. Hands relaxed and resting naturally, personal space between them. Hana's kimono front is neatly arranged for a medical appointment. Daylight from shoji window, wooden bookshelves and medical wall charts. Detailed sharp illustrated pixel texture matching references, cohesive perspective and natural mature proportions, faces occupy upper half. No words, UI, borders or collage. One coherent scene, not pasted portrait assets.

### assets/home_day2/hana_farewell_v2_REVIEW.png

Forrás: assets/home_day2/hana_farewell_v1_REVIEW.png

Eredeti kimenet: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-0863745e-c167-4d67-b306-5e6d0d1fbf25.png

Pontos prompt:

> Use case: precise-object-edit / identity-preserve. Edit target: this existing Tsukimori adult Hana farewell story CG. Change ONLY Hana's HEAD ORIENTATION and eye gaze: her face turns back toward the RIGHT SIDE of the image, toward the open clinic interior on the right. Her nose should point to the right, visible three-quarter face, looking right toward the offscreen doctor. Keep her small sincere tired smile. Preserve exact adult identity, warm tan skin, reddishbrown eyes, brown wavy hair, gold ornament, body pose and position on LEFT of image, floral kimono, daylight, garden, clinic architecture and complete framing. No new person, text, UI or border. One coherent16:9 image. Do not mirror the whole image, only adjust face orientation so the conversation geography is correct.

## Ellenőrzés és következő munka

Hana mind a négy eredeti választáskombinációján öt külön CG, visszatérés a beszélgetési nézethez, nem duplázódó portrék, felirat/gomb elkülönítés és sorok teljes láthatósága. Első rendelési nap: két külön anonim páciens, befelé fordulás, közös alsó baseline, doktor-outfit; pontok és state megmarad. Fejezetválasztás, Miyako találkozás és karakterlapok regressziós ellenőrzése. A következő történeti blokk továbbra is a késő délutáni Miyako-jelenet; a mostani kör a kért vizuális javításokat valósítja meg.

