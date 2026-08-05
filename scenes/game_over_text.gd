extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("label ready")
	SignalBus.game_over.connect(testing)

func testing() -> void:
	print("calafsd;lfaks;dlkfja;klsd")
	if Global.buys.size() > 0:
		text = "YOU'VE REACHED THE END.\n\nITEMS BOUGHT: \n" + " • ".join(Global.buys) + "\n\nTHANK YOU FOR PLAYING!"
	else:
		text = "YOU'VE REACHED THE END.\n\nYOU NEVER BOUGHT ANYTHING.\n\nTHANK YOU FOR PLAYING!"

	print(text)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
