# Tsukimori continuity notes — 2026-09-27
This is an implementation memory aid, not a new creative authority.
Priority: current owner's explicit decisions, then repository governance. Read older chat statements as historical context and verify completion claims against files/tests.

## Relevant conversations checked
- **Emlékmentés folytatása** (6ab3ad32-bc14-83ed-ac5e-9f58b866a724): approved opening staging, women-only population, production pixel direction, correct repository main is Tsukimori-Z-rt-Vil-g. The initial document-sync blocker was resolved in this task.
- **Beszélgetés folytatása** (6ab38169-24d0-83ed-8adb-01293b123592): owner disliked disconnected full-screen VN presentation and prioritized animation/in-world coherence. Current pixel-hybrid UI lock is the later authority; do not reintroduce the old separate VN scene.
- **Javítsd a Tsukimori kamerát** (01a0c9ec-322e-73f2-b4eb-c381414eb2ff): stable movement/camera, then a legacy painterly master-scene attempt. Its older alternate remote and painterly direction do not supersede the current explicit remote/pixel lock.
- **Implement opening and village scene** (current task): first milestone scope is Opening + Village Street. Owner requested individual NPC regeneration and approved all four results with “tökéletes, folytassuk”.

## Continue from here
Working directory: opening-main-2026-09-27/Tsukimori-Z-rt-Vil-g-main.
Old worktrees/prototypes and sources/ are not replacement targets.
Four approved individual NPC source sheets: assets/opening/npc_review_v2/.
Their engine-packed atlases: assets/opening/generated/npc_v2/.
Current runtime NPC controller: scripts/opening/resident.gd.
F5: full opening. F6 on scenes/dev/npc_animation_review.tscn: direct NPC animation review.
Current proof: review/npc-integration.log and review/npc_v2_integrated.png.

## Preserved constraints
- No character or NPC redesign. Four anonymous women; named cast is not substituted.
- No physical early Himiko cameo; Miyako full reveal remains at the house.
- Background torii/bridge imagery does not rewrite map canon.
- Intro flags and skip remain state-safe; no complex save/load, route, combat or inventory.
- Pixel nearest, snapping, fixed feet, contact shadows and foreground remain active.
- User approval of source sheets is recorded; engine animation quality remains REVIEW until final in-game approval.
- Akira still needs a true primary-design pixel locomotion set.
- Source walk poses are not a complete directional production library: left walking uses mirroring, and some phase separation needs polish.
- Follow-up work should re-check relevant conversation decisions when available; these notes do not imply unattended monitoring.
