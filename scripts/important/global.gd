extends Node


var unlocked = {
	"animation" : false,
	"sfx" : false,
	"camera" : false,
	"terrorMode" : false,
	"color" : false,
} 

func setup_shop_unlocks():
	if level == Level.BASIC:
		unlocked["level2"] = false
	elif level == Level.SPIKES:
		unlocked["checkpoints"]
		unlocked["level3"] = false

enum Level {
	BASIC,
	SPIKES,
	ADVANCED
}
var level = Level.BASIC
#var bg_play = false

var high_check = 10000
var high_checkpoint
var dead = false

signal currency_changed(new_currency: int)
var coins: int = 0: ##starting money
	set(val):
		coins = val
		currency_changed.emit(val)
		
		
