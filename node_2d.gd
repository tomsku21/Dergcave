extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func _on_openmen_pressed():
	$Menus/foreground/Settings.visible = false
	$Menus/foreground/Buymenu.visible = !$Menus/foreground/Buymenu.visible

func _on_timer_timeout():
	Global.comfort += Global.cpsec * Global.mult
	Global.notoriety += Global.nsec * Global.nmult

func _on_openset_pressed():
	$Menus/foreground/Buymenu.visible = false
	$Menus/foreground/Settings.visible = !$Menus/foreground/Settings.visible
