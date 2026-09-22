"""
Tsukimori — Akira Proxy v0.1
Greybox humanoid generator for camera/movement review.

Run from Blender's Scripting workspace:
1. Open this file from tools/blender/create_akira_proxy.py
2. Press Run Script

The script finds the repository root by locating project.godot, then writes:
- assets/characters/akira/proxy/akira_proxy.blend
- assets/characters/akira/proxy/akira_proxy.glb

This is a REVIEW proxy, not final character art.
"""

import bpy
import math
from pathlib import Path
from mathutils import Vector


def find_repo_root() -> Path:
    candidates = []
    try:
        candidates.append(Path(__file__).resolve())
    except NameError:
        pass
    candidates.append(Path.cwd().resolve())

    for candidate in candidates:
        start = candidate if candidate.is_dir() else candidate.parent
        for folder in [start, *start.parents]:
            if (folder / "project.godot").exists():
                return folder
    raise RuntimeError("Tsukimori repo root not found. Open this script from inside the project folder.")


REPO_ROOT = find_repo_root()
OUTPUT_DIR = REPO_ROOT / "assets" / "characters" / "akira" / "proxy"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
BLEND_PATH = OUTPUT_DIR / "akira_proxy.blend"
GLB_PATH = OUTPUT_DIR / "akira_proxy.glb"


def clear_scene():
    bpy.ops.object.mode_set(mode="OBJECT") if bpy.context.object and bpy.context.object.mode != "OBJECT" else None
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete(use_global=False)


def material(name, color, roughness=0.8):
    mat = bpy.data.materials.new(name=name)
    mat.diffuse_color = (*color, 1.0)
    mat.use_nodes = True
    bsdf = mat.node_tree.nodes.get("Principled BSDF")
    if bsdf:
        bsdf.inputs["Base Color"].default_value = (*color, 1.0)
        bsdf.inputs["Roughness"].default_value = roughness
    return mat


def add_box(name, location, dimensions, mat):
    bpy.ops.mesh.primitive_cube_add(location=location)
    obj = bpy.context.object
    obj.name = name
    obj.dimensions = dimensions
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    obj.data.materials.append(mat)
    return obj


def add_sphere(name, location, scale, mat):
    bpy.ops.mesh.primitive_ico_sphere_add(subdivisions=2, radius=1.0, location=location)
    obj = bpy.context.object
    obj.name = name
    obj.scale = scale
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    obj.data.materials.append(mat)
    return obj


def add_cylinder_between(name, a, b, radius, mat, vertices=12):
    a = Vector(a)
    b = Vector(b)
    direction = b - a
    midpoint = (a + b) * 0.5
    bpy.ops.mesh.primitive_cylinder_add(vertices=vertices, radius=radius, depth=direction.length, location=midpoint)
    obj = bpy.context.object
    obj.name = name
    obj.rotation_mode = "QUATERNION"
    obj.rotation_quaternion = direction.to_track_quat("Z", "Y")
    obj.data.materials.append(mat)
    return obj


