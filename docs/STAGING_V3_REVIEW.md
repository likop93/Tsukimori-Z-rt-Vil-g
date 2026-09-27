# Village Street staging and Akira movement — REVIEW

2026-09-27. User reported a mismatch between the background, playable space, character proportions and Akira movement. This iteration is a review proposal, not a new LOCKED art decision. Original reference files and governance remain unchanged.

## Changed

- Derived a shallow lateral street from VILLAGE_STREET_PIXEL_V1. Ground, house thresholds and adult actor heights now share a legible gameplay scale. Logical environment is 800×450; player feet stay within x112–734, y322–376. House stairs remain inaccessible.
- Removed the old UV warp that bent the background. A separate lower ground strip supplies restrained foreground parallax without duplicating foreground objects. Proper independently painted distance layers remain missing.
- Kept all four approved NPC designs and their individual atlases. Moved the resident standing nearest the steps onto the same walkable lane.
- Replaced Akira's held reference cutouts with a 16-frame REVIEW atlas: four directional idle poses and four walking phases for side/front/back. Left walk mirrors right. Shared scale and fixed foot registration preserve his slim adult proportions without stretching. Approximately 71px tall versus resident maxima 61–68px.
- Speed is 48 logical pixels/second. A cycle covers 30 pixels of actual movement; pushing against a wall and releasing input return to idle. No synthetic vertical sprite bob.

## Assets and provenance

Assets and full generation prompts: `assets/opening/staging_v3/generation_manifest.json`. Built-in image_gen was used, referencing the approved street, Akira identity board and approved first resident style sheet. Initial Akira sheet is retained; corrected sheet is `akira_walk_REVIEW.png`. Native packing is reproducible with `tools/opening/pack_staging_v3.gd`; `packing.json` records frame dimensions and source hash. Unequal source row gutters are explicitly cropped to avoid cutting shoes. Original outputs remain preserved.

## Remaining production review

Latest graphical validation: 55 assertions passed; no parse/runtime errors in final regression and live-preview logs. Live screenshot: `review/staging_v3_integrated.png`.

The generated side cycle now alternates contact and passing silhouettes, but opposite-leg/arm separation is still imperfect. Front/back gait and idle-to-walk hand placement require animator cleanup; these are not final production animation. This proposed background needs owner visual review. Separate far architecture/sky layers and a purpose-painted foreground occluder remain missing. These review assets do not add map canon or replace the locked opening storyboard.

The intro, skip state, four NPC behaviors, camera and boundary regression run is supplemented with actual side-cycle playback, idle after stopping, wall stop, front/back gait and left-facing checks. See `review/staging-v3-test.log` and `review/test_results.json` for latest execution result. F5 remains the complete opening; `scenes/dev/npc_animation_review.tscn` opens the playable visual review directly.
