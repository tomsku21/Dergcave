extends TextureButton

@export_category("Information")
@export var title: String
@export var description: String
@export var cost = 0
@export_range (1,2) var tier: int

@export_category("Technical")
@export var build_req = 0
@export var target_node: PackedScene

var arti_build
var spawner

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_all()

func connect_all():
	var buildings = get_tree().get_nodes_in_group("Building")
	arti_build = buildings[7]
	spawner = get_tree().get_first_node_in_group("Spawner")

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.disabled = (Global.notoriety < cost)
	if arti_build == null:
		connect_all()

func timeout():
	if (arti_build.amount >= build_req):
		self.visible = true
		$Timer.queue_free()


func _on_pressed():
	spawner._newdurgon()
	Global.notoriety -= cost
	var purchasedver = target_node.instantiate()
	get_tree().get_nodes_in_group("purchased")[0].add_child(purchasedver)
	queue_free()

func _on_mouse_entered():
	Popups.UpPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideUpPopup()
