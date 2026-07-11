extends CanvasLayer

@onready var label = $Control/MarginContainer/Bank/HBoxContainer/MarginContainer2/RichTextLabel
@onready var shop = $Control/MarginContainer/Shop
@onready var grayscale = $ShaderCanvas/Grayscale
var unlocked = Global.unlocked

func _ready() -> void:
	Global.currency_changed.connect(update_coins)
	SignalBus.thing_bought.connect(kill_filter_check)
	update_coins(Global.coins)
	shop.hide()

func update_coins(coins: int) -> void:
	label.text = str(coins)
	kill_filter_check()
	
func _on_button_pressed() -> void:
	shop.show()

func _on_leave_shop_pressed() -> void:
	shop.hide()
	
func kill_filter_check():
	if unlocked["color"]:
		grayscale.queue_free()
		print('color deleted')
