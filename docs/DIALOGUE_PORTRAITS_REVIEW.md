# Dialogue portraits — 2026-10-04, REVIEW

Tulajdonosi kérés: Hana bal oldalon; Akira a párbeszédekben; dekoratív felnőtt páciensportrék; Hana és Miyako több képi reakcióval. LOCKED identitások nem változnak. A képek, a reakciók dramaturgiai időzítése és a VN-elrendezés REVIEW státuszúak, nem új design authorityk.

## Működés

Keret nélküli partner balra, Akira jobbra; az aktuális beszélő világosabb. A felirat és a választások a portrék felett maradnak. A portré nélküli éjszakai CG/megfigyelés továbbra is portré nélkül fut. Hana öt állapot: mosoly, zárkózott, szomorú, meglepett, megkönnyebbült. Miyako négy: semleges, meleg mosoly, aggodalom, meglepetés. A váltás szöveghez kötött, időzített automatikus lapozás nincs. Akira egy semleges figyelő portrét kapott; a karakterlapja is ezt használja.

A Hana-forrás eredeti smile/neutral/sad jelzése megmarad; három konkrét narrációs reakció és megnyugvási pont kiegészül REVIEW képi jelzéssel. A reprodukálható konfiguráció: tools/dialogue_portrait_staging.py, amelyet a Hana-extractor is használ. Szöveg, döntés, kapcsolatpont és state nem változott.

## Assetek és források

A assets/opening/vn_portraits mappában vannak az önálló, átlátszó PNG-k. Az eredeti jóváhagyott képek megmaradtak. Built-in imagegen; egy külön hívás minden új assethez. Az alábbi promptok pontosan a beküldött szövegek.

### assets/opening/vn_portraits/hana_sad_v1_REVIEW.png

Edit target: assets/opening/vn_portraits/hana_neutral_v1_REVIEW.png

Generated source: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-91645474-6a6b-4de3-8571-0381693966ee.png

Prompt:

> Use case: identity-preserve. Asset type: transparent VN portrait reaction. Image 1 is the edit target. Change ONLY the facial expression to quietly vulnerable and sad: brows drawn upward subtly, lowered gaze, lips slightly parted, no tears. Preserve EXACTLY the same adult woman's face identity, head position, hairstyle, ornament, outfit, anatomy, body pose, hands, lighting, framing, dimensions and detailed pixel illustration style. Maintain the same silhouette and alignment so the image can swap without jumping. One single character only, head through thighs, no board, no text, no frame, no shadow plane. Real transparent background with clean alpha edges. Do not redesign.

### assets/opening/vn_portraits/hana_surprised_v1_REVIEW.png

Edit target: assets/opening/vn_portraits/hana_neutral_v1_REVIEW.png

Generated source: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-ab8bf3c4-236d-46cc-9c5c-f1e8006fb7a6.png

Prompt:

> Use case: identity-preserve. Asset type: transparent VN portrait reaction. Image 1 is the edit target. Change ONLY the facial expression to surprised recognition: eyes slightly wider and lips gently parted, natural restrained adult emotion. Preserve EXACTLY the same adult woman's face identity, head position, hairstyle, ornament, outfit, anatomy, body pose, hands, lighting, framing, dimensions and detailed pixel illustration style. Maintain the same silhouette and alignment so the image can swap without jumping. One single character only, head through thighs, no board, no text, no frame, no shadow plane. Real transparent background with clean alpha edges. Do not redesign.

### assets/opening/vn_portraits/hana_warm_v1_REVIEW.png

Edit target: assets/opening/vn_portraits/hana_neutral_v1_REVIEW.png

Generated source: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-7082f94a-c7b6-4f6a-b8aa-ce20395f3643.png

Prompt:

> Use case: identity-preserve. Asset type: transparent VN portrait reaction. Image 1 is the edit target. Change ONLY the facial expression to relieved warm smile with soft eyes and relaxed eyebrows, quietly trusting. Preserve EXACTLY the same adult woman's face identity, head position, hairstyle, ornament, outfit, anatomy, body pose, hands, lighting, framing, dimensions and detailed pixel illustration style. Maintain the same silhouette and alignment so the image can swap without jumping. One single character only, head through thighs, no board, no text, no frame, no shadow plane. Real transparent background with clean alpha edges. Do not redesign.

### assets/opening/vn_portraits/miyako_warm_v1_REVIEW.png

Edit target: assets/opening/vn_portraits/miyako_cutout_v1_REVIEW.png

Generated source: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-777816c1-8a60-4289-b6e6-cd4c83d77b9e.png

Prompt:

> Use case: identity-preserve. Asset type: transparent VN portrait reaction. Image 1 is the edit target. Change ONLY the facial expression to small knowing warm smile, softened eyes, restrained mature expression. Preserve EXACTLY the same adult woman's face identity, head position, hairstyle, ornament, outfit, anatomy, body pose, hands, lighting, framing, dimensions and detailed pixel illustration style. Maintain the same silhouette and alignment so the image can swap without jumping. One single character only, head through thighs, no board, no text, no frame, no shadow plane. Real transparent background with clean alpha edges. Do not redesign.

