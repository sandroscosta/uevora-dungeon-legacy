extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(GameState.treasure)


func _process(delta):
	text = str(GameState.treasure)
