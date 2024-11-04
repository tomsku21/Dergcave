extends Control

var padding = 20
var uppad = 5

func _process(_delta):
	if %BuildPopup.visible:
		var mouse_pos = get_viewport().get_mouse_position()
		var finalpos = Vector2i(mouse_pos.x, mouse_pos.y + padding)
		%BuildPopup.position = finalpos

#handles upgrade tooltip position and texts
func UpPopup(sizing: Rect2i, content):
	if content != null:
		set_upvalue(content)
		%ToolPopup.size = Vector2i.ZERO
	var correction = sizing.size.x + uppad
	var finalpos = Vector2i(sizing.position.x - correction, sizing.position.y + correction)
	%ToolPopup.position = finalpos
	%ToolPopup.show()

#handles building tooltip position and texts
func BuildPopup(sizing: Rect2i, content):
	if content != null:
		set_buildvalue(content)
		%BuildPopup.size = Vector2i.ZERO
	%BuildPopup.show()


func HideBuildPopup():
	%BuildPopup.hide()

func HideUpPopup():
	%ToolPopup.hide()

#sets upgrade tooltip texts
func set_upvalue(content):
	%Name.text = content.title
	match content.tier:
		1:
			%Cost.text = str("Cost: ", Global.bigprint(content.cost), " Comfort")
		2:
			%Cost.text = str("Cost: ", Global.bigprint(content.cost), " Notoriety")
	%Desc.text = content.description

#Sets building tooltip texts
func set_buildvalue(content):
	%Build.text = content.title
	match content.tier:
		1:
			%Cost1.text = str("Cost: ", Global.bigprint(content.cost), " Comfort")
		2:
			%Cost1.text = str("Cost: ", Global.bigprint(content.cost), " Coins")
	#Times 10 purchase cost for buildings
	match content.tier:
		1:
			%Cost10.text = str("Cost for 10(SHIFT+Click): ", Global.bigprint(content.costx10), " Comfort")
		2:
			%Cost10.text = str("Cost for 10(SHIFT+Click): ", Global.bigprint(content.costx10), " Coins")
	match content.tier:
		1:
			%Income.text = str("Producing ", Global.bigprint(content.income), " Comfort per second")
		2:
			%Income.text = str("Producing ", Global.bigprint(content.income), " Notoriety per second")
	%Descr.text = content.description
	
	
