extends TextureButton

@export_category("Information")
@export var title: String
@export var description: String
@export var bcost = 0 #basecost
@export var cost: float
@export var amount = 0
@export var bpower: float #power before modifications. Increases to this should increase income by a ton
@export var power = 0 #current power
@export var modifier: float #outside increases should affect this value
@export_range (1,2) var tier: int

@export_category("Technical")
@export var target_node: PackedScene
var income = 0 #Comfort per second
var cost_multiplier = 1
var mushrooms
var costx10: float

# Called when the node enters the scene tree for the first time.
func _ready():
	cost = bcost * (1 + Global.bmod * cost_multiplier) ** amount
	costx10 = snapped((bcost * (((1 + Global.bmod) ** (amount + 10)) - (1 + Global.bmod) ** amount)) / (Global.bmod), 0.01)
	power = bpower * modifier
	self.visible = ((0.1 + Global.cpsec) >= cost/100)
	get_node("C").text = Global.bigprint(cost)
	get_node("P").text = str("+", Global.bigprint(power), "C/s")
	get_node("A").text = str(amount)
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
		"income" : income,
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
		Global.cpsec += amount * power - income
		income = power * amount
		cost = bcost * (1 + Global.bmod * cost_multiplier) ** amount
		costx10 = snapped((bcost * (((1 + Global.bmod) ** (amount + 10)) - (1 + Global.bmod) ** amount)) / (Global.bmod), 0.01)
		#update text fields at end
		get_node("C").text = Global.bigprint(cost)
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

func _on_mouse_entered():
	Popups.BuildPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideBuildPopup()
