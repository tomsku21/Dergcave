extends TextureButton
var current_mult
var new_mult
var bone_build


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func _process(_delta):
	if bone_build == null:
		connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	bone_build = buildings[4]
	current_mult = (1 +(0.5 *  bone_build.amount ** 0.5))

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

func _on_timer_timeout():
	new_mult = (1 +(0.5 *  bone_build.amount ** 0.5))
	if new_mult - current_mult != 0:
		Global.mult = (Global.mult*new_mult)/current_mult
		current_mult = new_mult
