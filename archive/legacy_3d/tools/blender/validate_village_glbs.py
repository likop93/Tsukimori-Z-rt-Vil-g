"""Static integrity check for authored village GLBs; does not replace Godot F5 review."""

import json
import struct
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
FOLDER = ROOT / "assets/buildings/village"


def inspect(path: Path) -> None:
    data = path.read_bytes()
    magic, version, declared_size = struct.unpack_from("<4sII", data)
    assert (magic, version, declared_size) == (b"glTF", 2, len(data)), path
    json_size, json_tag = struct.unpack_from("<I4s", data, 12)
    assert json_tag == b"JSON", path
    gltf = json.loads(data[20 : 20 + json_size])
    bin_start = 20 + json_size
    bin_size, bin_tag = struct.unpack_from("<I4s", data, bin_start)
    assert bin_tag == b"BIN\0" and bin_start + 8 + bin_size == len(data), path
    payload = data[bin_start + 8 :]
    assert gltf["buffers"][0]["byteLength"] == len(payload), path

    def buffer_view(index):
        view = gltf["bufferViews"][index]
        offset = view.get("byteOffset", 0)
        end = offset + view["byteLength"]
        assert 0 <= offset <= end <= len(payload), path
        return payload[offset:end]

    assert len(gltf["images"]) == 4, path
    for image in gltf["images"]:
        assert image["mimeType"] == "image/png", path
        assert buffer_view(image["bufferView"]).startswith(b"\x89PNG\r\n\x1a\n"), path
    assert len(gltf["meshes"][0]["primitives"]) >= 8, path
    for primitive in gltf["meshes"][0]["primitives"]:
        position = gltf["accessors"][primitive["attributes"]["POSITION"]]
        normals = gltf["accessors"][primitive["attributes"]["NORMAL"]]
        uv = gltf["accessors"][primitive["attributes"]["TEXCOORD_0"]]
        indices = gltf["accessors"][primitive["indices"]]
        assert position["count"] == normals["count"] == uv["count"] > 0, path
        assert indices["count"] % 3 == 0 and indices["count"] > 0, path
        for accessor in (position, normals, uv, indices):
            buffer_view(accessor["bufferView"])
        index_data = buffer_view(indices["bufferView"])
        assert indices["componentType"] == 5125, path
        vertex_indices = struct.unpack(f"<{indices['count']}I", index_data)
        assert max(vertex_indices) < position["count"], path
    print(f"{path.name}: valid container, embedded PNGs, UVs, meshes and indices")


if __name__ == "__main__":
    for variant in range(3):
        inspect(FOLDER / f"kominka_{variant:02d}.glb")
