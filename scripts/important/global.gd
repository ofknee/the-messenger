extends Node

var level = Level.BASIC

var unlocked = {
	"animation" : false,
	"sfx" : false,
	"camera" : false,
	"color" : false,
} 
enum Level {
	BASIC,
	SPIKES,
	ADVANCED
}
#var bg_play = false

var high_check = 10000
var high_checkpoint
var dead = false

signal currency_changed(new_currency: int)
var coins: int = 0: ##starting money
	set(val):
		coins = val
		currency_changed.emit(val)
		
		
