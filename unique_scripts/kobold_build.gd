extends Node

#setting up variables
@export var bcost = 0 #basecost
@export var amount = 0
@export var bpower: float #power before modifications. Increases to this should increase income by a ton
@export var modifier: float #outside increases should affect this value
@export var target_node: PackedScene
var current_cpsec = 0 #notoriety per second
var power = 0 #current power
var cost
var cost_multiplier = 1
var mushrooms

# Called when the node enters the scene tree for the first time.
func _ready():
	cost = bcost
	power = bpower * modifier
	self.visible = ((0.1 + Global.cpsec) >= cost/100)
	get_node("C").text = str(snapped(cost,0.1))
	connect_build()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.disabled = (Global.comfort < cost)
	if mushrooms == null:
		connect_build()

func connect_build():
	mushrooms = get_tree().get_nodes_in_group("Building")[3]

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
		"cost_multiplier" : cost_multiplier,
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
		get_node("C").text = str(snapped(cost,0.1))
		get_node("P").text = str("+", snapped(power, 0.1), " C/s")
		get_node("A").text = str(amount)

func _on_pressed():
	Global.comfort -= cost
	_update(1, 1)

func _on_timer_timeout():
	if ((Global.cpsec) >= cost/100):
		self.visible = true
		$Timer.queue_free()

#kobold hunger function. If mushroom buildings drop to 0 "the kobolds go hungry" 
#start a protest and drop their income to 25%
func _on_mealt_timeout():
	if (mushrooms.amount < 1
	and Global.protest == false
	and Global.hunger == true):
		_update(0, 0.25)
		var debuff = target_node.instantiate()
		get_tree().get_nodes_in_group("Debuff")[0].add_child(debuff)
		Global.protest = true
		Global.nofoodcount += 1
		#päivitä tooltip lisäämään huomautus kobolttien nälästä
	if (mushrooms.amount > 0
	and Global.protest == true
	and Global.hunger == true):
		_update(0, 4)
		Global.protest = false
		#tooltip takaisin normaaliksi

func _on_hunger_timeout():
	if (amount > 0):
		Global.hunger = true
		$Hungert.queue_free()

func _autoupdate():
	_update(0,1)