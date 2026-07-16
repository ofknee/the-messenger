extends CanvasLayer

@onready var label = $Control/MarginContainer/Bank/HBoxContainer/MarginContainer2/RichTextLabel
@onready var shop = $Control/MarginContainer/Shop
@onready var grayscale = $ShaderCanvas/Grayscale
@onready var camera = $"../Player/Camera2D"
@onready var check_node = %checkpoints
var bus_index = AudioServer.get_bus_index("Music")
var unlocked = Global.unlocked

func _ready() -> void:
	AudioServer.set_bus_mute(bus_index, true)
	Global.currency_changed.connect(update_coins)
	SignalBus.thing_bought.connect(update_ui)
	update_coins(Global.coins)
	shop.hide()

func update_coins(coins: int) -> void:
	label.text = str(coins)
	update_ui()
	
func _on_button_pressed() -> void:
	shop.show()

func _on_leave_shop_pressed() -> void:
	shop.hide()
	
func update_ui():
	#check kill filter
	if unlocked["color"] and grayscale:
		grayscale.queue_free()
		print('color deleted')
	#if Global.level == 1:
	if unlocked["checkpoints"] == true:
		check_node.visible = true
	if unlocked["sfx"] == true:
		AudioServer.set_bus_mute(bus_index, false)
