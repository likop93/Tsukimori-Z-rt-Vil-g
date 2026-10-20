extends "res://tests/ui/hana_day_regression.gd"

func observe() -> void:
    Input.action_press("observe")
    await get_tree().process_frame
    await get_tree().process_frame
    Input.action_release("observe")
    await get_tree().process_frame

func _ready() -> void:
    for choice in ["listen","ask"]:
        preload("res://scripts/ui/chapter_catalog.gd").prepare("village")
        var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
        add_child(runner)
        await get_tree().process_frame
        runner.street.player.position.y = 160
        await observe()
        check(runner.street.location == "bridge","Real flow: street to bridge")
        runner.street.player.position.x = 550
        await get_tree().create_timer(2.8).timeout
        await observe()
        check(runner.street.location == "house","Real flow: bridge to house")
        runner.street.player.position.x = 275
        await get_tree().process_frame
        await observe()
        await get_tree().create_timer(1.8).timeout
        if not is_instance_valid(runner.arrival.vn):
            check(false,"Real flow starts Miyako greeting")
            runner.queue_free()
            await get_tree().process_frame
            continue
        await finish(runner.arrival.vn)
        check(GameState.has_flag("met_miyako"),"Greeting acknowledged")
        await get_tree().process_frame
        await observe()
        await get_tree().create_timer(1.2).timeout
        check(runner.street.location == "interior","Real flow enters home")
        if not is_instance_valid(runner.arrival.vn):
            check(false,"Home dialogue starts")
            runner.queue_free()
            await get_tree().process_frame
            continue
        await finish(runner.arrival.vn,choice)
        check(GameState.has_flag("miyako_interior_dialogue_seen"),"Home choice completes")
        check(GameState.miyako_first_choice == choice,"Choice retained")
        check(GameState.aff_miyako == (1 if choice == "listen" else 0),"Canonical reward")
        runner.queue_free()
        await get_tree().process_frame
    print("CURRENT_ENTRY_AUDIT: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
    get_tree().quit(0 if failures.is_empty() else 1)
