extends Node

#amount of "currency
var comfort = 0
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
#the debuff trio
var chocdebuf = false 
var gemdebuf = false
var protest = false
var reincarnation = 0

func empty():
	comfort = 0
	notoriety = 0
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
		"chocdebuff" : chocdebuf,
		"gemdebuff" : gemdebuf,
		"protest" : protest,
		"reincarnation" : reincarnation
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
