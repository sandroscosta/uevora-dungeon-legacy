extends ProgressBar



# Called when the node enters the scene tree for the first time.
func _ready():
	value = GameState.player_mana


func _process(_delta):
	value = GameState.player_mana
