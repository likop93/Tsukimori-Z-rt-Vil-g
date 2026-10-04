# macOS review export — 2026-10-04

Native Universal 2 ZIP application exported on Windows with Godot 4.7.2.
Includes Intel x86_64 and Apple Silicon arm64, built-in ad-hoc signing,
no Developer ID or notarization. Native Mac execution remains untested.

Official `godotengine/godot-builds` 4.7.2-stable export templates downloaded;
full archive SHA-512 matched the release's SHA512-SUMS.txt before extraction.
Install `templates/macos.zip` under the active Godot profile's
`export_templates/4.7.2.stable/` folder. Append `tools/macos_review_preset.cfg`
to the local ignored export_presets.cfg, adapting preset index if needed.
ASTC import enabled in project.godot for universal export validation.
Export: Godot --headless --path . --export-release "macOS Review" OUTPUT.zip.

Verification: exporter completed signing and ZIP generation, ZIP CRC passed,
Info.plist inspected, executable retains Unix 0755 and fat Mach-O header.
Exported PCK started to the menu with the Windows Godot runtime; this is a
resource smoke test, not a native Mac test. Existing Windows certificate-store
diagnostic and shutdown ObjectDB warning remain.

Deliverable: `Tsukimori-macOS-2026-10-04.zip` with installation instructions
outside the signed application bundle.

References:
- https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_macos.html
- https://docs.godotengine.org/en/stable/tutorials/export/running_on_macos.html
