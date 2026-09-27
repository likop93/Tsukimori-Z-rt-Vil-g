# NPC individual regeneration — REVIEW
Four separate built-in image_gen requests, each tied to its approved source board.
Files: resident_01_REVIEW.png, resident_02_REVIEW.png, resident_03_REVIEW.png, resident_04_REVIEW.png.
1. Rust-kimono adult resident — V2 animation example.
2. Cream/floral-kimono adult resident — V1 adult women, first design.
3. Grey-haired elderly woman — V1 elderly population.
4. Apron-wearing shop worker — V1 workers, first design.

Each is a 1536x1024 RGBA PNG with eight proposed idle/look/walk poses.
Alpha checked at corner and inter-cell gap: zero on all four.
Full prompts, references and validation are in generation_manifest.json.

Visual sources approved by the owner with “tökéletes, folytassuk”.
Engine-normalized versions are now in ../generated/npc_v2; integration remains REVIEW.
Remaining: consistent normal-adult proportions review (elderly image still abbreviated), both look directions, truly distinct opposite walk contacts, fixed per-frame foot registration and game-scale pixel cleanup.
The raw originals remain unchanged. Runtime now consumes the separately packed, verified atlases.
No external provider order or spend was made; built-in image generation was used.
