extends TextureButton
var fieldkobs

func _on_timer_timeout():
	fieldkobs = get_tree().get_nodes_in_group("Kobold")
	for kob in fieldkobs:
		kob._wizzedup()

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict
