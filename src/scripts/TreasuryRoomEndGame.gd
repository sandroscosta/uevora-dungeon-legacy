extends Control

onready var LblCharName = get_node("LabelCharName")
onready var LblCoinsCollected = get_node("LabelCoinsCollected")

func _ready():
	LblCharName.text = GameState.heirs[-1]
	LblCoinsCollected.text = str(GameState.treasure)
