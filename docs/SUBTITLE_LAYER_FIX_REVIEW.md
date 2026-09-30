# Subtitle foreground occlusion fix — 2026-09-30

The owner's forest screenshot showed the lower half of the dialogue panel painted over by foreground foliage. Both belonged to the same CanvasLayer, but the foliage had positive Z; adding the dialogue later in tree order did not protect it.

Dialogue, headings, hints, speech bubbles and the skip dialog now belong to a dedicated HUD CanvasLayer (20), above the cinematic and weather canvas. World/foreground layering remains unchanged.

Validation: tests/opening/subtitle_layer_regression.tscn renders the reported late forest beat and gate approach, then verifies panel pixels at three bottom-edge positions with a solid test style. This catches occlusion that visibility/opacity checks miss. Both beats passed; normal runtime captures are review/subtitle_layer_5.png and subtitle_layer_6.png.
