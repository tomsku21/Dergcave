extends TextureRect

@export_category("Information")
@export var title: String
@export var description: String
@export var cost = 0
@export_range (1,2) var tier: int

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

func _on_mouse_entered():
	Popups.UpPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideUpPopup()
