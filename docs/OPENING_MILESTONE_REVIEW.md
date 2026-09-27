# Opening + first Village Street — implementation review
Date: 2026-09-27. Status: **TECHNICAL MILESTONE / REVIEW**, not FINAL art approval.

Update: the old board-cut NPC rows below are now retired from runtime.
The four owner-approved individual sheets are integrated with eight registered poses each.
Current NPC status and validation: [NPC_V2_INTEGRATION.md](NPC_V2_INTEGRATION.md).
The following original asset ledger is retained as the first-build record; its NPC placeholders are superseded.

## Scope and authority
Source: owner-specified GitHub main ZIP from https://github.com/likop93/Tsukimori-Z-rt-Vil-g, downloaded 2026-09-27. The archive has no commit history; do not mistake the local initialized Git repository for a fetched/mergeable clone. Origin points at the correct repository. No existing working copy or source file was overwritten.

Reviewed: DECISION_LOG, CREATIVE_BIBLE, ART_DIRECTION_LOCK, PIXEL_ART_PRODUCTION_DIRECTION, VISUAL_REFERENCE_INDEX, CODEX_IMPLEMENTATION_BRIEF, OPENING_PRE_CONTROL_SEQUENCE, FIRST_VILLAGE_10_15_MIN_FLOW, PLAYABLE_BACKGROUND_SCENE_MAPPING, STORY_CANON, CHARACTER_BIBLE, AKIRA_PRODUCTION_SPEC, VERTICAL_SLICE_SCOPE and the story rework/pacing documents. This implementation adds no creative lock and changes no governance decision.

The explicit first milestone covers Opening and Village Street only. Named cameos, bridge, house encounter and interiors from the broader 10–15 minute flow are deferred. Miyako and Himiko are absent. Courtesan source is retained and inspected for its separate inn visual language; inn workers are not substituted for street residents.

## What runs
- F5 starts scenes/opening/opening.tscn.
- 96.5-second automatic sequence: true black + rain/vehicle sound; bus monologue; arrival; watched windows; gate; street handoff.
- Story lines and timing live in data/opening/sequence.json, not Player/World.
- Gate fades into the already-running street in its final 2.5 seconds; input unlocks at the end of the following handoff hold. No actor respawn, scene reload or rain restart.
- Enter/Space reveals/advances narration. Esc requests confirmation on a first run. After opening_intro_seen is true in the current session, replay skip is immediate.
- All completion paths set opening_intro_seen and entered_tsukimori together, enable input once, preserve rain and stop vehicle sound. No save/load is implemented; flags are session-only.
- WASD/arrows: normalized movement, static collision boundaries, controlled camera. Lane x=112..734, y=309..376 in the 800x450 source composition. Background bridge, house steps and distant torii are inaccessible.
- Four anonymous women: adult resident, adult resident, elderly resident, shop worker. Idle holds, timed slow walks, proximity looks, three sourced optional one-liners; E observes nearby residents.
- 640x360 viewport, integer scale, nearest sampling, transform/vertex snapping, stable bottom-center pivot, contact shadows, y-sort, foreground cutout occlusion, mild depth drift and foreground parallax, rain/mist.
- Original 3D scenes/assets remain available as reference, not the startup scene. Their old camera validation is outside this new pixel build.

## Asset ledger / exact production gaps
All eight requested references are preserved byte-for-byte under assets/opening/reference. Their hashes and user ZIP origin are in source_hashes.json. No new character design or provider-generated asset was introduced. Rights provenance is the user-supplied project pack; no third-party license is asserted.

