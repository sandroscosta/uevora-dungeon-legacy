extends Control

onready var char_name := get_node("LabelCharName")

func _ready():
	char_name.text = GameState.character_name

func _on_RestartButton_pressed():
	get_tree().change_scene("res://src/scenes/Game.tscn")
