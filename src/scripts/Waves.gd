extends Label


func _ready():
	self.text = "Wave " + str(GameState.wave) + " of 6"
