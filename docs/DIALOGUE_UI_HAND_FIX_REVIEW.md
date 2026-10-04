# Dialogue polish and Hana hand correction — REVIEW

2026-10-04. User identified the doorway CG, not the couch CG. Original preserved.

## Asset

- Source: `assets/home_day2/hana_door_v1_REVIEW.png`
- Replacement: `assets/home_day2/hana_door_v2_REVIEW.png`
- Provider: built-in ImageGen edit. REVIEW, not a new locked design.
- Change: coherent wrist and doorknob grip; character identity and staging retained.

### Exact prompt

Use case: precise-object-edit. Edit target: supplied Hana clinic doorway illustration. Correct ONLY the visible hand gripping the brass round doorknob at bottom left and its wrist connection. Draw one anatomically plausible hand: thumb opposing four naturally curled fingers around the knob, coherent knuckles and finger overlap, natural wrist emerging from the existing sleeve. The knob must remain visibly round brass and the grip physically convincing. Preserve Hana's exact face, hair, gold ornaments, kimono, pose, silhouette, scene composition, clinic furnishings, lighting, colors and illustration style. Do not redesign the character, add text, crop or change the camera. Keep the original wide landscape framing.

## Dialogue UI

Reference: `assets/opening/reference/TSUKIMORI_PIXEL_DIALOGUE_UI_V1.png`.
Native scalable frame with ink/plum surface, rose outline, brass corner inlays,
small blossom on nameplate, subtle footer divider and matching buttons.
Keyboard focus remains visible. Existing text area, portrait staging and CG caption
geometry retained. No narrative or state changes.

## Verification

Godot import, Hana's four choice combinations and first-night/first-day branches passed.
Regression checks include text bounds, button clearance, portrait placement and state.
Captured in `review/cg_hana_door_v2_REVIEW.png` and Hana/patient review screenshots.
Environment still reports the pre-existing Windows certificate-store diagnostic;
night/day shutdown also reports two leaked ObjectDB instances.
