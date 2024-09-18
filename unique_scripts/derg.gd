extends RigidBody2D
@export var pattet_part: PackedScene

var velocity = Vector2.ZERO
@export var boredom = 0
var destreach = true
var derg_destination
var patcd = false
var ground
var menus

func _ready():
	randomize()
	position = Vector2(randf_range(-1000,1000),randf_range(-300,300))
	_connect_nodes()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if patcd == false:
		if (velocity.x != 0):
			$shadow.visible = false
			$shadow2.visible = true
			$AnimatedSprite2D.animation = "Walk"
			$AnimatedSprite2D.flip_h = velocity.x > 0
			if velocity.x > 0:
				$shadow2.offset.x = 27
			else:
				$shadow2.offset.x = 0
		else:
			$shadow2.visible = false
			$shadow.visible = true
			$AnimatedSprite2D.animation = "Sit"
			$AnimatedSprite2D.flip_h = false
		
	if (boredom > 10):
		_moving()

func _connect_nodes():
	ground = get_tree().get_nodes_in_group("Ground")[0]
	menus = get_tree().get_nodes_in_group("Menus")

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict

func _on_pat():
	add_child(pattet_part.instantiate())
	velocity = Vector2.ZERO
	Global.comfort += Global.power
	boredom = 0
	Global.clicks +=1
	#Animations for starting petting
	patcd = true
	$shadow2.visible = false
	$shadow.visible = true
	$AnimatedSprite2D.animation = "Petstart"
	$Patcooldown.start()

func _moving(): 
	#first select a random valid point within a semi-random range
	if (destreach == true):
		derg_destination = Vector2(global_position.x + randf_range(-600,600),global_position.y + randf_range(-600,600))
		if ((ground.get_rect()).has_point(derg_destination) 
		and _check_viability(menus, derg_destination)):  #try again, if point was not valid. Risks near-infinite loop, but very unlikely
			destreach = false
		_moving()
	velocity = (derg_destination - global_position).normalized()
	move_and_collide(velocity)
	if (derg_destination - global_position).length() < 5:		#start idling after reaching the destination
		boredom -= randf_range(5, 10)
		velocity = Vector2.ZERO
		destreach = true
	
func _check_viability(checkpart, dest):
	for x in checkpart:
		if x.visible and x.get_rect().has_point(dest):
			return false
		else:
			continue
	return true

func _on_boredom_time():
	if (boredom <= 10):
		boredom += randf_range(0.1, 1)

#A small timer for slight delay to petting animation
func _on_patcooldown_timeout():
	$AnimatedSprite2D.play("Petend")

#back to default animation after petting fully finished
func _on_pat_finished():
	if $AnimatedSprite2D.animation == "Petend":
		$AnimatedSprite2D.play("Sit")
		patcd = false
