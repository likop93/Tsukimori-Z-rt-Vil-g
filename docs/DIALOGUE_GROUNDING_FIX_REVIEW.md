# Dialogue and grounding correction — 2026-09-30

The natural intro handoff had left dialogue.modulate.a at zero. finish_intro now restores dialogue and narration opacity for both natural completion and skip. Regression checks verify actual visibility/opacity during Miyako's line rather than checking text content alone.

Miyako is now a foot-anchored world actor under the same Y-sorted cast as Akira. Each of the four existing atlas poses has its opaque foot contact measured and aligned at (352,274), with a contact shadow and foot collision. No artwork or character design was changed. Her visibility and collision are limited to the house.

The street's walk limits use surveyed road edges with scaled sprite clearance. Bridge contact points sit farther inside the deck. The house's source-aligned foreground fence/posts now occlude the cast; the forecourt lane remains behind them. Existing bridge occlusion remains.

Validation:
- Full gate_flow regression passed: natural intro, eight skip positions, visible post-intro dialogue, bridge/house progression and Miyako interaction.
- Grounding regression passed: street edges, all Miyako pose pivots, movement collision, house foreground, house-only visibility and bridge traversal positions.
- Inspected runtime captures at street edges, bridge posts, house posts and the greeting. Captures: review/grounding_*.png and review/miyako_after_exploration_REVIEW.png.
- Environment certificate-store diagnostic remains unrelated to rendering; art remains REVIEW.

