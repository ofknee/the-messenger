extends Node

var unlocked = {
	"animation" : false,
	"sfx" : false,
	"color" : false,
	"terrorMode" : false,
}

signal currency_changed(new_currency: int)
var coins: int = 0: ##starting money
	set(val):
		coins = val
		currency_changed.emit(val)
