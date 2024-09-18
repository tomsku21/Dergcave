extends TextureRect

func _ready():
	self.visible = false

#Pops notoriety hud above normal bank info with a small animation
#after player starts gaining notoriety
func _notorietywaiter():
	if(Global.notoriety > 0):
		self.visible = true
		var tween = create_tween()
		tween.tween_property(self, "position:y", -92, 0.5).set_ease(Tween.EASE_IN)
		$Timer.queue_free()
