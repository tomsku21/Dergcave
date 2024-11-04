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

#setting up variables
var costx10: float
var income = 0 #Notoriety per second
var cost_multiplier = 1
var gold #gold building, this building uses gold amount for cost.

# Called when the node enters the scene tree for the first time.
func _ready():
	cost = bcost * (1+ Global.nbmod * cost_multiplier) ** amount
	costx10 = snapped((bcost * (((1 + Global.nbmod) ** (amount + 10)) - (1 + Global.nbmod) ** amount)) / (Global.nbmod), 0.01)
	power = bpower * modifier
	get_node("C").text = Global.bigprint(cost)
	get_node("P").text = str("+", snapped(power, 0.1), " N/s")
	get_node("A").text = str(amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	gold = get_tree().get_nodes_in_group("Building")[0]
	self.disabled = (gold.amount < cost)


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
		Global.nsec += amount * power - income
		income = power * amount
		cost = bcost * (1 + Global.nbmod * cost_multiplier) ** amount
		costx10 = snapped((bcost * (((1 + Global.nbmod) ** (amount + 10)) - (1 + Global.nbmod) ** amount)) / (Global.nbmod), 0.01)
		#update text fields at end
		get_node("C").text = Global.bigprint(cost)
		get_node("P").text = str("+", Global.bigprint(power), "N/s")
		get_node("A").text = str(amount)

func _on_pressed():
	#multipurchase if shift held down. while loop it, so you can for example buy 7 if money runs out.
	if Input.is_action_pressed("multibuy"):
		var i = 0
		while i < 10 and gold.amount > cost:
			gold._update(-cost,1)
			_update(1, 1)
			i += 1
	else:	
		gold._update(-cost,1)
		_update(1, 1)

func _on_timer_timeout():
	if (gold.amount >= cost - 10):
		self.visible = true
		$Timer.queue_free()

func _autoupdate():
	_update(0,1)

func _on_mouse_entered():
	Popups.BuildPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)
	
func _on_mouse_exited():
	Popups.HideBuildPopup()
