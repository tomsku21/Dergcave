extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Score.text = str(snapped(Global.comfort,0.1))
	$petSpeed.text = str(snapped(Global.cpsec * Global.mult,0.1), "/s")
	$NotHud/notScore.text = str(snapped(Global.notoriety,0.1))
	$NotHud/notSpeed.text = str(snapped(Global.nsec * Global.mult,0.1), "/s")
	

