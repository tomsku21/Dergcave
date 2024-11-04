extends TextureButton

@export_category("Information")
@export var title: String
@export var description: String
@export var cost = 0
@export_range (1,2) var tier: int

@export_category("Technical")
@export var build_req = 0
@export var target_node: PackedScene
@export var debuff_node: PackedScene
var gem_build
var kobold_build

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	kobold_build = buildings[2]
	gem_build = buildings[1]

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
	if (gem_build.amount >= build_req
	and Global.kobamount >= 3):
		self.visible = true
		var debuff = debuff_node.instantiate()
		get_tree().get_nodes_in_group("Debuff")[0].add_child(debuff)
		Global.gemdebuf = true
		gem_build.update(0,0.5)
		kobold_build.update(0,0.5)
		$Timer.queue_free()


func _on_pressed():
	gem_build.modifier *= (1 +(0.75 *  kobold_build.amount ** 0.75))
	#remove debuff icon
	Global.gemdebuf = false
	gem_build.update(0,2)
	gem_build.update(0,2)
	Global.comfort -= cost
	var purchasedver = target_node.instantiate()
	get_tree().get_nodes_in_group("purchased")[0].add_child(purchasedver)
	queue_free()

func _on_mouse_entered():
	Popups.UpPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideUpPopup()
