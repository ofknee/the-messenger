extends Button
@export var price : int = 1
@export var thing : String = "example" # thing to buy
@onready var price_display = $Price
@onready var label = $Label
var bought : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disabled = true
	setup()
	Global.currency_changed.connect(payable)
	
func setup():
	if thing in Global.unlocked.keys():
		label.text = name
		price_display.text = str(price)
		payable(0) #check if should be disabled or now
		show()
	else:
		hide()
	

func _on_pressed() -> void: 
	if payable(0):
		Global.coins -= price
		print("bought: ",thing)
		#modulate.a = 0.5
		Global.unlocked[thing] = true ##unlock
		SignalBus.thing_bought.emit()
		queue_free()
	else:
		print("ur broke lol")

func payable(_throwaway: int) -> bool:
	if price <= Global.coins:
		disabled = false
		return true
	else:
		disabled = true
		return false
