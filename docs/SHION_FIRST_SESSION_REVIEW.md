# Shion első konzultációja — REVIEW, 2026-10-10

Az éjszakai látogató végéről külön gomb indítja a másnapi 10:00-s konzultációt. Közvetlen fejezetválasztás is elérhető. A teljes eredeti jelenet Shion búcsújáig elkészült: 136 fő szövegoldal, két döntési pont, mindkettő két eredeti ággal. A következő blokk Miyako visszatérése a kazettához és a pecsét története; ez még nincs implementálva.

Forrás: a tulajdonos `C:/Users/likop/Downloads/Tsukimori_RenPy_Prototype/game/Tsukimori/game/canonical_html_story.rpy`, V. fejezet. A tools/build_shion_review.py szövegként olvassa; nem futtatja és nem módosítja. Szöveg és döntések megtartva, oldalakra tördelve. A dallamhoz csatlakozás Shion +2 és Elmerülés +1; kivárás Gyógyulás +1. Kazetta sürgetése Elmerülés +2; beleegyezés kérése Shion +1, Gyógyulás +1. Egyszeri eseményjelzők védik az értékeket a duplázástól. Shion saját elutasítási horrorváltozata nincs kitalálva; a korábbi globális horrorállapot megmarad.

Shion keret nélküli, alakos semleges/szomorú/meglepett reakciókat kapott. Zöld szeme, fekete haja és visszafogott alakja megmarad. A jelenet a forrásszöveg és annak illusztrációi szerinti világos szürkezöld alkalmi kimonót használja REVIEW ruhaváltozatként; a karakterbiblia sötét primary outfitjét nem írja felül. Akira a párbeszédekben orvosi ruhában, jobbra áll; Shion balra, befelé fordulva. A forrásból átvett külön CG-k civil Akirát mutatnak és stiláris/öltözeti egyeztetésük még production-feladat; nem új végleges karakterreferenciák.

A karakterlap csak a bemutatkozáskor nyílik meg; a kazetta és a közös emlék külön eseménysornál kerül bele. Az éjszakai füzet kapott új önálló képet. A történeti CG-k alatt a két VN-portré rejtett.

## Assetek és források

- assets/home_day2/wet_notebook_v1_REVIEW.png: built-in ImageGen, clinic_REVIEW.png referencia; exec-c0749c1c-636b-4668-bf32-0443a315d26c.png.
- assets/opening/vn_portraits/shion_neutral_v1_REVIEW.png: a forrásprojekt images/imported/sprites/shion_custom_v2/shion_custom_v2_neutral.png képe alapján ImageGen. Első kiterjesztés exec-e0102d48-4b25-4290-a59d-beb485b7401e.png; rövid szegély javítása után végleges REVIEW exec-882dba6d-37b8-49d6-84d1-af377d2aaf88.png.
- shion_sad_v1_REVIEW.png: a fenti javított semleges képből exec-1cad55f7-9212-4fc1-9de9-6448af1a7f8d.png.
- shion_surprised_v1_REVIEW.png: ugyanabból exec-7bc3aaf5-88c5-4982-854b-b8cd35258cc2.png.
- shion_recognition_REVIEW.png, shion_childhood_REVIEW.png, shion_farewell_REVIEW.png: változatlan másolat a forrásprojekt images/imported/rework/{shion_eye_recognition_reworked,akira_childhood_memory_reworked,shion_farewell_office_reworked}.png fájljaiból.

## Ellenőrzés

Mind a négy választáskombináció végigfutott Godotban: eredeti pontértékek, egyszeri jutalom, szövegméret, CG/portré kizárás, befelé tájolás, karakterlap, reset. Fejezetválasztó, nyolc gomb elférése és az éjszakai átvezetés külön ellenőrizve. A korábbi kilépéskori ObjectDB figyelmeztetés egyes teszteknél továbbra is előfordul.

## Pontos ImageGen promptok

A portréhívások transparent_background=true; a füzeté false.

Nedves füzet:

Create a landscape 16:9 story insert for this clinic, matching its detailed crisp illustrated pixel-art style, at night. Low close view of an old plain open notebook lying on the wooden floor beside the bookcase, wet curled pages and small scattered drops leading toward a CLOSED window. Cool moonlight, faint warm lantern light. On one page a faint small handprint made of water, no readable text. No people. Keep notebook and trail in upper two thirds so a dialogue panel may cover the bottom. Ominous quiet atmosphere. Preserve the clinic architecture and materials from the reference. No UI or borders.

Shion kiterjesztés:

Extend this adult Shion visual novel character portrait into a standing head-to-knees cutout. Preserve exactly her face identity, slim adult build, green eyes, long black hair, green and gold floral ornament, and the same pale grey-green floral kimono and dark green obi as this scene-specific outfit. Calm reserved expression. Arms resting naturally with hands together. Same detailed illustrated style. Do not redesign her or create a close-up. Vertical 2:3 canvas with the entire head and both knees visible, body filling the frame. Transparent alpha background, no backdrop, no text.

Hosszú kimono javítás:

Single precise clothing correction to this adult Shion portrait: the kimono is a traditional long garment continuing down past the bottom edge of the image. Remove the short skirt hem and visible knees, extending the same pale grey-green floral fabric straight down over the legs. Keep identical face, green eyes, hair, hands, calm expression, pose, scale and framing. Transparent alpha background. No other changes.

Szomorú:

Expression-only edit of this adult Shion game portrait: quietly distressed and sorrowful, eyebrows raised inward, green eyes looking slightly down, mouth tense, no smile, a restrained tearful look but no streams of tears. Preserve exact face identity, green eyes, black hair, ornaments, long pale grey-green kimono, hands, body pose and full existing framing. Same illustration style. Transparent alpha background. No cropping, no redesign.

Meglepett:

Expression-only edit of this adult Shion game portrait: startled recognition, green eyes widened and fixed on someone, raised eyebrows, lips slightly parted as if whispering in disbelief. Quiet shock, not cartoon exaggeration. Preserve exact face identity, green eyes, black hair, ornaments, long pale grey-green kimono, hands, body pose and full existing framing. Same illustration style. Transparent alpha background. No cropping, no redesign.
