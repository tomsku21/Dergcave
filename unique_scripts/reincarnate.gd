extends Control
var restartreq

func _ready():
	$restarto.disabled = true

func _process(_delta):
	restartreq = 1000 * 10 ** Global.reincarnation
	$restarto.disabled = Global.notoriety < restartreq
	$restarto/requnmet.visible = Global.notoriety < restartreq
	$Req.text = str(restartreq - Global.notoriety, " notoriety")

#1. empty global valuables. Global is above the main scene, so needs to be reset on it's own
#2. reload scene, returns everything to their default states.
#	-does not account for achievements. saving their parent node's state and loading it would fix
#	-figure out how to do that without putting values down on a file.
#3. raise reincarnation amount, global empty doesn't reset it, so no need for extra dancing for this one
#4. lower cost multipliers and income based on reincarnation amount, needs a better thought out calculation
func _on_pressed():
	Global.empty()
	get_tree().reload_current_scene()
	Global.reincarnation += 1
	Global.nbmod /= 1.25 ** Global.reincarnation
	Global.mult *= 1 + (0.5 * Global.reincarnation)
