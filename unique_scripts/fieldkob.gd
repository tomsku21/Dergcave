extends RigidBody2D

var velocity = Vector2.ZERO
@export var boredom = 0
var destreach = true
var kob_destination
var walk_pass = false
var wizzed = false #upgrade related
var kobold_build
var ground

func _ready():
	randomize()
	position = Vector2(randf_range(-500,500),randf_range(-300,300))
	$AnimatedSprite2D.play("sit")
	connect_build()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if velocity.x != 0:
		if wizzed == true:
			$AnimatedSprite2D.play("wizwalk")
		else:
			$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
	if (boredom > 20
	and walk_pass == true):
		_moving()
	
	if kobold_build == null:
		connect_build()

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"wizzed" : wizzed
	}
	return save_dict

func connect_build():
	var buildings = get_tree().get_nodes_in_group("Building")
	kobold_build = buildings[2]
	ground = get_tree().get_nodes_in_group("Ground")[0]

func _moving():
	#first select a random valid point within a semi-random range
	if (destreach == true):
		kob_destination = Vector2(global_position.x + randf_range(-600,600),global_position.y + randf_range(-600,600))
		if (ground.get_rect().has_point(kob_destination)): #try again, if point was not valid. Risks near-infinite loop, but very unlikely
			destreach = false
		_moving()
	velocity = (kob_destination - global_position).normalized()
	move_and_collide(velocity)
	if (kob_destination - global_position).length() < 5:		#start idling after reaching the destination
		boredom -= randf_range(5, 10)
		velocity = Vector2.ZERO
		if wizzed == true:
			$AnimatedSprite2D.play("wizsit")
		else:
			$AnimatedSprite2D.play("sit")
		walk_pass = false
		destreach = true
		$boredT.start()
	
func _check_viability(checkpart, dest):
	for x in checkpart:
		if x.visible and x.get_rect().has_point(dest):
			return false
		else:
			continue
	return true

func _on_boredom_time():
	if (boredom <= 20):
		boredom += randf_range(0.1, 1)
	else:
		$walkiesT.start()
		$boredT.stop()
		
func _on_walkies_time():
	if boredom > 20:
		if wizzed == true:
			$AnimatedSprite2D.play("wizstand")
		else:
			$AnimatedSprite2D.play("stand")
		if (randf_range(0, 10) > 3): #gives the kobold a moment to stand before walking again
			walk_pass = true
			$walkiesT.stop()
	
func _wizzedup():
	if (randf_range(0,100) >= 75
	and wizzed != true):
		wizzed = true
		kobold_build.modifier *= 2.5
		$wiz.start()

func _wizzedown():
	if wizzed == true:
		wizzed = false
		kobold_build.modifier /= 2.5