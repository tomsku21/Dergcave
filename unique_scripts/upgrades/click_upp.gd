extends TextureRect

var old_boost
var new_boost
@export var bboost = 0 #increase to clicking power untied to income

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
