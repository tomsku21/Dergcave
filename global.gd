extends Node

var comfort = 0 #amount of "currency
var notoriety = 0
var power = 1 # clicking power
var cpsec = 0 #income for comfort
var nsec = 0 #income for notoriety
var bmod = 0.15 #building cost multiplier
var nbmod = 0.05 #tier 2 building cost multiplier
var mult = 1 #multiplier affecting income directly
var nmult = 1 #multiplier affecting notoriety income directly
var hunger = false 
var nofoodcount = 0
var kobamount = 0
var dergamount = 0
var ateshroom = 0 #amount of mushrooms eaten, counted for stats and upgrades
var clicks = 0 # counts clicks
var chocdebuf = false #temporary thing for debuff
var protest = false

func empty():
	var gvalues = save()
	for i in gvalues.keys():
		Global.set(i, 0)

func save():
	var save_dict = {
		"comfort" : comfort,
		"notoriety" : notoriety,
		"power" : power,
		"cpsec" : cpsec,
		"nsec" : nsec,
		"bmod" : bmod,
		"nbmod" : nbmod,
		"mult" : mult,
		"nmult" : nmult,
		"hunger" : hunger,
		"nofoodcount" : nofoodcount,
		"kobamount" : kobamount,
		"dergamount" : dergamount,
		"ateshroom" : ateshroom,
		"clicks" : clicks,
		"protest" : protest
	}
	return save_dict
