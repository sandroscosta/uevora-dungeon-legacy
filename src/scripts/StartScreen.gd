extends Control

onready var LblCharName = get_node("LabelCharName")
onready var sprite = get_node("Sprite")

func _ready():
	LblCharName.text = GameState.character_name
	sprite.scale = GameState.heir["build"]["scale"]

func _on_StartButton_pressed():
	get_node("DifficultyOption").show()


func _on_EasyButton_pressed():
	GameState.game_difficulty = GameState.Difficulty.EASY
	get_tree().change_scene("res://src/scenes/Game.tscn")


func _on_HardButton_pressed():
	GameState.game_difficulty = GameState.Difficulty.HARD
	get_tree().change_scene("res://src/scenes/Game.tscn")
