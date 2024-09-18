extends TextureButton

@export var cost = 0
@export var bcboost = 0
@export var target_node: PackedScene
@export var click_req = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.disabled = (Global.comfort < cost)

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

func timeout():
	if (Global.clicks >= click_req):
		self.visible = true
		$Timer.queue_free()


func _on_pressed():
	Global.power += Global.cpsec * 0.02 + bcboost
	Global.comfort -= cost
	var purchasedver = target_node.instantiate()
	get_tree().get_nodes_in_group("purchased")[0].add_child(purchasedver)
	queue_free()
