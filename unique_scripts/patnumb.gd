extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = str("+", Global.bigprint(Global.power * Global.mult))
	self.position = Vector2(randf_range(-10, 10), -85)
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(self, "position:y", -200, 1.5)
	tween2.tween_property(self, "modulate:a", 1, 0)
	tween2.tween_property(self, "modulate:a", 0, 1.55)
	#tween.tween_property(self, "position.y", 0, 0)
	#tween.tween_property(self, "position:y", 5000, 1.75)

func _on_timer_timeout():
	queue_free()
