extends Node

#setting up variables
@export var bcost = 0 #basecost
@export var amount = 0
@export var bpower: float #power before modifications. Increases to this should increase income by a ton
@export var modifier: float #outside increases should affect this value
var current_cpsec = 0 #notoriety per second
var power = 0 #current power
var cost
var cost_multiplier = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	cost = bcost * (1+ Global.bmod * cost_multiplier) ** amount
	power = bpower * modifier
	self.visible = ((0.1 + Global.cpsec) >= cost/100)
	if str(snapped(cost, 1)).length() < 6:
		get_node("C").text = str(snapped(cost,0.1))
	else:
		get_node("C").text = Global.bigprint(cost)

	if str(snapped(power,1)).length() < 6:
		get_node("P").text = str("+", snapped(power,0.1), "C/s")
	else:
		get_node("P").text = str("+", Global.bigprint(power), "C/s")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.disabled = (Global.comfort < cost)

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"bcost" : bcost,
		"amount" : amount,
		"bpower" : bpower,
		"modifier" : modifier,
		"current_cpsec" : current_cpsec,
		"power" : power,
		"cost" : cost,
		"cost_multiplier" : cost_multiplier
	}
	return save_dict

# Used to change values of the building. If something affects this from outside this script, 
# it happens through here
func _update(famount, fmodifier):
	if (amount + famount < 0):
		return
	else:
		amount += famount
		if amount < 0:
			amount = 0
		modifier *= fmodifier
		power = bpower * modifier
		Global.cpsec += amount * power - current_cpsec
		current_cpsec = power * amount
		cost = bcost * (1+ Global.bmod * cost_multiplier) ** amount
		#update text fields at end
		if str(snapped(cost, 1)).length() < 6:
			get_node("C").text = str(snapped(cost,0.1))
		else:
			get_node("C").text = Global.bigprint(cost)

		if str(snapped(power,1)).length() < 6:
			get_node("P").text = str("+", snapped(power,0.1), "C/s")
		else:
			get_node("P").text = str("+", Global.bigprint(power), "C/s")
		get_node("A").text = str(amount)

func _on_pressed():
	#multipurchase if shift held down. while loop it, so you can for example buy 7 if money runs out.
	if Input.is_action_pressed("multibuy"):
		var i = 0
		while i < 10 and Global.comfort > cost:
			Global.comfort -= cost
			_update(1, 1)
			i += 1
	else:	
		Global.comfort -= cost
		_update(1, 1)

#multipurchase if shift held down. while loop it, so you can for example buy 7 if money runs out.
func _on_multipressed():
	pass

func _on_timer_timeout():
	if ((Global.cpsec) >= cost/100):
		self.visible = true
		$Timer.queue_free()
		
func _autoupdate():
	_update(0,1)
