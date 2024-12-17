extends Control

func _on_button_pressed():
	Global.empty()
	Global.reincarnation = 0
	Global.Gcomfort = 0
	Global.Gnotoriety = 0
	Global.autoload = false
	get_tree().reload_current_scene()
	_Hide_Wipe_window()

func _Show_Wipe_window():
	%ConfirmWind.show()

func _Hide_Wipe_window():
	if Global.soundeff == true:
		%Tap.play()
	%ConfirmWind.hide()
