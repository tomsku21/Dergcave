extends TextureButton

@export var cost = 0
@export var target_node: PackedScene
var build_req = 40
var gem_build
var kobold_build

# Called when the node enters the scene tree for the first time.
func _ready():
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.disabled = (Global.comfort < cost)
	if (gem_build == null 
	or kobold_build == null):
		connect_build()

func timeout():
	if (Global.nofoodcount >= 3
	and Global.kobamount >= 2):
		self.visible = true
		$Timer.queue_free()


func _on_pressed():
	kobold_build.bpower += 25
	Global.comfort -= cost
	var purchasedver = target_node.instantiate()
	get_tree().get_nodes_in_group("purchased")[0].add_child(purchasedver)
	queue_free()