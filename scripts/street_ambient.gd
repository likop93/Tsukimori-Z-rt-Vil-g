extends Node

@export var lantern_flicker_strength: float = 0.12
@export var cloth_sway_degrees: float = 4.0
@export var petal_bob: float = 0.08

var _time := 0.0
var _lights: Array[Dictionary] = []
var _cloth: Array[Dictionary] = []
var _petals: Array[Dictionary] = []

func _ready() -> void:
    var street := get_parent()

    var lanterns := street.get_node_or_null("Lanterns")
    if lanterns:
        var index := 0
        for lantern in lanterns.get_children():
            var light := lantern.get_node_or_null("Light") as OmniLight3D
            if light:
                _lights.append({
                    "node": light,
                    "energy": light.light_energy,
                    "phase": float(index) * 1.37
                })
                index += 1

    var hanging := street.get_node_or_null("WindDetails/HangingCloth")
    if hanging:
        var index := 0
        for child in hanging.get_children():
            var cloth := child as Node3D
            if cloth:
                _cloth.append({
                    "node": cloth,
                    "rotation": cloth.rotation,
                    "phase": float(index) * 0.91
                })
                index += 1

    var petals := street.get_node_or_null("WindDetails/Petals")
    if petals:
        var index := 0
        for child in petals.get_children():
            var petal := child as Node3D
            if petal:
                _petals.append({
                    "node": petal,
                    "position": petal.position,
                    "rotation": petal.rotation,
                    "phase": float(index) * 0.67
                })
                index += 1

func _process(delta: float) -> void:
    _time += delta

    for data in _lights:
        var light := data["node"] as OmniLight3D
        var base_energy: float = data["energy"]
        var phase: float = data["phase"]
        var flicker := sin(_time * 2.1 + phase) * 0.55 + sin(_time * 5.3 + phase * 1.7) * 0.18
        light.light_energy = base_energy * (1.0 + flicker * lantern_flicker_strength)

    for data in _cloth:
        var cloth := data["node"] as Node3D
        var base_rotation: Vector3 = data["rotation"]
        var phase: float = data["phase"]
        cloth.rotation.x = base_rotation.x + sin(_time * 0.95 + phase) * deg_to_rad(cloth_sway_degrees * 0.35)
        cloth.rotation.z = base_rotation.z + sin(_time * 0.72 + phase * 1.3) * deg_to_rad(cloth_sway_degrees)

    for data in _petals:
        var petal := data["node"] as Node3D
        var base_position: Vector3 = data["position"]
        var base_rotation: Vector3 = data["rotation"]
        var phase: float = data["phase"]
        petal.position.x = base_position.x + sin(_time * 0.42 + phase) * 0.18
        petal.position.y = base_position.y + sin(_time * 1.05 + phase) * petal_bob
        petal.position.z = base_position.z + cos(_time * 0.36 + phase) * 0.13
        petal.rotation.y = base_rotation.y + _time * (0.25 + fmod(phase, 0.3))
        petal.rotation.z = base_rotation.z + sin(_time * 0.8 + phase) * 0.25
