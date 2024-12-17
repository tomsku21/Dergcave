extends VBoxContainer
var open = true
@export var open_texture: Texture2D
@export var closed_texture: Texture2D

func _on_button_pressed():
	if open == true:
		$Header.texture = closed_texture
		$Upgrade_cont.visible = false
		open = false
	else:
		$Header.texture = open_texture
		$Upgrade_cont.visible = true
		open = true
