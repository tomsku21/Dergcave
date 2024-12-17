extends TextureRect

@export_category("Information")
@export var title: String
@export var description: String
@export var cost = 0
@export_range (1,2) var tier: int

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
	current_mult = (1 +(0.25 *  gem_build.amount ** 0.5))

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

func _on_timer_timeout():
	new_mult = (1 +(0.25 *  gem_build.amount ** 0.5))
	if new_mult - current_mult != 0:
		kobold_build.modifier = (kobold_build.modifier*new_mult)/current_mult
		current_mult = new_mult

func _on_mouse_entered():
	Popups.UpPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideUpPopup()
