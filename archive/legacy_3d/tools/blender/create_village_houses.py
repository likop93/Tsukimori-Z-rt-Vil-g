"""Build three repeatable kominka-style village house GLBs with embedded color maps.

The Python source is the editable layout; generated GLBs can also be imported into
Blender for finishing. Run from anywhere with Python 3, no Blender dependency:
    python3 tools/blender/create_village_houses.py

Local origin matches a village house collider: Y=0 is 1.8 m above ground.
The entrance points toward local +X; Godot turns houses on the right bank 180°.
"""

from pathlib import Path

from glb_writer import write_glb


ROOT = Path(__file__).resolve().parents[2]
TEXTURES = ROOT / "assets/environment/materials"
DEST = ROOT / "assets/buildings/village"


def build_variant(variant: int) -> tuple[list[dict], list[dict]]:
    materials: list[dict] = []
    boxes: list[dict] = []

    def mat(name, rgb, texture=None, roughness=0.82, metallic=0.0, glow=None):
        spec = {"name": name, "rgb": rgb, "roughness": roughness,
                "metallic": metallic, "glow": glow}
        if texture:
            spec["texture"] = str(TEXTURES / (texture + ".png"))
        materials.append(spec)
        return name

    plaster = mat("Washed plaster", (0.72, 0.73, 0.71) if variant != 1 else (0.60, 0.67, 0.65), "aged_plaster")
    cedar = mat("Aged cedar framing", (0.68, 0.64, 0.60), "weathered_cedar")
    accent = mat("Dry warm timber", (0.79, 0.67, 0.57), "weathered_cedar")
    roof = mat("Slate ceramic courses", (0.61, 0.68, 0.75) if variant != 1 else (0.57, 0.66, 0.73), "slate_roof", roughness=0.54)
    tile_lip = mat("Glazed blue roof lip", (0.24, 0.30, 0.36), roughness=0.48)
    stone = mat("Stone sill and footing", (0.57, 0.58, 0.55), "wet_stone")
    paper = mat("Dim shoji paper", (0.69, 0.63, 0.52), "aged_plaster", glow=(0.065, 0.038, 0.018))
    doorway = mat("Deep doorway recess", (0.045, 0.043, 0.048), roughness=0.95)
    iron = mat("Aged ironwork", (0.11, 0.13, 0.14), roughness=0.52, metallic=0.34)

    def box(name, xyz, size, material, roll=0):
        boxes.append({"name": name, "location": xyz, "dimensions": size,
                      "material": material, "roll": roll})

    box("Plaster and clay wall mass", (0, 0, 0), (4.8, 3.6, 6.0), plaster)
    box("Raised stone foundation", (0, -1.66, 0), (4.98, 0.30, 6.16), stone)
    box("Dark lower wall band", (0, -1.38, 0), (4.88, 0.36, 6.07), cedar)

    for x in (-2.46, 2.46):
        for z in (-2.77, -1.03, 1.03, 2.77):
            box(f"Timber post {x} {z}", (x, 0, z), (0.13, 3.52, 0.15), cedar)
        for y in (-1.26, 1.22):
            box(f"Horizontal beam {x} {y}", (x, y, 0), (0.14, 0.16, 5.76), cedar)
    for z in (-3.04, 3.04):
        for y in (-1.22, 1.26):
            box(f"End beam {z} {y}", (0, y, z), (4.89, 0.14, 0.11), accent)

    def roof_pair(prefix, y, x_offset, panel_width, length, angle, rows):
        for side in (-1, 1):
            x = side * x_offset
            roll = -angle * side
            box(f"{prefix} sloped underlay {side}", (x, y - 0.14, 0),
                (panel_width + 0.06, 0.17, length + 0.06), cedar, roll)
            box(f"{prefix} slope {side}", (x, y, 0), (panel_width, 0.18, length), roof, roll)
            for row in range(rows):
                z = -length * 0.44 + row * length * 0.88 / (rows - 1)
                box(f"{prefix} ceramic lip {side} {row:02d}",
                    (x - side * 0.057, y + 0.14, z),
                    (panel_width + 0.06, 0.044, 0.065), tile_lip, roll)
            for edge in (-1, 1):
                box(f"{prefix} eave fascia {side} {edge}",
                    (x, y + 0.035, edge * (length / 2 - 0.02)),
                    (panel_width + 0.08, 0.14, 0.115), accent, roll)
        box(prefix + " ridge cap", (0, y + 0.58, 0), (0.25, 0.20, length + 0.16), tile_lip)
        for z in (-length * 0.49, length * 0.49):
            box(f"{prefix} ridge finial {z}", (0, y + 0.68, z),
                (0.42, 0.23, 0.25), tile_lip)

    roof_pair("Lower roof", 2.13, 1.40, 3.25, 7.08, 22, 9)
    for z in (-2.83, -1.88, -0.94, 0, 0.94, 1.88, 2.83):
        box(f"Visible rafter {z}", (2.72, 1.61, z), (0.77, 0.12, 0.13), accent)

    def shoji(prefix, y, z, width=0.86, height=0.98):
        face_x = 2.54
        box(prefix + " paper", (face_x, y, z), (0.05, height, width), paper)
        for dz in (-width / 2, width / 2):
            box(prefix + f" upright {dz}", (face_x + 0.053, y, z + dz),
                (0.095, height + 0.10, 0.065), cedar)
        for row in range(4):
            rail_y = y - height * 0.5 + row * height / 3
            box(prefix + f" rail {row}", (face_x + 0.060, rail_y, z),
                (0.09, 0.042, width + 0.10), cedar)
        for dz in (-width / 4, width / 4):
            box(prefix + f" vertical {dz}", (face_x + 0.066, y, z + dz),
                (0.07, height, 0.037), cedar)
        box(prefix + " stone sill", (2.61, y - height / 2 - 0.12, z),
            (0.32, 0.12, width + 0.20), stone)

    door_z = -0.64 if variant != 1 else 0.56
    window_zs = (1.42, 2.28) if door_z < 0 else (-2.20, -1.30)
    for i, z in enumerate(window_zs):
        shoji(f"Shoji {i}", 0.07 + (0.08 if variant == 2 else 0), z)

    box("Sliding entrance recess", (2.51, -0.58, door_z), (0.09, 2.28, 1.18), doorway)
    for z in (door_z - 0.55, door_z + 0.55):
        box(f"Door jamb {z}", (2.58, -0.58, z), (0.12, 2.33, 0.085), cedar)
    for y in (-1.60, -0.40, 0.54):
        box(f"Door rail {y}", (2.58, y, door_z), (0.12, 0.085, 1.20), accent)
    box("Door iron pull", (2.66, -0.66, door_z + 0.22), (0.06, 0.18, 0.12), iron)
    box("Entry stone threshold", (2.72, -1.66, door_z), (0.55, 0.18, 1.54), stone)
    box("Covered veranda platform", (2.62, -1.61, 0), (0.63, 0.15, 6.18), accent)
    for i in range(10):
        box(f"Veranda board {i:02d}", (2.64, -1.52, -2.75 + i * 0.61),
            (0.64, 0.034, 0.53), cedar)
    for z in (-2.81, 2.81):
        box(f"Porch post {z}", (2.85, -0.26, z), (0.14, 2.79, 0.14), cedar)
    box("Porch beam", (2.85, 1.20, 0), (0.16, 0.15, 5.75), cedar)

    # A small amount of variation breaks repeated roofs without changing footprint.
    if variant == 1:
        for z in (-2.82, 2.82):
            box(f"Rain chain {z}", (2.95, 0.67, z), (0.035, 1.70, 0.035), iron)
        for z in (-2.84, 2.84):
            box(f"Exposed side rafters {z}", (0, 1.64, z), (5.42, 0.10, 0.13), accent)
    if variant == 2:
        box("Upper plaster room", (0, 3.15, 0), (3.30, 1.42, 4.10), plaster)
        for z in (-1.85, 1.85):
            box(f"Upper timber post {z}", (1.73, 3.14, z), (0.14, 1.45, 0.14), cedar)
        shoji("Upper shoji", 3.23, 0, 0.92, 0.78)
        roof_pair("Upper roof", 4.15, 0.99, 2.36, 5.02, 23, 8)

    return materials, boxes


def main():
    DEST.mkdir(parents=True, exist_ok=True)
    for variant in range(3):
        materials, boxes = build_variant(variant)
        destination = DEST / f"kominka_{variant:02d}.glb"
        write_glb(destination, materials, boxes)
        print(f"{destination.name}: {len(boxes)} authored pieces, {destination.stat().st_size:,} bytes")


if __name__ == "__main__":
    main()
