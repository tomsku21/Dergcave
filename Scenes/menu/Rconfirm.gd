extends Control

var padding = 20
var lilpad = 5
var rlevel: int

#updates current saved up reincarnation level for this scene, reincarnation confirm
#button visible if enough notoriety to get at least one Asclevel.
#and lastly send info for function that handles text.
func Ascendwindow(content):
	if content != null:
		rlevel = content.rlevel
		%ConfirmR.visible = Global.Anotoriety >= content.minrestartreq
		set_ascendvalue(content)
		%ConfirmWind.show()

func _on_button_pressed():
	if Global.soundeff == true:
		%Tap.play()
	Global.empty()
	Global.autoload = false
	get_tree().reload_current_scene()
	Global.reincarnation += rlevel
	HideAscendwindow()

func HideAscendwindow():
	if Global.soundeff == true:
		%Tap.play()
	%ConfirmWind.hide()

#sets Ascension tooltip texts
func set_ascendvalue(content):
	%Requirement.text = str("You need ", Global.bigprint(content.restartreq), " notoriety for next Ascension level")
	if content.rlevel > 0:
		%Ascensionlvl.text = str("By Ascending now your Ascension level will raise to ", Global.bigprint(Global.reincarnation + content.rlevel), ".")
		%Ascensionlvl.show()
	else:
		%Ascensionlvl.hide()
	%Effect1.text = str("Your Gold coin building cost ratio will lower by ", Global.bigprint(content.goldeffect),"%.")
	%Effect2.text = str("Your comfort income will increase by ", Global.bigprint(content.comfeffect), "%.")
	%Effect3.text = str("Your notoriety income will increase by ", Global.bigprint(content.noteffect), "%.")