def create_armature():
    arm_data = bpy.data.armatures.new("AkiraProxyRig")
    arm = bpy.data.objects.new("AkiraProxyRig", arm_data)
    bpy.context.collection.objects.link(arm)
    bpy.context.view_layer.objects.active = arm
    arm.select_set(True)
    bpy.ops.object.mode_set(mode="EDIT")

    bones = {}

    def add_bone(name, head, tail, parent=None, connect=False):
        bone = arm_data.edit_bones.new(name)
        bone.head = head
        bone.tail = tail
        if parent:
            bone.parent = bones[parent]
            bone.use_connect = connect
        bones[name] = bone
        return bone

    add_bone("root", (0, 0, 0.0), (0, 0, 0.12))
    add_bone("pelvis", (0, 0, 0.90), (0, 0, 1.05), "root")
    add_bone("spine", (0, 0, 1.02), (0, 0, 1.34), "pelvis")
    add_bone("chest", (0, 0, 1.34), (0, 0, 1.54), "spine", True)
    add_bone("neck", (0, 0, 1.54), (0, 0, 1.64), "chest", True)
    add_bone("head", (0, 0, 1.64), (0, 0, 1.82), "neck", True)

    for side, x in (("L", -0.11), ("R", 0.11)):
        add_bone(f"thigh.{side}", (x, 0, 0.92), (x, 0, 0.52), "pelvis")
        add_bone(f"shin.{side}", (x, 0, 0.52), (x, 0, 0.12), f"thigh.{side}", True)
        add_bone(f"foot.{side}", (x, 0, 0.12), (x, -0.18, 0.07), f"shin.{side}", True)

    for side, sx in (("L", -1.0), ("R", 1.0)):
        x0 = 0.24 * sx
        x1 = 0.52 * sx
        x2 = 0.73 * sx
        x3 = 0.80 * sx
        add_bone(f"upper_arm.{side}", (x0, 0, 1.48), (x1, 0, 1.34), "chest")
        add_bone(f"forearm.{side}", (x1, 0, 1.34), (x2, -0.01, 1.18), f"upper_arm.{side}", True)
        add_bone(f"hand.{side}", (x2, -0.01, 1.18), (x3, -0.02, 1.13), f"forearm.{side}", True)

    bpy.ops.object.mode_set(mode="POSE")
    for pb in arm.pose.bones:
        pb.rotation_mode = "XYZ"
    bpy.ops.object.mode_set(mode="OBJECT")
    return arm


def parent_to_bone(obj, arm, bone_name):
    world = obj.matrix_world.copy()
    obj.parent = arm
    obj.parent_type = "BONE"
    obj.parent_bone = bone_name
    obj.matrix_world = world


def build_proxy(arm):
    skin = material("ProxySkin", (0.42, 0.43, 0.45))
    cloth = material("AkiraCharcoal", (0.055, 0.065, 0.070))
    cloth2 = material("AkiraCoat", (0.085, 0.095, 0.10))
    hair = material("AkiraHair", (0.015, 0.018, 0.020))
    accent = material("MutedEmerald", (0.045, 0.19, 0.14))
    shoe = material("Shoes", (0.025, 0.025, 0.028))

    parts = []

    def box(name, loc, dims, mat, bone):
        obj = add_box(name, loc, dims, mat)
        parent_to_bone(obj, arm, bone)
        parts.append(obj)
        return obj

    def cyl(name, a, b, radius, mat, bone):
        obj = add_cylinder_between(name, a, b, radius, mat)
        parent_to_bone(obj, arm, bone)
        parts.append(obj)
        return obj

    box("Pelvis", (0, 0, 0.98), (0.36, 0.23, 0.20), cloth, "pelvis")
    box("Torso", (0, 0, 1.28), (0.43, 0.24, 0.48), cloth2, "spine")
    box("Chest", (0, 0, 1.47), (0.49, 0.25, 0.22), cloth2, "chest")
    box("ShirtAccent", (0, -0.126, 1.39), (0.055, 0.018, 0.25), accent, "chest")

    box("CoatBack", (0, 0.105, 1.02), (0.48, 0.07, 0.68), cloth, "pelvis")
    box("CoatPanelL", (-0.16, -0.04, 0.99), (0.15, 0.12, 0.64), cloth, "pelvis")
    box("CoatPanelR", (0.16, -0.04, 0.99), (0.15, 0.12, 0.64), cloth, "pelvis")

    cyl("Neck", (0, 0, 1.54), (0, 0, 1.64), 0.075, skin, "neck")
    head = add_sphere("Head", (0, 0, 1.72), (0.115, 0.105, 0.145), skin)
    parent_to_bone(head, arm, "head")
    parts.append(head)
    hair_obj = add_sphere("HairMass", (0, 0.015, 1.77), (0.125, 0.115, 0.115), hair)
    parent_to_bone(hair_obj, arm, "head")
    parts.append(hair_obj)
    box("HairFringe", (0, -0.095, 1.755), (0.18, 0.055, 0.10), hair, "head")

    for side, x in (("L", -0.11), ("R", 0.11)):
        cyl(f"Thigh.{side}", (x, 0, 0.90), (x, 0, 0.52), 0.095, cloth2, f"thigh.{side}")
        cyl(f"Shin.{side}", (x, 0, 0.50), (x, 0, 0.13), 0.078, cloth, f"shin.{side}")
        box(f"Foot.{side}", (x, -0.105, 0.075), (0.18, 0.32, 0.12), shoe, f"foot.{side}")

    for side, sx in (("L", -1.0), ("R", 1.0)):
        x0 = 0.26 * sx
        x1 = 0.52 * sx
        x2 = 0.73 * sx
        x3 = 0.80 * sx
        cyl(f"UpperArm.{side}", (x0, 0, 1.47), (x1, 0, 1.34), 0.075, cloth2, f"upper_arm.{side}")
        cyl(f"Forearm.{side}", (x1, 0, 1.33), (x2, -0.01, 1.18), 0.065, cloth, f"forearm.{side}")
        cyl(f"Hand.{side}", (x2, -0.01, 1.18), (x3, -0.02, 1.13), 0.055, skin, f"hand.{side}")

    for obj in parts:
        obj["tsukimori_status"] = "BLOCKOUT"
        obj["character"] = "Akira"

    return parts


