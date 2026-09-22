extends Node3D

@onready var status_label: Label = $HUD/Margin/VBox/Status

var gate_triggered := false

func _ready() -> void:
    status_label.text = "BLOCKOUT • Hegyi ösvény → Tsukimori kapuja"

func _on_village_gate_trigger_body_entered(body: Node3D) -> void:
    if gate_triggered:
        return
    if not body.is_in_group("player"):
        return

    gate_triggered = true
    GameState.set_flag("entered_tsukimori", true)
    status_label.text = "Első anomália: ‘Szél?’ • entered_tsukimori = true"

    # Tudatosan csak minimális prototípus-effekt.
    # A végleges változatban itt köd/szirom/tértorzulás dolgozik majd.
    var camera := body.get_node_or_null("CameraPivot/Camera3D") as Camera3D
    if camera:
        var original_fov := camera.fov
        var tween := create_tween()
        tween.tween_property(camera, "fov", original_fov - 3.0, 0.18)
        tween.tween_property(camera, "fov", original_fov, 0.45)
