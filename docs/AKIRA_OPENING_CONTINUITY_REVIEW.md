# Akira nyitó képi folytonosság — 2026-10-04 REVIEW

A tulajdonos észrevétele alapján a monológ első buszos képe eltért az emlékkép Akirájától. A korábbi 640x360 forrás túl durva pixelrajza, eltérő hajtömege és arcaránya miatt a vágás két külön karakter benyomását adta.

Cserélt asset: assets/opening/shot_review_v2/bus_cabin_REVIEW.png. Az új részletes 1672x941 CG a jóváhagyott AKIRA_FINAL_CHARACTER_DESIGN_V1 és a memory_warm_REVIEW képből tartja az arcot, hajformát és rétegzett ruhát. A buszos ülő póz, saját kéz az állnál, hideg esti fény és esős ablak megmarad. A meleg emlékkép változatlan; idővonal, monológ és kontrollátadás változatlan. Nearest szűrés marad, a forrás részletessége nőtt.

Státusz: REVIEW, nem új character design vagy FINAL production jóváhagyás. Provider: built-in image_gen, image edit, transparent_background=false. Forrásképek sorrendben: bus_cabin_REVIEW.png (előző verzió a Git-történetben), cinematic_v2/memory_warm_REVIEW.png, reference/AKIRA_FINAL_CHARACTER_DESIGN_V1.png.

## Pontos prompt

Use case: identity-preserve. Edit image 1, the opening bus monologue shot. Image 2 is the subsequent memory shot and provides the matching face and detailed cinematic rendering. Image 3 is the LOCKED Akira character design authority. Recreate image 1 as a consistent detailed cinematic pixel-art 16:9 game CG. Preserve its seated composition: adult Dr Akira on the left in three-quarter profile facing right toward the rainy bus window, thoughtful tired controlled expression, own hand near mouth/chin, blue upholstered bus seats, cold blue night and orange distant streetlights through wet glass on right. Correct ONLY the visual continuity and rendering detail: he must visibly be the SAME adult man as image 2 and image 3, same narrow mature jaw, dark brown grey eyes with restrained adult size, same black layered tousled hair and fringe silhouette, same charcoal jacket over grey hoodie and pale grey shirt. Match image 2's fine crisp detailed pixel-art/anime CG treatment, edge definition, line quality and body proportions; avoid coarse low-resolution blocks or enlarged youthful eyes. Keep subdued blue bus lighting distinct from warm memory lighting. Natural anatomically coherent hand. Fully opaque landscape 16:9, detailed high-resolution source, no text, UI, borders, labels or other characters. Do not change the memory scene or character design. Do not show reference boards.

## Ellenőrzés

Godot import és tests/opening/cinematic_input_regression.tscn: a buszos képkocka, emlékbe váltás, monológ ütemezés, Space és skip útvonal. Grafikus rögzítés: review/cinematic_v2_bus_katsuro.png. A környezeti certificate-store és tesztkilépési ObjectDB diagnosztika ismert; nem production script-hiba.
