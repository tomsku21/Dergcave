extends Control
var restartreq: float
var minrestartreq: float
var goldeffect: float
var comfeffect: float
var noteffect: float
var rlevel = 0

#update notoriety requirement for ascending and it's effects for next run.
func _process(_delta):
	restartreq = 1000 + 25 * 5.5 ** (Global.reincarnation + rlevel + 1)
	minrestartreq = 1000 + 25 * 5.5 ** (Global.reincarnation + 1)
	goldeffect = 100 * (1.15 ** (Global.reincarnation + rlevel) -1)
	comfeffect = 100 * (1.1 ** (Global.reincarnation + rlevel) - 1)
	noteffect = 100 * (1.25 ** (Global.reincarnation + rlevel) - 1)
	if Global.notoriety >= restartreq:
		rlevel += 1

#opens confirmation window for ascending, Rconfirm scene
func _on_pressed():
	Rconfirm.Ascendwindow(self)
	if Global.soundeff == true:
		%Tap.play()

func _on_mouse_entered():
	Popups.AscendPopup(Rect2i( Vector2i(global_position) , Vector2i(size)), self)

func _on_mouse_exited():
	Popups.HideAscendPopup()
