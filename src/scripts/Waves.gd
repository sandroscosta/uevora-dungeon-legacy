extends Label


func _ready():
	self.text = _get_text()
	
func _process(_delta):
	self.text = _get_text()

func _get_text():
	return "Wave " + str(GameState.wave) + " of " + str(GameState.max_waves)
