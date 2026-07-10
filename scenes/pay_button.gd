extends Button
@export var price : int = 1
#@export var thing : String = "EXAMPLE"
@onready var price_display = $Price
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func setup():
	label.text = name
	price_display.text = str(price)
	
