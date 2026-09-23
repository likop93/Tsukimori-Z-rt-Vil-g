"""Author Tsukimori's shared home as a Blender file and Godot GLB.

Run in Blender's Scripting workspace (produces .blend and .glb), or:
    blender -b --python tools/blender/create_shared_home.py
Run with Python alone for the same geometry as a directly playable GLB:
    python3 tools/blender/create_shared_home.py

Writes assets/buildings/shared_home/tsukimori_shared_home.blend and .glb.
The Blender source is editable; the Godot scene loads the GLB automatically.
Coordinates below are in the house's Godot-local X/Y/Z system (Y up).
"""

from pathlib import Path
from math import radians
try:
    import bpy
except ModuleNotFoundError:
    bpy = None

if bpy is None:
    from glb_writer import write_glb

BOXES = []
MATERIALS = []


def project_root():
    locations = []
    try:
        locations.append(Path(__file__).resolve().parent)
    except NameError:
        pass
    if bpy is not None:
        editor = getattr(bpy.context, "space_data", None)
        text = getattr(editor, "text", None)
        if text is not None and text.filepath:
            locations.append(Path(bpy.path.abspath(text.filepath)).resolve().parent)
    locations.append(Path.cwd().resolve())
    for start in locations:
        for folder in (start, *start.parents):
            if (folder / "project.godot").is_file():
                return folder
    raise RuntimeError("Run this script from inside the Tsukimori project.")


def material(name, rgb, roughness=0.8, metallic=0.0, glow=None):
    spec = {"name": name, "rgb": rgb, "roughness": roughness, "metallic": metallic, "glow": glow}
    MATERIALS.append(spec)
    if bpy is None:
        return spec
    mat = bpy.data.materials.new(name)
    mat.diffuse_color = (*rgb, 1.0)
    mat.use_nodes = True
    surface = mat.node_tree.nodes.get("Principled BSDF")
    surface.inputs["Base Color"].default_value = (*rgb, 1.0)
    surface.inputs["Roughness"].default_value = roughness
    surface.inputs["Metallic"].default_value = metallic
    if glow:
        emission = surface.inputs.get("Emission Color") or surface.inputs.get("Emission")
        if emission:
            emission.default_value = (*glow, 1.0)
        strength = surface.inputs.get("Emission Strength")
        if strength:
            strength.default_value = 0.7
    return mat


def box(name, location, dimensions, mat, roll=0, bevel=0):
    if bpy is None:
        BOXES.append({"name": name, "location": location, "dimensions": dimensions,
                      "material": mat["name"], "roll": roll})
        return
    x, y, z = location
    dx, dy, dz = dimensions
    # Blender is Z-up; glTF brings (x, -z, y) back to Godot (x, y, z).
    bpy.ops.mesh.primitive_cube_add(size=1, location=(x, -z, y))
    obj = bpy.context.object
    obj.name = name
    obj.dimensions = (dx, dz, dy)
    obj.rotation_euler.y = radians(-roll)
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    obj.data.materials.append(mat)
    if bevel:
        modifier = obj.modifiers.new("Weathered edges", "BEVEL")
        modifier.width = bevel
        modifier.segments = 1
        obj.modifiers.new("Weighted normals", "WEIGHTED_NORMAL")
    return obj


def shoji(name, x, y, z, width, height, paper, timber):
    box(name + "Paper", (x, y, z), (0.045, height, width), paper)
    for side, delta in (("A", -width / 2), ("B", width / 2)):
        box(name + "Frame" + side, (x - 0.045, y, z + delta), (0.09, height + 0.08, 0.09), timber)
    for row in range(4):
        rail_y = y - height / 2 + height * row / 3
        box(f"{name}Rail{row}", (x - 0.055, rail_y, z), (0.10, 0.07, width + 0.08), timber)
    for column in range(1, 4):
        rail_z = z - width / 2 + width * column / 4
        box(f"{name}Muntin{column}", (x - 0.060, y, rail_z), (0.10, height, 0.045), timber)


def roof(prefix, x_center, y_center, width, length, angle, tile, edge):
    for side, side_name in ((-1, "Left"), (1, "Right")):
        x = side * x_center
        box(prefix + side_name, (x, y_center, 0), (width, 0.22, length), tile, -angle * side, 0.025)
        for row in range(12):
            z = -length * 0.45 + row * length * 0.082
            box(f"{prefix}{side_name}TileRow{row:02d}",
                (x, y_center + 0.135, z), (width * 0.98, 0.055, 0.055),
                edge, -angle * side)
        for column in range(4):
            x_offset = (column - 1.5) * width / 4.1
            box(f"{prefix}{side_name}TileSeam{column:02d}",
                (x + x_offset, y_center + 0.14, 0), (0.035, 0.034, length * 0.92),
                edge, -angle * side)
    box(prefix + "Ridge", (0, y_center + 0.75, 0), (0.23, 0.18, length + 0.13), edge, bevel=0.025)


