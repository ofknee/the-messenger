extends CanvasLayer

@onready var label = $Control/MarginContainer/Bank/HBoxContainer/MarginContainer2/RichTextLabel
#@onready var panel = $Control/MarginContainer/Bank
#@onready var hbox = $Control/MarginContainer/Bank/HBoxContainer
func _ready() -> void:
	Global.currency_changed.connect(update_coins)
	update_coins(Global.coins)


func update_coins(coins: int) -> void:
	label.text = str(coins)
