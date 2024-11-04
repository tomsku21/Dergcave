extends TextureRect

@export_category("Information")
@export var title: String
@export var description: String
@export var cost = 0
@export_range (1,2) var tier: int

var kobold_build
var workwork = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func _process(_delta):
	if Global.hunger == true and workwork == false:
		$Onwork.start()
		workwork = true
	if Global.hunger == false and workwork == false:
		$Offwork.start()
		workwork = true
	if kobold_build == null:
		connect_build()
	

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	kobold_build = buildings[2]

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

#swaps between 8 minutes 25 kobold income and 16 minutes of global 25% boost
func _on_work_timer():
	Global.hunger = false
	kobold_build.bpower -= 25
	Global.mult *= 1.25
	workwork = false
	

func _off_work_timer():
	Global.hunger = true
	kobold_build.bpower += 25
	Global.mult /= 1.25
	workwork = false

func _on_mouse_entered():
	Popups.UpPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideUpPopup()
