extends SceneTree

var failures := 0

func _initialize() -> void:
    call_deferred("run_checks")

func expect(condition: bool, message: String) -> void:
    if not condition:
        failures += 1
        push_error(message)

func frames(count: int) -> void:
    for frame in range(count):
        await physics_frame

func run_checks() -> void:
    var main: Node = load("res://scenes/main.tscn").instantiate()
    root.add_child(main)
    await frames(8)

    var visual := main.get_node("MountainPath/Player/VisualRoot")
    var motion := visual.get_node("MotionLayer")
    var placeholder := motion.get_node("PlaceholderBody") as MeshInstance3D

    var has_glb_proxy := motion.has_node("AkiraProxy")
    var has_procedural_proxy := motion.has_node("ProceduralAkiraFallback")

    expect(has_glb_proxy or has_procedural_proxy, "Akira has neither GLB proxy nor procedural fallback")
    expect(not placeholder.visible, "Capsule placeholder remained visible")
    if has_procedural_proxy:
        var fallback := motion.get_node("ProceduralAkiraFallback")
        expect(fallback.has_node("TorsoPivot"), "Procedural Akira torso is missing")
        expect(fallback.has_node("LegL"), "Procedural Akira left leg is missing")
        expect(fallback.has_node("LegR"), "Procedural Akira right leg is missing")
        expect(fallback.has_node("CoatLPivot"), "Procedural Akira coat motion layer is missing")

    print("Portable proxy regression: %s" % ("PASS" if failures == 0 else "%s failures" % failures))
    quit(0 if failures == 0 else 1)