def reset_pose(arm):
    for pb in arm.pose.bones:
        pb.rotation_mode = "XYZ"
        pb.rotation_euler = (0.0, 0.0, 0.0)
        pb.location = (0.0, 0.0, 0.0)


def key_pose(arm, frame, rotations=None, locations=None):
    rotations = rotations or {}
    locations = locations or {}
    reset_pose(arm)
    for bone_name, degrees_xyz in rotations.items():
        pb = arm.pose.bones[bone_name]
        pb.rotation_euler = tuple(math.radians(v) for v in degrees_xyz)
    for bone_name, loc in locations.items():
        arm.pose.bones[bone_name].location = loc

    for pb in arm.pose.bones:
        pb.keyframe_insert(data_path="rotation_euler", frame=frame)
        pb.keyframe_insert(data_path="location", frame=frame)


def create_action(arm, name, frames):
    action = bpy.data.actions.new(name=name)
    arm.animation_data_create()
    arm.animation_data.action = action
    for frame, rotations, locations in frames:
        key_pose(arm, frame, rotations, locations)
    action.use_fake_user = True
    return action


def build_animations(arm):
    idle = create_action(arm, "Idle", [
        (1, {"chest": (0, 0, -0.6)}, {"pelvis": (0, 0, 0.0)}),
        (30, {"chest": (0, 0, 0.8), "upper_arm.L": (1.0, 0, 0), "upper_arm.R": (-1.0, 0, 0)}, {"pelvis": (0, 0, 0.008)}),
        (60, {"chest": (0, 0, -0.6)}, {"pelvis": (0, 0, 0.0)}),
    ])

    walk = create_action(arm, "Walk", [
        (1, {
            "thigh.L": (24, 0, 0), "thigh.R": (-24, 0, 0),
            "shin.L": (4, 0, 0), "shin.R": (30, 0, 0),
            "upper_arm.L": (-20, 0, 0), "upper_arm.R": (20, 0, 0),
            "forearm.L": (-8, 0, 0), "forearm.R": (-12, 0, 0),
        }, {"pelvis": (0, 0, 0.0)}),
        (7, {
            "thigh.L": (0, 0, 0), "thigh.R": (0, 0, 0),
            "shin.L": (20, 0, 0), "shin.R": (8, 0, 0),
            "upper_arm.L": (0, 0, 0), "upper_arm.R": (0, 0, 0),
        }, {"pelvis": (0, 0, 0.018)}),
        (13, {
            "thigh.L": (-24, 0, 0), "thigh.R": (24, 0, 0),
            "shin.L": (30, 0, 0), "shin.R": (4, 0, 0),
            "upper_arm.L": (20, 0, 0), "upper_arm.R": (-20, 0, 0),
            "forearm.L": (-12, 0, 0), "forearm.R": (-8, 0, 0),
        }, {"pelvis": (0, 0, 0.0)}),
        (19, {
            "thigh.L": (0, 0, 0), "thigh.R": (0, 0, 0),
            "shin.L": (8, 0, 0), "shin.R": (20, 0, 0),
            "upper_arm.L": (0, 0, 0), "upper_arm.R": (0, 0, 0),
        }, {"pelvis": (0, 0, 0.018)}),
        (25, {
            "thigh.L": (24, 0, 0), "thigh.R": (-24, 0, 0),
            "shin.L": (4, 0, 0), "shin.R": (30, 0, 0),
            "upper_arm.L": (-20, 0, 0), "upper_arm.R": (20, 0, 0),
            "forearm.L": (-8, 0, 0), "forearm.R": (-12, 0, 0),
        }, {"pelvis": (0, 0, 0.0)}),
    ])

    run = create_action(arm, "Run", [
        (1, {
            "chest": (8, 0, 0),
            "thigh.L": (38, 0, 0), "thigh.R": (-38, 0, 0),
            "shin.L": (5, 0, 0), "shin.R": (48, 0, 0),
            "upper_arm.L": (-32, 0, 0), "upper_arm.R": (32, 0, 0),
            "forearm.L": (-35, 0, 0), "forearm.R": (-35, 0, 0),
        }, {"pelvis": (0, 0, 0.0)}),
        (5, {
            "chest": (8, 0, 0),
            "thigh.L": (0, 0, 0), "thigh.R": (0, 0, 0),
            "shin.L": (30, 0, 0), "shin.R": (16, 0, 0),
        }, {"pelvis": (0, 0, 0.028)}),
        (9, {
            "chest": (8, 0, 0),
            "thigh.L": (-38, 0, 0), "thigh.R": (38, 0, 0),
            "shin.L": (48, 0, 0), "shin.R": (5, 0, 0),
            "upper_arm.L": (32, 0, 0), "upper_arm.R": (-32, 0, 0),
            "forearm.L": (-35, 0, 0), "forearm.R": (-35, 0, 0),
        }, {"pelvis": (0, 0, 0.0)}),
        (13, {
            "chest": (8, 0, 0),
            "thigh.L": (0, 0, 0), "thigh.R": (0, 0, 0),
            "shin.L": (16, 0, 0), "shin.R": (30, 0, 0),
        }, {"pelvis": (0, 0, 0.028)}),
        (17, {
            "chest": (8, 0, 0),
            "thigh.L": (38, 0, 0), "thigh.R": (-38, 0, 0),
            "shin.L": (5, 0, 0), "shin.R": (48, 0, 0),
            "upper_arm.L": (-32, 0, 0), "upper_arm.R": (32, 0, 0),
            "forearm.L": (-35, 0, 0), "forearm.R": (-35, 0, 0),
        }, {"pelvis": (0, 0, 0.0)}),
    ])

    arm.animation_data.action = idle
    return idle, walk, run


