extends TextureRect

@export_category("Information")
@export var title: String
@export var description: String
@export var cost = 0
@export var bboost = 0 #increase to clicking power untied to income
@export_range (1,2) var tier: int

var old_boost
var new_boost

func _ready():
	old_boost = Global.cpsec * 0.02 + bboost

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

func _timeout():
	new_boost = Global.cpsec * 0.02 + bboost
	if old_boost - new_boost != 0:
		Global.power += new_boost - old_boost
		old_boost = new_boost

func _on_mouse_entered():
	Popups.UpPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideUpPopup()
