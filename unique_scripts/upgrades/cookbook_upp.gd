extends TextureButton
var current_mult
var new_mult
var kobold_build
var mush_build

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func _process(_delta):
	if (kobold_build == null
	or mush_build == null):
		connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	kobold_build = buildings[2]
	mush_build = buildings[3]
	current_mult = (1 +(0.6 *  mush_build.amount ** 0.6))

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

func _on_timer_timeout():
	new_mult = (1 +(0.6 *  mush_build.amount ** 0.6))
	if current_mult - new_mult != 0:
		kobold_build.modifier = (kobold_build.modifier*new_mult)/current_mult
		current_mult = new_mult
