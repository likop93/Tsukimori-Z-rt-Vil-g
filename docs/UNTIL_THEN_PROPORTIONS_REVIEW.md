# Village Street camera, proportions and movement — REVIEW

2026-09-27. The owner asked to bring the background framing, adult character proportions and walking feel closer to *Until Then*. This is a measured staging reference, not a change to Tsukimori's LOCKED identity, setting or character designs.

Reference inspected: the developer's [official game site](https://untilthengame.com/), especially `screenshot_6.jpg` (public station scene) for full-body camera scale and `screenshot_1.jpg` for human-to-door readability. Reference images are **not** distributed with this project. The goal is a comparable camera-to-person relationship, not reproduction of its art or setting.

## Playable implementation

- The camera uses integer 2× zoom on the existing 640×360 viewport and tracks horizontally through x272–640 at a fixed y268. Akira appears roughly 130–155 screen pixels high, about 36–43% of the frame. This is close to the hero scale in the cited official wide scene. Three adult residents are visible in the initial framing; the fourth enters during street traversal.
- The usable foot lane is y294–344. NPCs and Akira were moved onto it so their feet register against the stone street and nearby door thresholds. Only a restrained, uniform 0.93–1.06 depth scale changes with foot y; no body stretching. Actor sheets and approved identities remain the same.
- Walk starts at 260 world-pixels/s², reaches 56 world-pixels/s, and stops at 350 world-pixels/s². The four side/front/back phases still advance by *actual traveled distance*. Wall contact returns to idle. Left walk mirrors the right-walk sheet, while left idle now uses the correct dedicated left pose.
- The ambient phrase follows its speaker as the camera moves and sits above the sprite. The lower 48 pixels of the approved street image form a separate, source-aligned technical foreground band. The background receives a mild edge-preserving runtime cleanup to reduce single-pixel noise while keeping hard pixel boundaries.

## Asset boundary and next blocker

This pass reframes the existing `VILLAGE_STREET_PIXEL_V1`-derived REVIEW background. A purpose-painted close street background with architecture, distant village, wet lane and separate foreground layers at the new scale is still missing. The built-in image generator reported `usage_limit_reached` during this pass, so no new generated background was substituted. The present image retains denser painterly detail than *Until Then*; production pixel-cluster cleanup remains necessary. The approved Tsukimori village mood and all women-only NPC designs are preserved. The opening storyboard and state flags are unchanged.

Review image: `review/until_then_proportions_REVIEW.png`. Full intro: F5. Direct playable street: `scenes/dev/npc_animation_review.tscn` / F6. Current regression includes camera ratio, visible population, acceleration/deceleration, directional idle, boundaries, speech placement, intro handoff and skip state.

Validation on Godot 4.7.2 / Windows Compatibility renderer: 63 checks passed, no parse/runtime errors. `review/test_results.json` records the result; detailed local logs are excluded from the distributable archive. The generated animation source still has near-duplicate opposite contact poses, so animator cleanup of true alternating leg motion is the next character blocker.
