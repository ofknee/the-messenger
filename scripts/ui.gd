extends CanvasLayer

@onready var label = $Control/MarginContainer/Bank/HBoxContainer/MarginContainer2/RichTextLabel
@onready var shop = $Control/MarginContainer/Shop
@onready var grayscale = $ShaderCanvas/Grayscale
@onready var camera = $"../Player/Camera2D"
@onready var check_node = %checkpoints
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
	if unlocked["color"] and is_instance_valid(grayscale) and not grayscale.is_queued_for_deletion():
		grayscale.queue_free()
		print('color deleted')
		
func checkpoint_check():
	if unlocked["checkpoints"] == true:
		check_node.visible = true
