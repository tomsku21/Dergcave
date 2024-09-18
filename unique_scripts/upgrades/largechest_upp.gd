extends TextureButton
var current_mult
var new_mult
var gold_build
var chest_build

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func _process(_delta):
	if (gold_build == null
	or chest_build == null):
		connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	gold_build = buildings[0]
	chest_build = buildings[6]
	current_mult = (1 +(0.5 *  chest_build.amount ** 0.5))

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

func _on_timer_timeout():
	new_mult = (1 +(0.5 *  chest_build.amount ** 0.5))
	if new_mult - current_mult != 0:
		gold_build.modifier *= (gold_build.modifier*new_mult)/current_mult
		current_mult = new_mult