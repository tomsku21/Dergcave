extends TextureButton
var current_mult
var new_mult
var gem_build
var kobold_build


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func _process(_delta):
	if (kobold_build == null
	or gem_build == null):
		connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	gem_build = buildings[1]
	kobold_build = buildings[2]
	current_mult = (1 +(0.75 *  kobold_build.amount ** 0.75))

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

func _on_timer_timeout():
	new_mult = (1 +(0.75 *  gem_build.amount ** 0.75))
	if new_mult - current_mult != 0:
		gem_build.modifier = (gem_build.modifier*new_mult)/current_mult
		current_mult = new_mult
