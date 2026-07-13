extends Node

var unlocked = {
	"animation" : false,
	"sfx" : false,
	"particles" : false,
	"camera" : false,
	"terrorMode" : false,
	"color" : false,
	"screenshake" : false,
} if level == Level.BASIC else {
	"animation" : false,
	"sfx" : false,
	"particles" : false,
	"camera" : false,
	"terrorMode" : false,
	"color" : false,
	"screenshake" : false,
}

enum Level {
	BASIC,
	SPIKES,
	ADVANCED
}
var level = Level.BASIC


var dead = false

signal currency_changed(new_currency: int)
var coins: int = 0: ##starting money
	set(val):
		coins = val
		currency_changed.emit(val)
