extends TextureButton
var kobold_build
var workwork = true

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func _process(_delta):
	if workwork == true:
		$Onwork.start()
	else:
		$Offwork.start()
	if kobold_build == null:
		connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	kobold_build = buildings[2]

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"workwork" : workwork
	}
	return save_dict

#swaps between 8 minutes 25 kobold income and 16 minutes of global 25% boost
func _on_work_timer():
	workwork = false
	kobold_build.bpower -= 25
	Global.mult *= 1.25

func _off_work_timer():
	workwork = true
	kobold_build.bpower += 25
	Global.mult /= 1.25
