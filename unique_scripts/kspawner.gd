extends Node
@export_range (0,7) var target_build = 0
@export var fieldkob: PackedScene
@export var fieldderg: PackedScene
var current_build

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.dergamount == 0:
		_newdurgon()
	connect_build()

func _process(_delta):
	if current_build == null:
		connect_build()

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	current_build = buildings[target_build]

#spawn a new kobold for every 10 kobold buildings purchased. Also one for the first building.
func _on_timer_timeout():
	if(current_build.amount >= (Global.kobamount*10)
	and current_build.amount > 0):
		add_child(fieldkob.instantiate())
		Global.kobamount += 1

#spawns another dragon, functionally just for decoration/vanity
#used for an upgrade
func _newdurgon():
	add_child(fieldderg.instantiate())
	Global.dergamount += 1

