extends Sprite2D
#asetettava node, joka kertoo et minkä rakennuksen määrän mukaan ilmestyy
#MAYBE: sprite sheet useamman tierin versiosta. 1kpl->50kpl jne
#for now vain yksi
#derg interaktiot tapahtuvat dergin puolella.
@export_range (0,7) var target_build = 0
var current_build
var effect

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_build()
	self.visible = false

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	current_build = buildings[target_build]

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict


func timeout():
	if current_build == null:
		connect_build()
	if (current_build.amount > 9):
		self.visible = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate:a", 0, 0)
		tween.tween_property(self, "modulate:a", 1, 0.2)
		$Timer.queue_free()
