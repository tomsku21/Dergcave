extends TextureButton

@export_category("Information")
@export var title: String
@export var description: String
@export var cost = 0
@export_range (1,2) var tier: int

@export_category("Technical")
@export var build_req = 0
@export var target_node: PackedScene
var chest_build
var coin_build

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	chest_build = buildings[6]
	coin_build = buildings[0]

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.disabled = (Global.notoriety < cost)
	if (chest_build == null
	or coin_build):
		connect_build()

func timeout():
	if (chest_build.amount >= build_req):
		self.visible = true
		$Timer.queue_free()


func _on_pressed():
	coin_build.modifier *= 1+(0.5*chest_build.amount**0.5)
	Global.notoriety -= cost
	var purchasedver = target_node.instantiate()
	get_tree().get_nodes_in_group("purchased")[0].add_child(purchasedver)
	queue_free()

func _on_mouse_entered():
	Popups.UpPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideUpPopup()
