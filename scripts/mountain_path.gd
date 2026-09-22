extends Node3D

@onready var status_label: Label = $HUD/Margin/VBox/Status
@onready var subtitle_label: Label = $HUD/Subtitle
@onready var oddity_marker: MeshInstance3D = $OddityMarker
@onready var anomaly_petals: Node3D = $VillageGate/AnomalyPetals

var gate_triggered := false
var oddity_triggered := false
var overlook_triggered := false
var subtitle_tween: Tween

func _ready() -> void:
    status_label.text = "MOUNTAIN PATH • Animation Pass v0.2"

func _is_player(body: Node3D) -> bool:
    return body != null and body.is_in_group("player")

func _show_subtitle(text_value: String, hold_time: float = 1.1) -> void:
    if subtitle_tween != null and subtitle_tween.is_running():
        subtitle_tween.kill()

    subtitle_label.text = text_value
    subtitle_label.modulate.a = 0.0

    subtitle_tween = create_tween()
    subtitle_tween.tween_property(subtitle_label, "modulate:a", 1.0, 0.18)
    subtitle_tween.tween_interval(hold_time)
    subtitle_tween.tween_property(subtitle_label, "modulate:a", 0.0, 0.36)

func _camera_for(body: Node3D) -> Camera3D:
    return body.get_node_or_null("CameraPivot/Camera3D") as Camera3D

func _visual_for(body: Node3D) -> Node:
    return body.get_node_or_null("VisualRoot")

func _on_oddity_trigger_body_entered(body: Node3D) -> void:
    if oddity_triggered or not _is_player(body):
        return

    oddity_triggered = true
    GameState.set_flag("mountain_paper_oddity_seen", true)
    status_label.text = "Valami megmozdult az ösvény mellett."

    var direction := body.global_position - oddity_marker.global_position
    direction.y = 0.0
    if direction.length() < 0.01:
        direction = Vector3.FORWARD

    var target_yaw := atan2(direction.x, direction.z)
    var tween := create_tween()
    tween.tween_interval(0.38)
    tween.tween_property(oddity_marker, "rotation:y", target_yaw - deg_to_rad(5.0), 0.42).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
    tween.tween_property(oddity_marker, "rotation:y", target_yaw, 0.22).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
    tween.parallel().tween_property(oddity_marker, "rotation:z", deg_to_rad(-7.0), 0.64).set_trans(Tween.TRANS_SINE)

func _on_overlook_narrative_trigger_body_entered(body: Node3D) -> void:
    if overlook_triggered or not _is_player(body):
        return

    overlook_triggered = true
    GameState.set_flag("saw_tsukimori_overlook", true)
    status_label.text = "Kilátópont • Tsukimori"

    var camera := _camera_for(body)
    if camera:
        var original_fov := camera.fov
        var tween := create_tween()
        tween.tween_property(camera, "fov", original_fov - 2.2, 0.85).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
        tween.tween_interval(0.65)
        tween.tween_property(camera, "fov", original_fov, 0.95).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_village_gate_trigger_body_entered(body: Node3D) -> void:
    if gate_triggered or not _is_player(body):
        return

    gate_triggered = true
    GameState.set_flag("entered_tsukimori", true)
    GameState.set_flag("gate_spatial_anomaly_seen", true)
    status_label.text = "Első térbeli anomália • entered_tsukimori = true"

    if body.has_method("request_soft_stop"):
        body.call("request_soft_stop", 0.95)

    _play_gate_anomaly(body)

    var beat := create_tween()
    beat.tween_interval(0.26)
    beat.tween_callback(func():
        var visual := _visual_for(body)
        if visual and visual.has_method("play_gate_react"):
            visual.call("play_gate_react")
    )
    beat.tween_interval(0.34)
    beat.tween_callback(func(): _show_subtitle("„Szél?”", 1.15))

func _play_gate_anomaly(body: Node3D) -> void:
    var camera := _camera_for(body)
    if camera:
        var original_fov := camera.fov
        var camera_tween := create_tween()
        camera_tween.tween_property(camera, "fov", original_fov - 2.6, 0.24).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
        camera_tween.tween_property(camera, "fov", original_fov, 0.62).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

    var index := 0
    for child in anomaly_petals.get_children():
        var petal := child as Node3D
        if petal == null:
            continue

        var away := petal.global_position - body.global_position
        away.y = 0.0
        if away.length() < 0.05:
            away = Vector3.RIGHT

        var target_position := petal.position + away.normalized() * (0.82 + float(index % 3) * 0.16) + Vector3(0.0, 0.10 + float(index % 2) * 0.08, 0.0)
        var target_rotation := petal.rotation + Vector3(
            deg_to_rad(12.0 + index * 2.0),
            deg_to_rad(22.0 + index * 3.0),
            deg_to_rad(18.0 + index * 2.0)
        )

        var tween := create_tween()
        tween.tween_interval(float(index) * 0.025)
        tween.set_parallel(true)
        tween.tween_property(petal, "position", target_position, 0.72).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
        tween.tween_property(petal, "rotation", target_rotation, 0.72).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
        index += 1
