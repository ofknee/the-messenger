extends CanvasLayer

@onready var label = $Control/MarginContainer/Bank/HBoxContainer/MarginContainer2/RichTextLabel

func _ready() -> void:
	Global.currency_changed.connect(update_coins)
	update_coins(Global.coins)

func update_coins(coins: int) -> void:
	label.text = str(coins)
	
func _on_button_pressed() -> void:
	print("open shop")
