extends SceneTree
func _initialize():
	for item in ProjectSettings.get_property_list():
		if 'shader' in item.name and 'cache' in item.name:
			print(item.name, '=', ProjectSettings.get_setting(item.name))
	quit()
