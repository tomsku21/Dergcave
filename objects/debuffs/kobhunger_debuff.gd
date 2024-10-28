extends TextureRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.protest == false:
		queue_free()

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict
