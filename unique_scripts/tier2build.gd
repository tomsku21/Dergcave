extends Node

#setting up variables
@export var bcost = 0 #basecost
@export var amount = 0
@export var bpower: float #power before modifications. Increases to this should increase income by a ton
@export var modifier: float #outside increases should affect this value
var current_nsec = 0 #notoriety per second
var power = 0 #current power
var cost
var cost_multiplier = 1
var gold #gold building, this building uses gold amount for cost.

# Called when the node enters the scene tree for the first time.
func _ready():
	cost = bcost
	power = bpower * modifier
	get_node("C").text = str(snapped(cost,1))
	get_node("P").text = str("+", snapped(power, 0.1), " N/s")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	gold = get_tree().get_nodes_in_group("Building")[0]
	self.disabled = (gold.amount < cost)
	cost = bcost * (1 + Global.nbmod * cost_multiplier) ** amount
	get_node("C").text = str(snapped(cost,0.1))
	get_node("P").text = str("+", snapped(power, 0.1), " N/s")

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"bcost" : bcost,
		"amount" : amount,
		"bpower" : bpower,
		"modifier" : modifier,
		"current_cpsec" : current_nsec,
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
		Global.nsec += amount * power - current_nsec
		current_nsec = power * amount
		#update text at the end
		get_node("A").text = str(amount)

func _on_pressed():
	#if Global.pats >= cost:
	gold._update(-cost,1)
	_update(1, 1)

func _on_timer_timeout():
	if (gold.amount >= cost - 10):
		self.visible = true
		$Timer.queue_free()

func _autoupdate():
	_update(0,1)