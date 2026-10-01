"""Small dependency-free glTF 2.0 writer for the shared-home preview geometry.

Blender remains the editable authoring source. This writer makes the same box
layout available in Godot even on machines without Blender installed.
"""

import json
import math
import struct
from pathlib import Path


FACES = (
    ((1, 0, 0), (0, 1, 0), (0, 0, 1)),
    ((-1, 0, 0), (0, 0, 1), (0, 1, 0)),
    ((0, 1, 0), (0, 0, 1), (1, 0, 0)),
    ((0, -1, 0), (1, 0, 0), (0, 0, 1)),
    ((0, 0, 1), (1, 0, 0), (0, 1, 0)),
    ((0, 0, -1), (0, 1, 0), (1, 0, 0)),
)


def _rotate(vector, degrees):
    angle = math.radians(degrees)
    c, s = math.cos(angle), math.sin(angle)
    x, y, z = vector
    return x * c - y * s, x * s + y * c, z


def _vertices_for_box(box):
    dimensions = [value / 2 for value in box["dimensions"]]
    center = box["location"]
    roll = box["roll"]
    positions, normals, uvs, indices = [], [], [], []
    for normal, tangent, bitangent in FACES:
        width = sum(abs(tangent[i]) * box["dimensions"][i] for i in range(3))
        height = sum(abs(bitangent[i]) * box["dimensions"][i] for i in range(3))
        for u, v in ((-1, -1), (1, -1), (1, 1), (-1, 1)):
            local = tuple(
                normal[i] * dimensions[i]
                + tangent[i] * dimensions[i] * u
                + bitangent[i] * dimensions[i] * v
                for i in range(3)
            )
            rotated = _rotate(local, roll)
            positions.append(tuple(center[i] + rotated[i] for i in range(3)))
            normals.append(_rotate(normal, roll))
            uvs.append(((u + 1) * width / 4.0, (v + 1) * height / 4.0))
        offset = len(positions) - 4
        indices.extend((offset, offset + 1, offset + 2, offset, offset + 2, offset + 3))
    return positions, normals, uvs, indices


def write_glb(path, material_specs, boxes):
    material_index = {spec["name"]: index for index, spec in enumerate(material_specs)}
    grouped = [[] for _ in material_specs]
    for box in boxes:
        grouped[material_index[box["material"]]].append(box)

    gltf = {
        "asset": {"version": "2.0", "generator": "Tsukimori shared home authoring"},
        "scene": 0,
        "scenes": [{"nodes": [0]}],
        "nodes": [{"name": "TsukimoriSharedHome", "mesh": 0}],
        "meshes": [{"name": "SharedHomeGeometry", "primitives": []}],
        "materials": [], "accessors": [], "bufferViews": [], "buffers": [],
        "images": [], "textures": [], "samplers": [{"wrapS": 10497, "wrapT": 10497}],
    }
    binary = bytearray()

    def add_view(data, target):
        while len(binary) % 4:
            binary.append(0)
        offset = len(binary)
        binary.extend(data)
        gltf["bufferViews"].append({"buffer": 0, "byteOffset": offset,
                                    "byteLength": len(data), "target": target})
        return len(gltf["bufferViews"]) - 1

    def add_accessor(view, component_type, count, kind, minimum=None, maximum=None):
        item = {"bufferView": view, "componentType": component_type,
                "count": count, "type": kind}
        if minimum is not None:
            item["min"] = minimum
            item["max"] = maximum
        gltf["accessors"].append(item)
        return len(gltf["accessors"]) - 1

    texture_indices = {}
    for spec in material_specs:
        texture_path = spec.get("texture")
        if texture_path and texture_path not in texture_indices:
            texture_data = Path(texture_path).read_bytes()
            view = add_view(texture_data, None)
            # Image bufferViews have no ARRAY_BUFFER/ELEMENT_ARRAY_BUFFER target.
            gltf["bufferViews"][view].pop("target")
            gltf["images"].append({"bufferView": view, "mimeType": "image/png"})
            gltf["textures"].append({"sampler": 0, "source": len(gltf["images"]) - 1})
            texture_indices[texture_path] = len(gltf["textures"]) - 1

    for spec in material_specs:
        material = {
            "name": spec["name"],
            "pbrMetallicRoughness": {
                "baseColorFactor": [*spec["rgb"], 1.0],
                "metallicFactor": spec["metallic"],
                "roughnessFactor": spec["roughness"],
            },
        }
        if spec.get("texture"):
            material["pbrMetallicRoughness"]["baseColorTexture"] = {
                "index": texture_indices[spec["texture"]]
            }
        if spec["glow"]:
            material["emissiveFactor"] = list(spec["glow"])
        gltf["materials"].append(material)

    for index, entries in enumerate(grouped):
        if not entries:
            continue
        positions, normals, uvs, indices = [], [], [], []
        for box in entries:
            box_positions, box_normals, box_uvs, box_indices = _vertices_for_box(box)
            offset = len(positions)
            positions.extend(box_positions)
            normals.extend(box_normals)
            uvs.extend(box_uvs)
            indices.extend(value + offset for value in box_indices)
        coordinates = b"".join(struct.pack("<3f", *point) for point in positions)
        normal_bytes = b"".join(struct.pack("<3f", *point) for point in normals)
        uv_bytes = b"".join(struct.pack("<2f", *point) for point in uvs)
        index_bytes = b"".join(struct.pack("<I", value) for value in indices)
        min_values = [min(point[axis] for point in positions) for axis in range(3)]
        max_values = [max(point[axis] for point in positions) for axis in range(3)]
        position_accessor = add_accessor(add_view(coordinates, 34962), 5126, len(positions), "VEC3", min_values, max_values)
        normal_accessor = add_accessor(add_view(normal_bytes, 34962), 5126, len(normals), "VEC3")
        uv_accessor = add_accessor(add_view(uv_bytes, 34962), 5126, len(uvs), "VEC2")
        index_accessor = add_accessor(add_view(index_bytes, 34963), 5125, len(indices), "SCALAR")
        gltf["meshes"][0]["primitives"].append({
            "attributes": {"POSITION": position_accessor, "NORMAL": normal_accessor, "TEXCOORD_0": uv_accessor},
            "indices": index_accessor,
            "material": index,
        })

    while len(binary) % 4:
        binary.append(0)
    gltf["buffers"] = [{"byteLength": len(binary)}]
    json_bytes = json.dumps(gltf, separators=(",", ":"), ensure_ascii=False).encode("utf-8")
    json_bytes += b" " * (-len(json_bytes) % 4)
    total_length = 12 + 8 + len(json_bytes) + 8 + len(binary)
    with open(path, "wb") as output:
        output.write(struct.pack("<4sII", b"glTF", 2, total_length))
        output.write(struct.pack("<I4s", len(json_bytes), b"JSON"))
        output.write(json_bytes)
        output.write(struct.pack("<I4s", len(binary), b"BIN\0"))
        output.write(binary)
