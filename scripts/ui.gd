extends CanvasLayer

@onready var label = $Control/MarginContainer/Bank/HBoxContainer/MarginContainer2/RichTextLabel
@onready var shop = $Control/MarginContainer/Shop
@onready var grayscale = $ShaderCanvas/Grayscale
@onready var camera = $"../Player/Camera2D"
@onready var check_node = %checkpoints
@onready var game_over = $GameOver
@onready var click_arrow = %click_arrow
@onready var level_arrow = $Control/MarginContainer/Shop/level_arrow
@onready var level_2 = $Control/MarginContainer/Shop/ScrollContainer/MarginContainer/VBoxContainer/LEVEL2
var bus_index = AudioServer.get_bus_index("Music")
var unlocked = Global.unlocked

func _ready() -> void:
	AudioServer.set_bus_mute(bus_index, true)
	Global.currency_changed.connect(update_coins)
	SignalBus.thing_bought.connect(update_ui)
	SignalBus.game_over.connect(game_over_screen)
	update_coins(Global.coins)
	shop.hide()
	game_over.hide()
	

func update_coins(coins: int) -> void:
	label.text = str(coins)
	update_ui()
	
func _on_button_pressed() -> void:
	shop.show()
	if unlocked.has("level2") and unlocked.get("level2") == false:
		level_arrow.show()
	click_arrow.hide()

func _on_leave_shop_pressed() -> void:
	shop.hide()
	
func update_ui():
	#check kill filter
	if unlocked.get("color") and grayscale:
		grayscale.queue_free()
		print('color deleted')
	if Global.level == 1:
		if unlocked["checkpoints"] == true:
			check_node.visible = true
	if unlocked.get("sfx") == true:
		AudioServer.set_bus_mute(bus_index, false)
	if unlocked.get("level2") == true:
		level_arrow.hide()
func game_over_screen():
	game_over.show()
