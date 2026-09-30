# Opening cinematic v2 — 2026-09-30 REVIEW

Replaces the presentation of the first short intro after owner feedback: the previous version omitted important monologue, reduced the memory to a tinted still, and Space sought the film clock, teleporting Akira.

## Implemented
- 70-second automatic film: black/rain 3s, bus/monologue 23s, memory 12s, return to bus 3s, disembark/departure 8s, forest 12s, gate 8s, handoff 1s.
- Restores the approved driver/return/Katsuro monologue from OPENING_PRE_CONTROL_SEQUENCE.md; no new identity, explanation for the abuse or story canon is invented.
- Memory shot sequence: warm cheek touch, gentle hand detail, matched cold reversal with Akira turning away, wrist restraint detail, tense face, deliberate black interruption. The same anonymous adult woman's identity stays concealed. A new bus close-up shows Akira holding his own wrist, connecting the memory to his present bodily reaction.
- New REVIEW images: assets/opening/cinematic_v2/. Exact prompts, references and provider are in generation_manifest.json; earlier assets remain intact.
- Moving bus-window droplets/light, camera push, sliding bus door, timed descent, departing bus, continuous forest-to-gate actor position, foreground foliage movement and two unidentified watching women reuse the approved resident atlases.
- Smaller cinematic subtitles leave Akira's feet visible. Gameplay dialogue restores its previous layout.
- Procedural REVIEW sound cues: warm tone, low dissonance, pulse, breath-like noise, door and footsteps. Rain/vehicle levels change with the memory and return. These are not recorded acting or final sound design.

## Input fix
Space/Enter only reveal or advance text. They cannot write beat_time, select another shot, teleport the actor, move the camera or replay a sound cue. The automatic film clock continues. ESC is the explicit full skip, still ending at the gate with only opening_intro_seen and entered_tsukimori. Text advancement never rewinds when the automatic schedule catches up.

## Validation
tests/opening/cinematic_input_regression.tscn checks repeated Space on all eight beats, no actor/camera/time/audio seek, forest/gate continuity, and explicit skip. Passed.
tests/opening/regression.tscn checks natural 70-second completion, all eight skip points, player-controlled route, grounded bridge, Miyako timing and preserved idle direction. Passed.
Rendered the actual F5 timeline at 24 FPS with Godot Movie Maker, including sound; 72-second review includes the first playable frames. Review captures: review/cinematic_v2_*.png.
Godot reports the environment certificate-store diagnostic and occasional exit-only ObjectDB warnings; no script parse/runtime failure occurred in these runs.

## Remaining production limits
The memory uses directed CG cuts and restrained shader/camera animation, not full hand-authored character animation. Door/body/walk and ambient layers are animated in-engine. Final facial/hand acting frames and recorded breath/voice remain missing, as do the previously documented front/back walk production sprites and Hana/Kuroe/Shion cameos. These gaps are not marked FINAL.
