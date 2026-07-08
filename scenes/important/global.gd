extends Node


signal currency_changed(new_currency: int)
var coins: int = 67: ##starting money
	set(val):
		coins = val
		currency_changed.emit(val)
