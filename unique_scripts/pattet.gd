extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not emitting:
		queue_free()



func _on_timer_timeout():
	queue_free()
