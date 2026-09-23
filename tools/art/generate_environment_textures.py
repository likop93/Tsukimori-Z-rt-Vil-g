"""Reproducible, tileable, hand-directed village surface maps for Godot 4.

Run from the repository root: python3 tools/art/generate_environment_textures.py
The color maps carry broad painted variation; the scene supplies light and roughness.
"""

from pathlib import Path

import numpy as np
from PIL import Image


SIZE = 256
DEST = Path(__file__).resolve().parents[2] / "assets/environment/materials"
DEST.mkdir(parents=True, exist_ok=True)
yy, xx = np.mgrid[:SIZE, :SIZE].astype(np.float32)


def noise(seed: int, cells: int) -> np.ndarray:
    """Periodic, smooth noise; neighboring copies have matching edge samples."""
    grid = np.random.default_rng(seed).random((cells, cells), dtype=np.float32)
    u, v = xx * cells / SIZE, yy * cells / SIZE
    x0, y0 = np.floor(u).astype(int), np.floor(v).astype(int)
    sx, sy = u - x0, v - y0
    sx, sy = sx * sx * (3 - 2 * sx), sy * sy * (3 - 2 * sy)
    a = grid[y0 % cells, x0 % cells]
    b = grid[y0 % cells, (x0 + 1) % cells]
    c = grid[(y0 + 1) % cells, x0 % cells]
    d = grid[(y0 + 1) % cells, (x0 + 1) % cells]
    return (a * (1 - sx) + b * sx) * (1 - sy) + (c * (1 - sx) + d * sx) * sy


def save(name: str, rgb: np.ndarray) -> None:
    image = Image.fromarray(np.clip(rgb, 0, 255).astype(np.uint8), "RGB")
    image.save(DEST / f"{name}.png", optimize=True)


def paint(base: tuple[int, int, int], shade: np.ndarray, accent: np.ndarray | None = None) -> np.ndarray:
    color = np.asarray(base, dtype=np.float32)[None, None, :] + shade[..., None]
    if accent is not None:
        color += accent
    return color


# Earthen ground: broad soil variation with muted moss caught in the damp hollows.
soil = noise(101, 6) * 18 + noise(102, 24) * 11 - 14
moss = np.maximum(0, noise(103, 13) - 0.56) * 75
save("damp_earth", paint((83, 76, 67), soil, np.stack((-moss * 0.35, moss * 0.42, -moss * 0.12), axis=-1)))

# Paving and foundation: stone grain with edge-darkened, irregular mortar joints.
stone = noise(201, 7) * 21 + noise(202, 30) * 14 - 17
fleck = (noise(203, 48) > 0.69).astype(np.float32) * 8
save("wet_stone", paint((107, 115, 117), stone - fleck))

# Plaster: cool, washed mineral pigment, with low-contrast water marks.
plaster = noise(301, 5) * 15 + noise(302, 26) * 7 - 10
water_stain = np.maximum(0, noise(303, 9) - 0.59) * 34
save("aged_plaster", paint((178, 167, 143), plaster - water_stain))

# Cedar: vertical, wandering grain; thin marks read at camera distance without striping.
wave = xx + 2.8 * np.sin(yy * (2 * np.pi / SIZE) * 3) + noise(402, 9) * 4
grain = np.sin(wave * (2 * np.pi / SIZE) * 26) * 6
cedar = grain + noise(401, 8) * 17 + noise(403, 32) * 8 - 12
save("weathered_cedar", paint((116, 87, 64), cedar))

# Roof: shallow, staggered slate courses. Avoid hard white outlines at blue hour.
course = np.mod(yy, 32)
shift = (np.floor(yy / 32).astype(int) % 2) * 32
joint_x = np.mod(xx + shift, 64)
mortar = ((course < 2) | (joint_x < 2)).astype(np.float32) * 17
roof = noise(501, 12) * 17 + noise(502, 35) * 9 - 13 - mortar
save("slate_roof", paint((91, 103, 113), roof))

print("Wrote five repeatable Tsukimori environment color maps to", DEST)
