extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.soundeff == true:
		%Tap.play()

func _timeout():
	self.queue_free()
