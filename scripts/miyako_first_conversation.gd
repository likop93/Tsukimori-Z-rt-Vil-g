extends CanvasLayer

# Ren'Py: game/canonical_html_story.rpy, canonical_html_chapter_1.
# The greeting plays in the 3D scene; these are its immediately following lines.
signal completed

const FIRST_MEETING = preload("res://assets/vn/ch1_first_meeting.webp")
const HOUSE_INTERIOR = preload("res://assets/vn/ch1_interior.webp")

const INTRO_LINES = [
    {"who": "", "text": "Nem úgy hatott, mint egy gyászoló özvegy a falusi történetekből. Nem tört meg, nem omlott össze. Valami sötét, csendes fegyelem ült rajta."},
    {"who": "", "text": "A ház belsejében azonnal megcsapta a tea, a papír és a régi fa illata. De a csöndben volt valami többlet, amitől Akira háta mentén finom hideg futott végig."},
    {"who": "Miyako", "text": "Itt az emberek túl sokáig hallgattak. És túl sokáig beszéltek rossz nyelven a saját testükről."},
    {"who": "Akira", "text": "A mondat túl pontos volt ahhoz, hogy udvarias bevezetésnek vegyem."},
]

const SILENCE_LINES = [
    {"who": "", "text": "Akira hallgatott. Ezt a csendet a városban taktikának nevezte volna. Itt inkább figyelmes tiszteletnek érződött."},
    {"who": "Miyako", "text": "Fáradt vagy az úttól. Majd holnap többet mesélek a házról."},
]

const QUESTION_LINES = [
    {"who": "Akira", "text": "Milyen nyelven beszéltek eddig a testükről?"},
    {"who": "Miyako", "text": "Olyanon, ami mindig másnak szólt. Sosem nekik."},
    {"who": "", "text": "Miyako már el is fordult, mintha többet nem akarna mondani az első estén."},
]

var _background: TextureRect
var _speaker: Label
var _body: Label
var _next: Button
var _choices: VBoxContainer
var _lines: Array = []
var _index := 0
var _choice_pending := false
var _finished := false

func _ready() -> void:
    layer = 10
    set_process_unhandled_input(false)
    _build_ui()
    _lines = INTRO_LINES.duplicate(true)
    _show_line()
    call_deferred("_arm_input")

func _arm_input() -> void:
    set_process_unhandled_input(true)
    _next.grab_focus()

func _build_ui() -> void:
    var canvas := Control.new()
    canvas.set_anchors_preset(Control.PRESET_FULL_RECT)
    canvas.mouse_filter = Control.MOUSE_FILTER_STOP
    add_child(canvas)

    _background = TextureRect.new()
    _background.set_anchors_preset(Control.PRESET_FULL_RECT)
    _background.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    _background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
    _background.texture = FIRST_MEETING
    _background.mouse_filter = Control.MOUSE_FILTER_IGNORE
    canvas.add_child(_background)

    var shade := ColorRect.new()
    shade.set_anchors_preset(Control.PRESET_FULL_RECT)
    shade.color = Color(0.035, 0.047, 0.078, 0.17)
    shade.mouse_filter = Control.MOUSE_FILTER_IGNORE
    canvas.add_child(shade)

    var box := PanelContainer.new()
    box.anchor_left = 0.075
    box.anchor_right = 0.925
    box.anchor_top = 0.61
    box.anchor_bottom = 0.965
    var frame := StyleBoxFlat.new()
    frame.bg_color = Color(0.055, 0.064, 0.09, 0.93)
    frame.border_color = Color(0.73, 0.58, 0.39, 0.8)
    frame.set_border_width_all(2)
    frame.set_corner_radius_all(9)
    frame.set_content_margin_all(20)
    box.add_theme_stylebox_override("panel", frame)
    canvas.add_child(box)

    var layout := VBoxContainer.new()
    layout.add_theme_constant_override("separation", 8)
    box.add_child(layout)

    _speaker = Label.new()
    _speaker.add_theme_color_override("font_color", Color(0.87, 0.71, 0.48))
    _speaker.add_theme_font_size_override("font_size", 20)
    layout.add_child(_speaker)

    _body = Label.new()
    _body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    _body.size_flags_vertical = Control.SIZE_EXPAND_FILL
    _body.add_theme_color_override("font_color", Color(0.96, 0.94, 0.89))
    _body.add_theme_font_size_override("font_size", 23)
    layout.add_child(_body)

    _choices = VBoxContainer.new()
    _choices.add_theme_constant_override("separation", 5)
    layout.add_child(_choices)

    _next = Button.new()
    _next.text = "Tovább  ›"
    _next.focus_mode = Control.FOCUS_ALL
    _next.pressed.connect(_advance)
    layout.add_child(_next)

func _show_line() -> void:
    if _index >= _lines.size():
        if GameState.miyako_first_choice.is_empty():
            _show_choices()
        else:
            _finish()
        return
    _background.texture = FIRST_MEETING if GameState.miyako_first_choice.is_empty() and _index == 0 else HOUSE_INTERIOR
    var line: Dictionary = _lines[_index]
    _speaker.text = str(line["who"]) if not str(line["who"]).is_empty() else "TSUKIMORI"
    _body.text = str(line["text"])
    _next.text = "Befejezés  ›" if not GameState.miyako_first_choice.is_empty() and _index == _lines.size() - 1 else "Tovább  ›"

func _advance() -> void:
    if _finished or _choice_pending:
        return
    _index += 1
    _show_line()

func _show_choices() -> void:
    _choice_pending = true
    _background.texture = HOUSE_INTERIOR
    _speaker.text = "AKIRA DÖNTÉSE"
    _body.text = "Akira nem szólt azonnal. Mit tesz?"
    _next.hide()
    var silence := Button.new()
    silence.text = "1  Csendben marad, és hagyja, hogy Miyako folytassa."
    silence.pressed.connect(_choose.bind("silence"))
    _choices.add_child(silence)
    var question := Button.new()
    question.text = "2  Visszakérdez: milyen nyelven beszéltek eddig?"
    question.pressed.connect(_choose.bind("question"))
    _choices.add_child(question)
    silence.grab_focus()

func _choose(choice: String) -> void:
    if not _choice_pending or not GameState.choose_miyako_first_response(choice):
        return
    _choice_pending = false
    for button in _choices.get_children():
        button.queue_free()
    _next.show()
    _lines = SILENCE_LINES.duplicate(true) if choice == "silence" else QUESTION_LINES.duplicate(true)
    _index = 0
    _show_line()
    _next.grab_focus()

func _finish() -> void:
    if _finished:
        return
    _finished = true
    completed.emit()

func _unhandled_input(event: InputEvent) -> void:
    if _finished or not event is InputEventKey:
        return
    var key := event as InputEventKey
    if not key.pressed or key.echo:
        return
    if _choice_pending and key.keycode in [KEY_1, KEY_KP_1, KEY_2, KEY_KP_2]:
        _choose("silence" if key.keycode in [KEY_1, KEY_KP_1] else "question")
        get_viewport().set_input_as_handled()
    elif not _choice_pending and key.keycode in [KEY_ENTER, KEY_KP_ENTER, KEY_SPACE]:
        _advance()
        get_viewport().set_input_as_handled()
