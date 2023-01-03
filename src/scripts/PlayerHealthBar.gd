extends ProgressBar

onready var LabelText = get_node("LabelHealth")

func _ready():
	self.max_value = GameState.player_max_hp
	self.value = GameState.player_hp
	LabelText.text = str(GameState.player_hp) + "/" + str(GameState.player_max_hp)
