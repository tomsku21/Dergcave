extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	if Global.autoload == true:
		SaveLoad.load_game()
	else:
		SaveLoad.save_game()
	

func _on_openmen_pressed():
	$Menus/foreground/Settings.visible = false
	$Menus/foreground/Buymenu.visible = !$Menus/foreground/Buymenu.visible
	if Global.soundeff == true:
		%Tap.play()

func _on_timer_timeout():
	Global.comfort += (Global.cpsec) * 0.1
	Global.notoriety += (Global.nsec) * 0.1

func _on_openset_pressed():
	$Menus/foreground/Buymenu.visible = false
	$Menus/foreground/Settings.visible = !$Menus/foreground/Settings.visible
	if Global.soundeff == true:
		%Tap.play()

func _on_autosave():
	if Global.autosave == true:
		SaveLoad.save_game()
