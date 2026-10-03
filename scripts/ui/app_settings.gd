extends Node
const CONFIG_PATH := "user://settings.cfg"
var volume := 0.8
var fullscreen := false

func _ready() -> void:
	var config := ConfigFile.new()
	if config.load(CONFIG_PATH) == OK:
		volume = clampf(float(config.get_value("audio","volume",0.8)),0,1)
		fullscreen = bool(config.get_value("display","fullscreen",false))
	apply_volume()
	apply_display()

func set_volume(value: float) -> void:
	volume = clampf(value,0,1)
	apply_volume()

func apply_volume() -> void:
	AudioServer.set_bus_volume_db(0,linear_to_db(maxf(volume,0.0001)))
	AudioServer.set_bus_mute(0,volume <= 0.001)

func set_fullscreen(value: bool) -> void:
	fullscreen = value
	apply_display()

func apply_display() -> void:
	if DisplayServer.get_name() != "headless":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)

func save_settings() -> Error:
	var config := ConfigFile.new()
	config.set_value("audio","volume",volume)
	config.set_value("display","fullscreen",fullscreen)
	return config.save(CONFIG_PATH)
