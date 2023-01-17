extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = str(0)

func _process(delta):
	self.text = str(GameState.enemies_killed)
