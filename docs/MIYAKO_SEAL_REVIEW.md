# Miyako visszatérése · A pecsét — REVIEW, 2026-10-11

Shion konzultációjának végéről külön folytatásgomb indítja az V. fejezet hátralévő 32 szövegoldalát: Miyako visszatérése, a kazetta, a levél eredete, Katsuro hangja, a legyezős látomás és Akira jobb szemének teljes átváltozása. A szöveg az eredeti canonical_html_story.rpy fájlból származik, változatlanul, oldalakra tördelve. tools/build_seal_review.py csak szövegként olvassa a forrást. Új döntést vagy kapcsolati pontot nem ad. A VI. fejezet még nincs implementálva.

A történeti jelzők a vonatkozó mondatoknál keletkeznek; a lezárás csak a jelenet végén. Miyako meglévő átalakulási állapota megmarad. Akira anatómiai jobb szeme (a portré bal oldalán) zölddé válik a megfelelő sorban, és a karakterlapja ezt követi. A CG-k keret nélküli állóképek; a kazetta orsóinak önálló animációja és szinkronhangok nem készültek. A kő szétrepedését egyelőre a szöveg mutatja. Minden új asset REVIEW.

## Assetek / built-in ImageGen

- seal_cassette_REVIEW.png: clinic_REVIEW.png referencia, exec-0a06c0d9-b1c2-4d5c-a5f1-a3f060a00bf4.png; átlátszóság false.
- seal_fan_vision_REVIEW.png: új illusztráció, exec-f5d8ca87-6d9b-45be-bbee-c0f847d73848.png; átlátszóság false. Az arc takart, nem új névvel azonosított karakterdesign.
- akira_doctor_green_eye_v1_REVIEW.png: akira_doctor_v1_REVIEW.png szerkesztése, exec-3b6a803b-a6da-4ccf-9d6d-c8ade7f5affc.png; átlátszóság true.

## Pontos promptok

Landscape 16:9 story insert in the same crisp detailed illustrated pixel style and clinic architecture as reference. Close view of the wooden clinic desk. A vintage audio cassette lying loose outside any player, its exposed tape visibly dark emerald green, label handwritten exactly AKIRA — SHION. Beside it a flat narrow black stone fragment with five fine grooves at one end. Small water puddles on desk, closed windows, cool daylight and warm desk lamp. No people, no UI. Both objects centered in upper half, lower third clear for dialogue panel. Quiet supernatural mystery.

Landscape 16:9 supernatural visual novel story CG, crisp detailed Tsukimori illustrated pixel-art style. View across shallow black water beneath an ancient Japanese shrine in deep shadow. A distant adult human-shaped figure in a plain long white robe stands still on the far side, entire face concealed by an open black folding fan held at face height. No identifiable facial features, no other people. Subtle pale reflected light and dark wooden pillars. Quiet threatening stillness, no gore. Figure in upper middle with water filling bottom third reserved for dialogue. No text or UI.

Precise single-detail edit of this adult Akira VN doctor portrait. Change ONLY his anatomical RIGHT iris, which is the eye on the LEFT side of this image, into a clearly emerald green iris. The eye on the RIGHT side of the image remains its original brown color. Normal pupils, no glow. Preserve everything else exactly: face, expression, hair, white coat, body, pose, hands and full framing. Transparent alpha background. No crop, no text.

## Ellenőrzés

Godot teszt a teljes Shion→Miyako átmenetre, input-felengedési védelemre, szöveg és CG elrendezésre, az átalakult Miyako megőrzésére, eseményjelzőkre, szemkép/karakterlap egyezésre és új játék resetre.
