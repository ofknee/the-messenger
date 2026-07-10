extends CanvasLayer

@onready var label = $Control/MarginContainer/Bank/HBoxContainer/MarginContainer2/RichTextLabel
@onready var shop = $Control/MarginContainer/Shop
func _ready() -> void:
	Global.currency_changed.connect(update_coins)
	update_coins(Global.coins)
	shop.hide()

func update_coins(coins: int) -> void:
	label.text = str(coins)
	
func _on_button_pressed() -> void:
	shop.show()


func _on_leave_shop_pressed() -> void:
	shop.hide()