def export_glb():
    props = {p.identifier for p in bpy.ops.export_scene.gltf.get_rna_type().properties}
    kwargs = {
        "filepath": str(GLB_PATH),
        "export_format": "GLB",
        "use_selection": False,
        "export_animations": True,
    }
    optional = {
        "export_animation_mode": "ACTIONS",
        "export_all_actions": True,
        "export_nla_strips": False,
        "export_force_sampling": True,
        "export_skins": True,
    }
    for key, value in optional.items():
        if key in props:
            kwargs[key] = value
    bpy.ops.export_scene.gltf(**kwargs)


def main():
    clear_scene()
    scene = bpy.context.scene
    scene.render.fps = 24
    scene.frame_start = 1
    scene.frame_end = 60

    arm = create_armature()
    build_proxy(arm)
    build_animations(arm)

    arm["tsukimori_status"] = "BLOCKOUT"
    arm["character"] = "Akira"
    arm["proxy_version"] = "0.1"

    bpy.context.view_layer.objects.active = arm
    arm.select_set(True)

    bpy.ops.wm.save_as_mainfile(filepath=str(BLEND_PATH))
    export_glb()
    bpy.ops.wm.save_as_mainfile(filepath=str(BLEND_PATH))

    print("TSUKIMORI AKIRA PROXY READY")
    print(f"BLEND: {BLEND_PATH}")
    print(f"GLB:   {GLB_PATH}")


if __name__ == "__main__":
    main()
