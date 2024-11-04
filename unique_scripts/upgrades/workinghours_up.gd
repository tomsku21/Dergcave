extends TextureButton

@export_category("Information")
@export var title: String
@export var description: String
@export var cost = 0
@export_range (1,2) var tier: int

@export_category("Technical")
@export var target_node: PackedScene
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
	if kobold_build == null:
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

func _on_mouse_entered():
	Popups.UpPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideUpPopup()
