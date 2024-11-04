extends TextureButton

@export var cost = 0
@export var power: float
@export var build_req = 0
@export var target_node: PackedScene
@export_range (0,7) var target_build = 0
var current_build

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	current_build = buildings[target_build]

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.disabled = (Global.comfort < cost)

func timeout():
	if (current_build.amount >= build_req):
		self.visible = true
		$Timer.queue_free()


func _on_pressed():
	Global.bmod -= power
	Global.comfort -= cost
	var purchasedver = target_node.instantiate()
	get_tree().get_nodes_in_group("purchased")[0].add_child(purchasedver)
	queue_free()
