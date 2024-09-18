extends TextureButton
var arti_build
var new_mult
var current_mult

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func _process(_delta):
	if arti_build == null:
		connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	arti_build = buildings[7]
	current_mult = (1+(arti_build.amount * 0.1))

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

func _timeout():
	new_mult = (1+(arti_build.amount * 0.1))
	if new_mult - current_mult != 0:
		Global.mult = (Global.mult*new_mult)/current_mult
		current_mult = new_mult