### assets/opening/vn_portraits/miyako_worried_v1_REVIEW.png

Edit target: assets/opening/vn_portraits/miyako_cutout_v1_REVIEW.png

Generated source: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-da552feb-51f6-49b4-a8a1-15c793f05993.png

Prompt:

> Use case: identity-preserve. Asset type: transparent VN portrait reaction. Image 1 is the edit target. Change ONLY the facial expression to concerned guarded expression, slightly knit eyebrows and serious closed lips. Preserve EXACTLY the same adult woman's face identity, head position, hairstyle, ornament, outfit, anatomy, body pose, hands, lighting, framing, dimensions and detailed pixel illustration style. Maintain the same silhouette and alignment so the image can swap without jumping. One single character only, head through thighs, no board, no text, no frame, no shadow plane. Real transparent background with clean alpha edges. Do not redesign.

### assets/opening/vn_portraits/miyako_surprised_v1_REVIEW.png

Edit target: assets/opening/vn_portraits/miyako_cutout_v1_REVIEW.png

Generated source: C:\Users\likop\.codex\generated_images\01a0de06-53bf-7c60-8a17-b76aceffe7c1\exec-98e7978a-92e9-405e-8222-bbc9701bad76.png

Prompt:

> Use case: identity-preserve. Asset type: transparent VN portrait reaction. Image 1 is the edit target. Change ONLY the facial expression to subtle surprised realization, gently widened eyes and slightly parted lips. Preserve EXACTLY the same adult woman's face identity, head position, hairstyle, ornament, outfit, anatomy, body pose, hands, lighting, framing, dimensions and detailed pixel illustration style. Maintain the same silhouette and alignment so the image can swap without jumping. One single character only, head through thighs, no board, no text, no frame, no shadow plane. Real transparent background with clean alpha edges. Do not redesign.

### assets/opening/vn_portraits/akira_neutral_v1_REVIEW.png

Identity: assets/opening/reference/AKIRA_FINAL_CHARACTER_DESIGN_V1.png. Style reference: assets/opening/vn_portraits/hana_neutral_v1_REVIEW.png.

Generated source: C:/Users/likop/.codex/generated_images/01a0de06-53bf-7c60-8a17-b76aceffe7c1/exec-ca41d4d8-b28f-47e9-9d02-96feb9969c75.png

Prompt:

> Use case: identity-preserve. Asset type: transparent VN dialogue portrait of Akira, adult Japanese man age 32. Image 1 is approved identity and clothing reference; image 2 is ONLY rendering style/framing reference, do not copy the woman. Preserve Akira's distinctive tousled black hair, mature handsome face, brown eyes, slim adult build, dark charcoal zip hoodie jacket with grey undershirt, dark trousers. Create ONE clean head-through-upper-thigh portrait, three-quarter frontal body facing slightly toward viewer's left, neutral attentive expression, relaxed arms, hands natural. Match detailed crisp pixel illustration style of reference 2, visible intentional pixel clusters, no blur or painterly gradients. Tall 2:3 portrait with consistent margins, head wholly visible, no text, no frame, no extra characters. Actual transparent background, isolated character, no ground shadow.

### Páciens 1 és 2 — eredeti prototípusból

Forrás: C:/Users/likop/Downloads/Tsukimori_RenPy_Prototype/game/Tsukimori/game/images/imported/sprites/elso_paciens_custom és masodik_paciens_custom. Byte-identikus másolatok: patient_1_{neutral,sad,surprised,warm_smile,thoughtful,smile}_v1_REVIEW.png és patient_2_{neutral,sad,surprised,warm_smile,thoughtful,smile}_v1_REVIEW.png. Nem generáltunk új identitást vagy nevet. Az első páciens felnőtt férjes asszony, a második fiatalabb felnőtt; visszafogott kimonójuk és eredeti megjelenésük megmarad. A 512×512-es képek átlátszó margóit Godot AtlasTexture vágja meg kizárólag megjelenítéskor. A fájlok módosítatlanok.

## Ellenőrzés és hiányok

Godot import, Hana négy eredeti döntésága, éjszaka–első nap mindkét ága, konzultációk, szöveg és továbbgomb elkülönítése, szünet és karakterlap. Képi ellenőrzés: Hana balra/Akira jobbra, külön páciensportrék, átlátszó hátterek. Következő assetmunka: végleges production pixel-export és arckifejezés-illesztés; Akira további reakciói. A prototípusportrék és az új cutoutok REVIEW assetek, a végleges pixel stílusjóváhagyás hátravan. Klinikai szöveg/sorrend korábbi hiánya változatlan.

