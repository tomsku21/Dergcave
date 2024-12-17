extends Control

func _buttoncheck():
	%AsActive.visible = Global.autosave == true
	%SoActive.visible = Global.soundeff == true
	%Buttoncheck.queue_free()

func _update():
	%Comfgained.text = str("Comfort gained (this ascension): ", Global.bigprint(Global.Acomfort))
	%Comfgainedat.text = str("Comfort gained (all time): ", Global.bigprint(Global.Gcomfort))
	%Notgained.text = str("Notoriety gained (this ascension): ", Global.bigprint(Global.Anotoriety))
	%Notgainedat.text = str("Notoriety gained (all time): ", Global.bigprint(Global.Gnotoriety))
	%Comfmult.text = str("Comfort multiplier: ",Global.bigprint((Global.mult) * 100), "%")
	%Notmult.text = str("Notoriety multiplier: ",Global.bigprint((Global.nmult) * 100), "%")
	%Hoardsize.text = str("Hoard size: ", Global.bigprint(Global.buildings))
	%Cpower.text = str("Comfort per click: ", Global.bigprint(Global.power))
	%Clicks.text = str("Dragon pats: ", Global.bigprint(Global.clicks))
	%Kobolds.text = str("Kobolds living with you: ", Global.bigprint(Global.kobamount))
	%Ascensions.text = str("Ascension tier: ", Global.reincarnation)

func _on_autosave_pressed():
	if Global.soundeff == true:
		%Tap.play()
	Global.autosave = !Global.autosave
	%AsActive.visible = Global.autosave == true

func _save_pressed():
	if Global.soundeff == true:
		%Tap.play()
	SaveLoad.save_game()

func _load_pressed():
	if Global.soundeff == true:
		%Tap.play()
	SaveLoad.load_game()
	self.visible = false

func _on_Sound_pressed():
	if Global.soundeff == true:
		%Tap.play()
	Global.soundeff = !Global.soundeff
	%SoActive.visible = !%SoActive.visible

func _on_reset_pressed():
	if Global.soundeff == true:
		%Tap.play()
	Wipeconfirm._Show_Wipe_window()
	
