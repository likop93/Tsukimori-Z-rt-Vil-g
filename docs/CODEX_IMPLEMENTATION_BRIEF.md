# CODEX BRIEF — Tsukimori vertical slice

## Feladat
A repository technikai alapjának stabilizálása Godot 4.x alatt.

## Art/Design authority
A `docs/ART_DIRECTION_LOCK.md` és `docs/VERTICAL_SLICE_SCOPE.md`
dokumentumok elsőbbséget élveznek.

## Első technikai cél
A `scenes/world/mountain_path.tscn` hibamentesen induljon,
a Player WASD-vel mozogjon, a kamera kövesse, és a
VillageGateTrigger egyszer állítsa be:

`GameState.flags["entered_tsukimori"] = true`

## Korlát
NE implementálj még:
- combatot
- inventoryt
- route rendszert
- Black Kamuit
- dinamikus menüt
- komplex save/load rendszert

## Következő technikai review
1. scene parse / Godot startup hibák
2. player movement
3. collision
4. camera feel
5. trigger működés
6. project structure

## Refaktor-szabály
Ne írj történeti tartalmat közvetlenül player/world scriptbe.
A későbbi narratív rendszer adatvezérelt lesz.
