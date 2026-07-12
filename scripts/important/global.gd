extends Node


var unlocked = {
	"animation" : false,
	"sfx" : false,
	"color" : false,
	"terrorMode" : false,
	"checkpoints" : false,
}

var high_check = 10000
var high_checkpoint
var dead = false

signal currency_changed(new_currency: int)
var coins: int = 0: ##starting money
	set(val):
		coins = val
		currency_changed.emit(val)
