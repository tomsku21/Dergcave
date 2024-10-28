extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#comfort
	if str(snapped(Global.comfort, 1)).length() < 6:
		$Score.text = str(snapped(Global.comfort,0.1))
	else:
		$Score.text = Global.bigprint(Global.comfort)
	#comfort per second
	if str(snapped(Global.cpsec * Global.mult,1)).length() < 6:
		$petSpeed.text = str(snapped(Global.cpsec * Global.mult,0.1), "/s")
	else:
		$petSpeed.text = str(Global.bigprint(Global.cpsec * Global.mult), "/s")
	#notoriety
	if str(snapped(Global.notoriety, 1)).length() < 6:
		$NotHud/notScore.text = str(snapped(Global.notoriety,0.1))
	else:
		$NotHud/notScore.text = Global.bigprint(Global.notoriety)
	#notoriety per second
	if str(snapped(Global.nsec * Global.mult,1)).length() < 6:
		$NotHud/notSpeed.text = str(snapped(Global.nsec * Global.mult,0.1), "/s")
	else:
		$NotHud/notSpeed.text = str(Global.bigprint(Global.nsec * Global.nmult), "/s")
	

