extends TextureRect

@export_category("Information")
@export var title: String
@export var description: String
@export var cost = 0
@export_range (1,2) var tier: int

var current_amount
var new_amount
var gold_build
var chest_build

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func _process(_delta):
	if (chest_build == null
	or gold_build == null):
		connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	gold_build = buildings[0]
	chest_build = buildings[6]
	current_amount = chest_build.amount

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
	}
	return save_dict

func _on_timer_timeout():
	new_amount = chest_build.amount
	if new_amount - current_amount != 0:
		gold_build.bpower += (new_amount - current_amount)
		current_amount = new_amount

func _on_mouse_entered():
	Popups.UpPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideUpPopup()
