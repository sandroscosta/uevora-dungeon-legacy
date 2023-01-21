extends ProgressBar



# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = GameState.MAX_STAMINA
	value = GameState.player_stamina


func _process(_delta):
	value = GameState.player_stamina
