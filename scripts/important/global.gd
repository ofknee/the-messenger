extends Node

var unlocked = {
	"animation" : false,
	"sfx" : false,
	"particles" : false,
	"camera" : false,
	"terrorMode" : false,
	"color" : false,
	"screenshake" : false,
}

var dead = false

signal currency_changed(new_currency: int)
var coins: int = 0: ##starting money
	set(val):
		coins = val
		currency_changed.emit(val)
