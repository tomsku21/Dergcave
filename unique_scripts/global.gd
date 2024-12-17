extends Node

#amount of "currency
var Acomfort: float = 0 #comfort gained in current Ascension
var Gcomfort: float = 0 #Total comfort gained while playing
var comfort: float = 0:
	set(value):
		if (value - comfort) > 0: #so it using up comfort won't lower the Acomfort/Gcomfort gained counter
			Acomfort += value - comfort
			Gcomfort += value - comfort
		comfort = value
var Anotoriety: float = 0 #notoriety gained in current Ascension
var Gnotoriety: float = 0 #Total notoriety gained while playing
var notoriety: float = 0:
	set(value):
		if (value - notoriety) > 0:
			Anotoriety += value - notoriety
			Gnotoriety += value - notoriety
		notoriety = value
var buildings: int = 0
var power: float = 1 # clicking power
var cpsec: float = 0 #income for comfort
var nsec: float = 0 #income for notoriety
var bmod: float = 0.15 #building cost multiplier
var nbmod: float = 0.05 #tier 2 building cost multiplier
var mult: float = 1 #multiplier affecting income directly
var nmult: float = 1 #multiplier affecting notoriety income directly
var hunger = false 
var nofoodcount: int = 0
var kobamount: int = 0
var dergamount: int = 0
var ateshroom: int = 0 #amount of mushrooms eaten, counted for stats and upgrades
var clicks: int = 0 # counts clicks
#the debuff trio
var chocdebuf = false 
var gemdebuf = false
var protest = false
var goldcmult: float = 1
var reincarnation: int = 0:
	set(value):
		Global.goldcmult /= 1.15 ** (value)
		Global.mult *= 1.1 ** (value)
		Global.nmult *= 1.25 ** (value)
		reincarnation = value
#Settings
var soundeff = true
var autosave = true
var autoload = true

func empty():
	Acomfort = 0
	comfort = 0
	Anotoriety = 0
	notoriety = 0
	buildings = 0
	power = 1 
	cpsec = 0
	nsec = 0 
	bmod = 0.15 
	nbmod = 0.05 
	mult = 1
	nmult = 1 
	hunger = false 
	nofoodcount = 0
	kobamount = 0
	dergamount = 0
	ateshroom = 0
	clicks = 0
	chocdebuf = false 
	gemdebuf = false
	protest = false
	goldcmult = 1
	autoload = true

func save():
	var save_dict = {
		"Acomfort" : Acomfort,
		"Gcomfort" : Gcomfort,
		"comfort" : comfort,
		"Anotoriety" : Anotoriety,
		"Gnotoriety" : Gnotoriety,
		"notoriety" : notoriety,
		"buildings": buildings,
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
		"chocdebuff" : chocdebuf,
		"gemdebuff" : gemdebuf,
		"protest" : protest,
		"goldcmult" : goldcmult,
		"reincarnation" : reincarnation,
		"soundeff" : soundeff,
		"autosave" : autosave
	}
	return save_dict

##Number handling functions.
func bigprint(number):
	var printed
	if str(snapped(number, 1)).length() > 5:
		# how many places to move the zero.
		var _exp = str(number).split(".")[0].length() - 1

		# divide with same magnitude
		var _dec = number / pow(10,_exp)

		# print only what we want, add exp
		printed = "{dec}e{exp}".format({"dec":("%1.2f" % _dec), "exp":str(_exp) })
	else:
		printed = str(snapped(number, 0.1))
	return printed
