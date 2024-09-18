extends TextureRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.protest == false:
		queue_free()
