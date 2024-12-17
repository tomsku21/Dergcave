extends Control

var padding = 20
var lilpad = 5

#handles upgrade tooltip position and texts
func UpPopup(sizing: Rect2i, content):
	if content != null:
		set_upvalue(content)
		%ToolPopup.size = Vector2i.ZERO
		var correction = sizing.size.x + lilpad
		var finalpos = Vector2i(sizing.position.x - correction, sizing.position.y + correction)
		%ToolPopup.position = finalpos
		%ToolPopup.show()

#handles building tooltip position and texts
func BuildPopup(sizing: Rect2i, content):
	if content != null:
		set_buildvalue(content)
		%BuildPopup.size = Vector2i.ZERO
		#positioned to the left and a bit up of the building. y can be handled with a bit of padding
		#x the width of the tooltip with a lilbit of padding. 
		var correctionx = %BuildPopup.size.x + lilpad
		var finalpos = Vector2i(sizing.position.x - correctionx, sizing.position.y - padding)
		%BuildPopup.position = finalpos
		%BuildPopup.show()

#handles Debuff tooltip position and texts
func DebuffPopup(sizing: Rect2i, content):
	if content != null:
		set_debuffvalue(content)
		%DebuffPopup.size = Vector2i.ZERO
		var correction = sizing.size.y + lilpad
		var finalpos = Vector2i(sizing.position.x, sizing.position.y + correction)
		%DebuffPopup.position = finalpos
		%DebuffPopup.show()

#Handles Ascension popup texts. Most stay the same, so we'll only change two text field's content.
func AscendPopup(sizing: Rect2i, content):
	if content != null:
		set_ascendvalue(content)
		%AscendPopup.size = Vector2i.ZERO
		var correctionx = (sizing.size.x) + lilpad
		var finalpos = Vector2i(sizing.position.x + correctionx, sizing.position.y - lilpad)
		%AscendPopup.position = finalpos
		%AscendPopup.show()

func SavePopup():
	%SavePopup.show()
	var tween = get_tree().create_tween()
	tween.tween_property(%SavePopup, "modulate:a", 1, 0.75)
	tween.tween_property(%SavePopup, "modulate:a", 0, 0.75)
	%SaveTime.start()

func HideSavePopup():
	%SavePopup.hide()

func HideAscendPopup():
	%AscendPopup.hide()

func HideBuildPopup():
	%BuildPopup.hide()

func HideDebuffPopup():
	%DebuffPopup.hide()

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

#sets Debuff tooltip texts
func set_debuffvalue(content):
	%Debuf.text = content.title
	%Descri.text = content.description
	%Effect.text = content.effect
	

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
	
#sets Ascension tooltip texts
func set_ascendvalue(content):
	%Requirement.text = str("Requirement for next Ascension level: ", Global.bigprint(content.restartreq), ".")
	if content.rlevel > 0:
		%Ascensionlvl.text = str("By ascending now, your Ascension level will raise to ", Global.bigprint(Global.reincarnation + content.rlevel), ".")
		%Ascensionlvl.show()
	else:
		%Ascensionlvl.hide()
