> Presentation superseded by [Cinematic v2](CINEMATIC_V2_REVIEW.md), 2026-09-30. Gate flow and movement notes below remain historical implementation context.

# Short opening and gate handoff — 2026-09-28 REVIEW

Synced the owner's latest “Emlékmentés folytatása” decisions and GitHub governance through 632e7d6, preserving the local movement corrections. The long automatic village-to-Miyako opening is no longer active.

The data-driven 60-second opening is black/rain (3s), bus monologue (16s), anonymous memory fragment (10s), getting off and bus departure (8s), forest walk (15s), gate approach (7s), handoff (1s). Bus reflections, departing vehicle, separate animated Akira, weather, a gate camera move and warm-to-cold temporal distortion animate the REVIEW plates. The memory uses fully clothed adults, a partly hidden identity and ambiguous wrist contact; no explicit abuse is shown. No heroine identity is assigned to the anonymous woman.

Natural completion and skip both grant control at Village Street and set only opening_intro_seen and entered_tsukimori. They do not set crossed_bridge or met_miyako. The village and bridge are player-controlled. At each route edge E continues to the next location. The bridge's short observation hold returns control; at the house, E near Miyako triggers her greeting. Akira still enters the house shot from the left. Women watch at street, bridge and house.

Movement fixes: source side idles were wired in reverse; the correct atlas order is front/left/back/right. Stopping now retains the last direction. An eight-exposure side-walk REVIEW atlas uses a fixed torso/foot registration and distance-based cadence corrected for displayed scale. Front/back cycles remain the existing four-pose REVIEW art. Bridge movement follows surveyed deck points instead of an arbitrary sine; source-aligned near-rail patches occlude the actor. Village movement stops before painted steps. House movement stays in the forecourt lane.

Generated asset files and exact final prompts are recorded in assets/opening/short_intro_v1/generation_manifest.json. Forest, bus and memory assets were created with the built-in image tool. All previous source boards and approved designs remain intact.

Still missing for production: fully authored continuous animation (including front/back), finished cinematic sound and breath cues, detailed trauma-memory variations, dedicated parallax layers, and the named Hana/Kuroe/Shion cameos. Those named characters have not been replaced with generic residents. The current playable route is a short technical slice rather than the complete 10–15-minute narrative flow. The next narrative milestone is those approved cameos and the interior; no route/combat/inventory/save system was added.

Validation entry: tests/opening/regression.tscn → gate_flow_regression.gd. Exercises the full natural opening, all seven skip points, gate state, lack of automatic walking, player-driven bridge/house progression, bridge grounding, Miyako timing and preserved idle direction. Runtime captures are review/short_intro_*.png and review/bridge_grounding_REVIEW.png.

Motion preview: review/akira_bridge_motion_REVIEW.gif is a 48-frame runtime capture (scenes/dev/motion_review.tscn). Side-walk art remains REVIEW; this does not certify final animation quality.