| Runtime asset | Status / source | Missing production work |
|---|---|---|
| actors_REVIEW.png, row 0 | PLACEHOLDER: primary Akira full-body front, side, back extracted with explicit silhouette masks; opposite side mirrored | AKIRA_WORLD_PIXEL_PRIMARY: hand-authored consistent pixel silhouette, 4 directions, idle, walk start/loop/stop, turn/look; fixed 48x80 frames or reviewed replacement specification. Current movement uses held directional poses and visibly slides; it is not a finished walk animation. |
| actors_REVIEW.png, row 1 | PLACEHOLDER: V2 anonymous adult animation example; two example walk poses + look | Coherent cycle with matched limbs, scale and foot registration; remove residual board background fringe. |
| actors_REVIEW.png, rows 2–4 | PLACEHOLDER: V1 adult / elderly / shop-worker full-body sprites, fixed bottom-center placement | Full-body source-clean transparent idle/look/walk sets. Some facing uses mirroring; held poses move without genuine foot animation. Board sprite proportions are more abbreviated than the normal-adult production target: this is an unresolved art-review gap, not a new approved proportion standard. |
| bus_REVIEW.png | PLACEHOLDER: storyboard panel rect 280,46,402,230 | OPENING_BUS_RAIN_PIXEL_V1, clean full-frame production CG and rain/window layers |
| arrival_REVIEW.png | PLACEHOLDER: storyboard rect 704,37,526,270 | TSUKIMORI_ARRIVAL_NIGHT_PIXEL_V1, independently painted depth/weather layers |
| watch_REVIEW.png | PLACEHOLDER: storyboard rect 13,431,491,166 | Dedicated anonymous window silhouettes, shoji motion and clean architecture layers; current figures are baked into the panel |
| gate_REVIEW.png | PLACEHOLDER: storyboard rect 960,412,330,168 | Matched gate-to-street production shot, without baked Akira, sharing world-sprite scale/pivot |
| street_REVIEW.png | APPROVED PLAYABLE BASE / REVIEW: supplied street, nearest resample to 800x450 | Hand-controlled pixel-density pass, not merely a downscaled illustration |
| foreground_REVIEW.png | REVIEW technical source cutout | Clean separated sky, mountains, far village, architecture, midground, lane, foreground and hidden surfaces. Present background still contains the foreground under the extracted overlay; mild parallax may expose duplication. Current sky/depth movement is a restrained UV approximation, not final layer production. |
| Narration UI | REVIEW: dark lower panel, restrained burgundy border, readable text from primary pixel dialogue reference | Production UI frame and font pass. No portrait conversation required for this milestone; full hybrid portrait system deferred. |
| Rain / vehicle audio | PLACEHOLDER: locally synthesized deterministic loops | Production rain, vehicle departure and subtle village ambience, mastered seamless loops |

The detailed technical crops/masks are in tools/opening/build_review_assets.gd. Frame size: 48x80; pivot: (24,80); image: 192x400. Row 0 directions: front / left / mirrored right / back. Row 1 columns: idle / walk A / walk B / look. Remaining rows: held poses with one mirrored direction. Source pixels are retained without inventing outfits or faces. Technical silhouette masks are not production-quality alpha extraction.

## Validation
Godot 4.7.2, Windows, OpenGL Compatibility, NVIDIA RTX 4070 SUPER.
Automated graphical regression: tests/opening/regression.tscn. Reports: review/test_results.json and review/regression-clean.log.
Checks: input lock, initial flags, intro duration, confirmation/cancel, natural final handoff, both flags, continuous rain, four residents, movement, camera follow, lane bounds, look reaction, idempotence, skip from every beat, replay skip, vehicle stop, idle and slow-walk states. Screenshots: review/intro_1.png through intro_4.png; review/village_start.png and village_right.png.
The full automatic opening is also launched through project.godot; review/play.log records the actual handoff.

Earlier sandbox runs exposed certificate-store and shader disk-cache access errors. The graphical verification and playable launch run in the ordinary Windows environment; disk shader cache is disabled in project.godot for this review build. The cache setting can be restored after deployment environment validation. review/.gdignore keeps local runtime profiles and screenshots out of Godot imports. No network is used by the game.

## Reproduce
Open project.godot in Godot 4.7.2 and press F5.
Run regression: godot --path . res://tests/opening/regression.tscn
Regenerate technical assets: godot --headless --path . --script tools/opening/build_review_assets.gd
Then import: godot --headless --path . --editor --import
The extraction tool is editor-side only; runtime loads the generated imported textures.

## Next blocker
The technical loop is reviewable. The next blocker for visual acceptance is production sprite/animation delivery (Akira first), followed by clean layered street and dedicated opening CGs. No asset has been promoted to FINAL. Combat, inventory, route system and complex save/load were not added.
