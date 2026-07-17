extends Button
@export var price : int = 1
@export var thing : String = "example" # thing to buy
@export_multiline var tooltip_info: String
@onready var price_display = $Price
@onready var label = $Label
@onready var tooltip = $Tooltip
@onready var tooltip_content =  $Tooltip/Content
var bought : bool = false
var l1unlocks = Global.unlocked.keys()
var l2unlocks = ["checkpoints", "terrorMode"]


func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	disabled = true
	setup()
	Global.currency_changed.connect(payable)
	SignalBus.door_entered.connect(setup)
	SignalBus.level_up.connect(setup_redirect)
	
func setup_redirect ( _throwaway : int ) :
	setup()
	
func setup():
	if Global.level == Global.Level.BASIC:
		if thing in Global.unlocked.keys():
			label.text = name
			price_display.text = str(price)
			payable(0) #check if should be disabled or now
			show()
		else:
			hide()
	else:
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
		

##tooltip
func on_mouse_entered():
	tooltip.toggle(true)
func on_mouse_exited():
	tooltip.toggle(false)
