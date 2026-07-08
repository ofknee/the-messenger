extends CanvasLayer

@onready var label = $Control/MarginContainer/Panel/MarginContainer/HBoxContainer/RichTextLabel

func _ready() -> void:
	Global.currency_changed.connect(update_coins)
	update_coins(Global.coins)

func update_currency(coins: int) -> void:
	label.text = str(coins)
