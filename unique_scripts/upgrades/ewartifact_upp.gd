extends TextureButton
var current_increase
var new_increase
var arti_build
var kobold_build

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func _process(_delta):
	if (arti_build == null
	or kobold_build == null):
		connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	kobold_build = buildings[2]
	arti_build = buildings[7]
	current_increase = arti_build.amount**1.125

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

func _on_timer_timeout():
	new_increase = arti_build.amount**1.125
	if current_increase - new_increase != 0:
		kobold_build.bpower += new_increase - current_increase
		current_increase = new_increase
