extends TextureButton

@export_category("Information")
@export var title: String
@export var description: String
@export var cost = 0
@export var power: float
@export_range (1,2) var tier: int

@export_category("Technical")
@export var build_req = 0
@export var target_node: PackedScene
@export var debuff_node: PackedScene
var soundnode = preload("res://Scenes/upsound.tscn")
var coin_build

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	coin_build = buildings[0]

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.disabled = (Global.comfort < cost)
	if coin_build == null:
		connect_build()

func timeout():
	if (coin_build.amount >= build_req
	and Global.cpsec > 14):
		self.visible = true
		var debuff = debuff_node.instantiate()
		get_tree().get_nodes_in_group("Debuff")[0].add_child(debuff)
		Global.chocdebuf = true
		$Timer.queue_free()
		$melting.start()

func _on_pressed():
	Global.chocdebuf = false
	coin_build._update(0,power)
	Global.comfort -= cost
	var purchasedver = target_node.instantiate()
	get_tree().get_nodes_in_group("purchased")[0].add_child(purchasedver)
	var soundeffect = soundnode.instantiate()
	get_parent().add_child(soundeffect)
	queue_free()


func _on_melting_timeout():
	coin_build._update(-1,1)

func _on_mouse_entered():
	Popups.UpPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideUpPopup()
