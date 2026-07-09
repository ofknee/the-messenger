extends CanvasLayer

@onready var label = $Control/MarginContainer/Panel/HBoxContainer/RichTextLabel

func _ready() -> void:
	Global.currency_changed.connect(update_coins)
	update_coins(Global.coins)


func update_coins(coins: int) -> void:
	label.text = str(coins)
