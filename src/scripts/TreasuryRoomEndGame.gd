extends Control

onready var LblCharName = get_node("LabelCharName")
onready var LblCoinsCollected = get_node("LabelCoinsCollected")
onready var LblDinasty = get_node("LabelDinasty")

func _ready():
	LblCharName.text = GameState.heirs[-1]
	LblCoinsCollected.text = str(GameState.treasure)
	LblDinasty.text =  _get_dinasty_text()

func _on_StartButton_pressed():
	GameState._initialize_game()
	get_tree().change_scene("res://src/scenes/StartScreen.tscn")

func _get_dinasty_text():
	if len(GameState.heirs) > 1:
		return "Took you 1 dynasty to achieve victory"
	else:
		return "Took you " + str(len(GameState.heirs)) + " dynasties to achieve victory"
