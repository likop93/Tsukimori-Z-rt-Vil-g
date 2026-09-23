extends Node3D

# A visual prototype only. The parent house keeps its original collision and position.
# Local origin is at the middle of the ground-floor wall, 1.8 m above the ground.
var _elapsed := 0.0
var _entry_light: OmniLight3D
var _porch_lantern: Node3D
var _wind_chime: Node3D
var _seal_material: StandardMaterial3D

func _ready() -> void:
    var wall := _mat("WeatheredPlaster", Color(0.28, 0.25, 0.22), Color(0, 0, 0), 0.88)
    var upper_wall := _mat("UpperTimber", Color(0.19, 0.16, 0.15), Color(0, 0, 0), 0.86)
    var wood := _mat("AgedTimber", Color(0.115, 0.082, 0.066), Color(0, 0, 0), 0.78)
    var roof := _mat("IndigoTiles", Color(0.065, 0.078, 0.104), Color(0, 0, 0), 0.58)
    var tile_edge := _mat("TileEdges", Color(0.11, 0.12, 0.145), Color(0, 0, 0), 0.62)
    var footing := _mat("MossyStone", Color(0.18, 0.19, 0.18), Color(0, 0, 0), 0.94)
    var window := _mat("WarmPaper", Color(0.60, 0.40, 0.25), Color(0.34, 0.16, 0.065))
    var doorway := _mat("DoorShadow", Color(0.055, 0.051, 0.055))
    var lantern := _mat("LanternPaper", Color(0.85, 0.48, 0.20), Color(0.85, 0.28, 0.06), 0.72)
    var seal := _mat("OldSealGlow", Color(0.035, 0.13, 0.10), Color(0.015, 0.12, 0.075), 0.66)
    _seal_material = seal

    _box(self, "GroundFloor", Vector3.ZERO, Vector3(4.8, 3.6, 6.0), wall)
    _box(self, "Foundation", Vector3(0, -1.66, 0), Vector3(4.96, 0.30, 6.15), footing)
    _box(self, "UpperStory", Vector3(0, 3.44, 0), Vector3(3.35, 1.8, 4.25), upper_wall)

    var ground_post_z := [-2.77, -1.46, 0.10, 2.77]
    for index in ground_post_z.size():
        _box(self, "GroundPost%02d" % (index + 1), Vector3(-2.46, -0.05, ground_post_z[index]), Vector3(0.16, 3.45, 0.15), wood)
    _box(self, "LowerLintel", Vector3(-2.47, 1.23, 0), Vector3(0.13, 0.17, 5.7), wood)
    _box(self, "UpperLintel", Vector3(-1.75, 3.98, 0), Vector3(0.12, 0.13, 4.2), wood)
    var upper_post_z := [-1.86, 0.0, 1.86]
    for index in upper_post_z.size():
        _box(self, "UpperPost%02d" % (index + 1), Vector3(-1.75, 3.41, upper_post_z[index]), Vector3(0.14, 1.68, 0.13), wood)

    _roof_pair("LowerRoof", 1.41, 2.15, 3.2, 7.12, 22.0, roof, tile_edge)
    _roof_pair("UpperRoof", 1.00, 4.83, 2.45, 5.08, 23.0, roof, tile_edge)

    _window("LowerWindowLeft", Vector3(-2.51, 0.16, -2.04), 0.78, 0.84, window, wood)
    _window("LowerWindowRight", Vector3(-2.51, 0.16, 1.46), 1.03, 1.08, window, wood)
    _window("UpperWindowLeft", Vector3(-1.79, 3.50, -1.10), 0.74, 0.72, window, wood)
    _window("UpperWindowRight", Vector3(-1.79, 3.50, 1.12), 0.74, 0.72, window, wood)

    # The entrance is on the street side. Keep the canopy above Miyako's sightline.
    _box(self, "KatsuroDoor", Vector3(-2.49, -0.58, -0.67), Vector3(0.08, 2.32, 1.27), doorway)
    _box(self, "DoorHeader", Vector3(-2.56, 0.66, -0.67), Vector3(0.13, 0.17, 1.47), wood)
    _box(self, "DoorThreshold", Vector3(-2.65, -1.66, -0.67), Vector3(0.52, 0.19, 1.65), footing)
    _box(self, "VerandaDeck", Vector3(-2.78, -1.63, 0), Vector3(1.05, 0.15, 6.35), wood)
    _box(self, "VerandaBeam", Vector3(-3.18, 1.30, 0), Vector3(0.14, 0.14, 6.37), wood)
    var porch_post_z := [-2.82, 2.82]
    for index in porch_post_z.size():
        _box(self, "PorchPost%02d" % (index + 1), Vector3(-3.18, -0.22, porch_post_z[index]), Vector3(0.15, 3.04, 0.15), wood)

    _build_story_details(wood, footing, doorway, lantern, seal)

    _entry_light = OmniLight3D.new()
    _entry_light.name = "WarmEntryLight"
    _entry_light.position = Vector3(-2.96, 0.82, -0.66)
    _entry_light.light_color = Color(1.0, 0.63, 0.34)
    _entry_light.light_energy = 1.15
    _entry_light.omni_range = 4.0
    add_child(_entry_light)

