extends Control

onready var char_name := get_node("LabelCharName")

func _ready():
	char_name.text = GameState.character_name

func _on_RestartButton_pressed():
	GameState.restart_game()
	get_tree().change_scene("res://src/scenes/Game.tscn")


func _on_ShopButton_pressed():
	get_tree().change_scene("res://src/scenes/Store.tscn")
