extends TextureButton

@export var cost = 0
@export var build_req = 0
@export var target_node: PackedScene
var tome_build
var bone_build

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	tome_build = buildings[5]
	bone_build = buildings[4]

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.disabled = (Global.notoriety < cost)
	if (tome_build == null
	or bone_build == null):
		connect_build()

func timeout():
	if (tome_build.amount >= build_req):
		self.visible = true
		$Timer.queue_free()


func _on_pressed():
	Global.mult *= (1+ (0.5 * bone_build ** 0.5))
	Global.notoriety -= cost
	var purchasedver = target_node.instantiate()
	get_tree().get_nodes_in_group("purchased")[0].add_child(purchasedver)
	queue_free()
