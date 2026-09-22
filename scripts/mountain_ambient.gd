extends Node

@export var tree_sway_degrees: float = 0.8
@export var tree_sway_speed: float = 0.42
@export var fog_breathe_amount: float = 0.00075
@export var fog_breathe_speed: float = 0.18

@onready var trees: Node3D = $"../Trees"
@onready var sign_board: Node3D = $"../OldSignpost/Board"
@onready var oddity_marker: Node3D = $"../OddityMarker"
@onready var anomaly_petals: Node3D = $"../VillageGate/AnomalyPetals"
@onready var world_environment: WorldEnvironment = $"../WorldEnvironment"

var _time := 0.0
var _crown_data: Array[Dictionary] = []
var _petal_data: Array[Dictionary] = []
var _sign_base := Vector3.ZERO
var _oddity_base := Vector3.ZERO
var _fog_base := 0.0

func _ready() -> void:
    var index := 0
    for cedar in trees.get_children():
        var crown := cedar.get_node_or_null("Crown") as Node3D
        if crown:
            _crown_data.append({
                "node": crown,
                "base": crown.rotation,
                "phase": float(index) * 0.73
            })
            index += 1

    index = 0
    for child in anomaly_petals.get_children():
        var petal := child as Node3D
        if petal:
            _petal_data.append({
                "node": petal,
                "position": petal.position,
                "rotation": petal.rotation,
                "phase": float(index) * 1.11
            })
            index += 1

    _sign_base = sign_board.rotation
    _oddity_base = oddity_marker.rotation

    if world_environment.environment:
        _fog_base = world_environment.environment.fog_density

func _process(delta: float) -> void:
    _time += delta

    var sway := deg_to_rad(tree_sway_degrees)
    for data in _crown_data:
        var crown := data["node"] as Node3D
        var base := data["base"] as Vector3
        var phase := float(data["phase"])
        crown.rotation.x = base.x + sin(_time * tree_sway_speed + phase) * sway * 0.55
        crown.rotation.z = base.z + sin(_time * tree_sway_speed * 0.83 + phase * 1.4) * sway

    sign_board.rotation.z = _sign_base.z + sin(_time * 0.55) * deg_to_rad(0.45)

    if not GameState.has_flag("mountain_paper_oddity_seen"):
        oddity_marker.rotation.z = _oddity_base.z + sin(_time * 0.68 + 0.8) * deg_to_rad(1.4)

    if not GameState.has_flag("gate_spatial_anomaly_seen"):
        for data in _petal_data:
            var petal := data["node"] as Node3D
            var base_position := data["position"] as Vector3
            var base_rotation := data["rotation"] as Vector3
            var phase := float(data["phase"])
            petal.position.y = base_position.y + sin(_time * 1.15 + phase) * 0.035
            petal.rotation.y = base_rotation.y + sin(_time * 0.82 + phase) * 0.10
            petal.rotation.z = base_rotation.z + cos(_time * 0.94 + phase) * 0.08

    if world_environment.environment:
        world_environment.environment.fog_density = _fog_base + sin(_time * fog_breathe_speed) * fog_breathe_amount
