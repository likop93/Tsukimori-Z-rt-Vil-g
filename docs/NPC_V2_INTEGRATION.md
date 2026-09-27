# Individual NPC integration — 2026-09-27
Status: owner-approved visual sources; engine integration REVIEW.

## Result
All four individually generated and owner-approved women replace the old crowd-board cutouts in Village Street.
No new images or designs were generated in this integration pass.

Each source is preserved at 1536x1024 with its original prompt/provenance.
tools/opening/pack_npc_sheets.gd creates one 256x192 RGBA atlas per actor, containing eight 64x96 cells.
Source alpha contained faint outside residue and near-opaque interiors; packing uses alpha >= 0.5, retaining source RGB, and fixed nearest scaling per actor.
Every pose is placed at foot pivot (32,94), transparent margins intact; no dark-clothing color key.
Character heights: 66 / 68 / 61 / 65 pixels. This uses the user's approved silhouettes without redrawing proportions.

## Runtime
scripts/opening/resident.gd is separate from Akira's unchanged placeholder controller.
- Idle: frames 0 and 1, restrained held timing.
- Look: designated source look pose; movement pauses for 2.2 seconds.
- Walk: frames 4–7 advanced by distance travelled, rather than an unrelated global timer.
- Patrol: hard-clamped to each resident's home range.
- Left walk mirrors the right-facing sheet. First/third left looks also use a mirrored pose because their generated source repeats right-facing looks.
- Bottom-center feet remain stable across every frame; shadows remain anchored.
- No body warping or new poses were fabricated.

## Verification
Godot 4.7.2, OpenGL Compatibility, RTX 4070 SUPER.
review/npc-integration.log: all 50 assertions passed, no parse/runtime errors or warnings.
Includes original intro/skip/movement checks, unique textures, eight registered transparent poses for all four residents, stop-on-look, patrol limits, and all four actual gait frames for both walking residents.
review/npc_v2_integrated.png: GPU-rendered in-world capture.
scenes/dev/npc_animation_review.tscn is a direct F6 review entry; it skips intro only in that development session. F5 continues to run the normal 96.5-second opening.

## Remaining
The sheet has limited source phase variation and left-facing mirroring; production foot-lock and transition polish remain.
Akira's real pixel walk/idle set remains the next character asset gap.
Clean background depth layers and standalone opening CGs remain on the original milestone asset list.
The owner's “tökéletes” approves these visual sources; it does not silently mark every engine animation FINAL.