func _process(delta: float) -> void:
    _elapsed += delta
    if is_instance_valid(_entry_light):
        _entry_light.light_energy = 1.10 + sin(_elapsed * 2.1) * 0.055 + sin(_elapsed * 4.7) * 0.018
    if is_instance_valid(_porch_lantern):
        _porch_lantern.rotation.z = sin(_elapsed * 0.42) * deg_to_rad(0.65)
    if is_instance_valid(_wind_chime):
        # The first pass is almost still: the house feels sheltered, with only a rare soft movement.
        _wind_chime.rotation.z = sin(_elapsed * 0.54) * deg_to_rad(0.9)
    if is_instance_valid(_seal_material):
        _seal_material.emission_energy_multiplier = 0.50 + sin(_elapsed * 0.38) * 0.10

func _build_story_details(wood: Material, footing: Material, doorway: Material, lantern: Material, seal: Material) -> void:
    # One warm lantern carries the entry composition in the blue-violet dusk.
    _porch_lantern = Node3D.new()
    _porch_lantern.name = "PorchLantern"
    _porch_lantern.position = Vector3(-3.23, 0.78, -0.66)
    add_child(_porch_lantern)
    _box(_porch_lantern, "LanternTop", Vector3(0, 0.31, 0), Vector3(0.16, 0.08, 0.42), wood)
    _box(_porch_lantern, "LanternFrame", Vector3(0, 0.0, 0), Vector3(0.13, 0.50, 0.38), wood)
    _box(_porch_lantern, "LanternPaper", Vector3(-0.072, 0, 0), Vector3(0.035, 0.36, 0.29), lantern)
    _box(_porch_lantern, "LanternBase", Vector3(0, -0.30, 0), Vector3(0.18, 0.07, 0.42), wood)

    # A nearly motionless wind chime gives the porch a quiet, held-breath feeling.
    _wind_chime = Node3D.new()
    _wind_chime.name = "WindChime"
    _wind_chime.position = Vector3(-3.17, 0.96, 1.85)
    add_child(_wind_chime)
    _box(_wind_chime, "ChimeCap", Vector3(0, 0.22, 0), Vector3(0.16, 0.08, 0.16), wood)
    _box(_wind_chime, "ChimeCord", Vector3(0, 0.03, 0), Vector3(0.025, 0.38, 0.025), footing)
    _box(_wind_chime, "ChimeTubeLeft", Vector3(-0.10, -0.15, 0), Vector3(0.035, 0.30, 0.035), footing)
    _box(_wind_chime, "ChimeTubeRight", Vector3(0.10, -0.21, 0), Vector3(0.035, 0.42, 0.035), footing)
    _box(_wind_chime, "ChimeSail", Vector3(0, -0.39, 0), Vector3(0.16, 0.09, 0.05), footing)

    # A restrained exterior hint of Katsuro's sealed under-house space.
    _box(self, "UnderhouseSecretDoor", Vector3(-2.56, -1.02, 2.30), Vector3(0.07, 1.06, 0.92), doorway)
    _box(self, "SecretDoorFrameTop", Vector3(-2.61, -0.45, 2.30), Vector3(0.10, 0.10, 1.06), wood)
    _box(self, "SecretDoorFrameSideLeft", Vector3(-2.61, -1.02, 1.80), Vector3(0.10, 1.12, 0.10), wood)
    _box(self, "SecretDoorFrameSideRight", Vector3(-2.61, -1.02, 2.80), Vector3(0.10, 1.12, 0.10), wood)
    _box(self, "SecretSealPlate", Vector3(-2.615, -1.04, 2.30), Vector3(0.025, 0.48, 0.42), seal)
    for index in range(5):
        _box(self, "SecretSealGroove%02d" % (index + 1), Vector3(-2.632, -0.89 + float(index) * 0.075, 2.30), Vector3(0.012, 0.025, 0.34), doorway)
    for index in range(3):
        _box(self, "UnderhouseStep%02d" % (index + 1), Vector3(-2.72 - float(index) * 0.24, -1.66 + float(index) * 0.07, 2.30), Vector3(0.38, 0.12, 1.12), footing)

func _roof_pair(prefix: String, x: float, y: float, width: float, length: float, angle: float, roof: Material, edges: Material) -> void:
    for side in [-1.0, 1.0]:
        var slope := _box(self, prefix + ("Left" if side < 0 else "Right"), Vector3(side * x, y, 0), Vector3(width, 0.22, length), roof)
        slope.rotation.z = deg_to_rad(-angle * side)
        for seam_index in range(6):
            var seam := _box(self, "%sSeam%s_%02d" % [prefix, "L" if side < 0 else "R", seam_index], Vector3(side * x, y + 0.12, -length * 0.39 + float(seam_index) * length * 0.155), Vector3(width, 0.045, 0.045), edges)
            seam.rotation.z = slope.rotation.z
    _box(self, prefix + "Ridge", Vector3(0, y + sin(deg_to_rad(angle)) * width * 0.5 + 0.02, 0), Vector3(0.21, 0.17, length + 0.15), edges)

func _window(name_value: String, center: Vector3, height: float, width: float, paper: Material, timber: Material) -> void:
    var window_root := Node3D.new()
    window_root.name = name_value
    window_root.position = center
    add_child(window_root)
    _box(window_root, "Paper", Vector3.ZERO, Vector3(0.035, height, width), paper)
    _box(window_root, "SideBarLeft", Vector3(-0.045, 0, -width * 0.5), Vector3(0.08, height + 0.07, 0.06), timber)
    _box(window_root, "SideBarRight", Vector3(-0.045, 0, width * 0.5), Vector3(0.08, height + 0.07, 0.06), timber)
    _box(window_root, "Sill", Vector3(-0.045, -height * 0.5, 0), Vector3(0.08, 0.08, width + 0.07), timber)
    _box(window_root, "TopBar", Vector3(-0.045, height * 0.5, 0), Vector3(0.08, 0.08, width + 0.07), timber)
    _box(window_root, "MiddleRail", Vector3(-0.055, 0, 0), Vector3(0.08, 0.055, width), timber)
    _box(window_root, "CenterBar", Vector3(-0.06, 0, 0), Vector3(0.07, height, 0.055), timber)

func _mat(name_value: String, color: Color, emission: Color = Color(0, 0, 0), roughness_value: float = 0.82) -> StandardMaterial3D:
    var result := StandardMaterial3D.new()
    result.resource_name = name_value
    result.albedo_color = color
    result.roughness = roughness_value
    if emission != Color(0, 0, 0):
        result.emission_enabled = true
        result.emission = emission
        result.emission_energy_multiplier = 1.0
    return result

func _box(parent: Node, name_value: String, offset: Vector3, size: Vector3, material: Material) -> MeshInstance3D:
    var mesh := BoxMesh.new()
    mesh.size = size
    var instance := MeshInstance3D.new()
    instance.name = name_value
    instance.position = offset
    instance.mesh = mesh
    instance.material_override = material
    parent.add_child(instance)
    return instance
