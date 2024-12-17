extends TextureRect

@export_category("Information")
@export var title: String
@export var description: String
@export var effect: String

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.chocdebuf == false:
		queue_free()

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

func _on_mouse_entered():
	Popups.DebuffPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideDebuffPopup()
