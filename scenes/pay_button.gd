extends Button
@export var price : int = 1
@export var thing : String = "example" # thing to buy
@onready var price_display = $Price
@onready var label = $Label
var bought : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()
	
func setup():
	label.text = name
	price_display.text = str(price)

func _on_pressed() -> void:  ##spawn eye laccording to button type
	if payable():
		if bought == false:
			Global.coins -= price
			print("bought: ",thing)
			modulate.a = 0.5
			bought = true
		else:
			print("alr bought: ",thing)
	else:
		print("ur broke lol")

func payable() -> bool:
	if price <= Global.coins:
		return true
	else:
		return false