def build():
    if bpy is not None:
        bpy.ops.object.select_all(action="SELECT")
        bpy.ops.object.delete(use_global=False)

    plaster = material("Charcoal weathered plaster", (0.28, 0.25, 0.22), 0.90)
    upper = material("Smoked upper timber", (0.17, 0.15, 0.15), 0.82)
    wood = material("Aged chestnut", (0.115, 0.078, 0.062), 0.76)
    joinery = material("Warm worn cedar", (0.20, 0.13, 0.095), 0.78)
    tiles = material("Rain dark indigo ceramic", (0.063, 0.079, 0.105), 0.39, 0.08)
    tile_edge = material("Wet tile lip", (0.11, 0.12, 0.145), 0.43, 0.05)
    stone = material("Mossy stone", (0.15, 0.18, 0.17), 0.85)
    paper = material("Amber shoji", (0.57, 0.41, 0.26), 0.88, glow=(0.21, 0.115, 0.043))
    shadow = material("Recessed doorway", (0.045, 0.041, 0.048), 0.95)
    verdigris = material("Tarnished iron", (0.07, 0.105, 0.10), 0.59, 0.3)

    box("Ground floor", (0, 0, 0), (4.8, 3.6, 6.0), plaster, bevel=0.035)
    box("Upper story", (0, 3.44, 0), (3.35, 1.8, 4.25), upper, bevel=0.03)
    box("Raised stone foundation", (0, -1.66, 0), (4.98, 0.30, 6.16), stone, bevel=0.06)

    for z in (-2.77, -1.46, 0.10, 2.77):
        box(f"Facade post {z}", (-2.46, -0.05, z), (0.17, 3.47, 0.17), wood, bevel=0.016)
    for z in (-1.86, 0, 1.86):
        box(f"Upper post {z}", (-1.77, 3.43, z), (0.16, 1.74, 0.17), wood, bevel=0.012)
    for y, x, length in ((1.24, -2.50, 5.75), (3.98, -1.79, 4.30)):
        box(f"Lateral beam {y}", (x, y, 0), (0.18, 0.19, length), wood, bevel=0.016)
    for level in range(2):
        for z in (-2.75, 2.75):
            box(f"End framing {level} {z}", (0, 0.75 + level * 2.6, z), (4.85 if level == 0 else 3.35, 0.12, 0.13), joinery)

    roof("Main eave", 1.41, 2.15, 3.2, 7.12, 22, tiles, tile_edge)
    roof("Upper roof", 1.00, 4.83, 2.45, 5.08, 23, tiles, tile_edge)
    for index in range(13):
        z = -3.0 + index * 0.5
        box(f"Eave rafter {index:02d}", (-2.75, 1.38, z), (1.2, 0.11, 0.12), wood)

    shoji("Ground north ", -2.53, 0.16, -2.04, 0.84, 0.78, paper, wood)
    shoji("Ground south ", -2.53, 0.16, 1.46, 1.08, 1.03, paper, wood)
    shoji("Upper north ", -1.81, 3.50, -1.10, 0.72, 0.74, paper, wood)
    shoji("Upper south ", -1.81, 3.50, 1.12, 0.72, 0.74, paper, wood)

    box("Main door recess", (-2.49, -0.58, -0.67), (0.09, 2.32, 1.27), shadow)
    for z in (-1.35, -0.67, 0.01):
        box(f"Door stile {z}", (-2.58, -0.58, z), (0.11, 2.29, 0.07), wood)
    for y in (-1.55, -0.34, 0.58):
        box(f"Door rail {y}", (-2.59, y, -0.67), (0.10, 0.08, 1.36), joinery)
    box("Iron door ring", (-2.67, -0.65, -0.14), (0.045, 0.15, 0.13), verdigris)
    box("Entry sill", (-2.69, -1.66, -0.67), (0.56, 0.20, 1.65), stone, bevel=0.03)

    box("Covered veranda", (-2.78, -1.63, 0), (1.05, 0.15, 6.35), joinery)
    for index in range(12):
        box(f"Veranda plank {index:02d}", (-2.79, -1.53, -2.82 + index * 0.52), (1.07, 0.035, 0.45), wood)
    for z in (-2.82, 2.82):
        box(f"Veranda outer post {z}", (-3.18, -0.22, z), (0.15, 3.04, 0.15), wood, bevel=0.01)
    box("Veranda header", (-3.18, 1.30, 0), (0.16, 0.17, 6.37), wood)

    box("Underhouse sealed door", (-2.57, -1.02, 2.30), (0.08, 1.06, 0.92), shadow)
    box("Underhouse metal seal", (-2.64, -1.02, 2.30), (0.045, 0.48, 0.42), verdigris)
    for step in range(3):
        box(f"Wet threshold step {step}", (-2.74 - step * 0.24, -1.67 + step * 0.07, 2.30), (0.40, 0.12, 1.12), stone)
    for index in range(5):
        box(f"Front approach stone {index:02d}", (-3.65 - index * 0.57, -1.76, -0.67), (0.48, 0.05, 0.87), stone)


def main():
    target = project_root() / "assets" / "buildings" / "shared_home"
    target.mkdir(parents=True, exist_ok=True)
    build()
    if bpy is None:
        write_glb(target / "tsukimori_shared_home.glb", MATERIALS, BOXES)
        print(f"Tsukimori shared home GLB saved to {target}")
        return
    bpy.ops.wm.save_as_mainfile(filepath=str(target / "tsukimori_shared_home.blend"))
    bpy.ops.export_scene.gltf(
        filepath=str(target / "tsukimori_shared_home.glb"),
        export_format="GLB",
        export_animations=False,
    )
    print(f"Tsukimori shared home saved to {target}")


if __name__ == "__main__":
    main()
