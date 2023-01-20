extends Control

func _on_StartButton_pressed():
	#get_tree().change_scene("res://src/scenes/Game.tscn")
	get_node("DifficultyOption").show()


func _on_EasyButton_pressed():
	GameState.game_difficulty = GameState.Difficulty.EASY
	get_tree().change_scene("res://src/scenes/Game.tscn")


func _on_HardButton_pressed():
	GameState.game_difficulty = GameState.Difficulty.HARD
	get_tree().change_scene("res://src/scenes/Game.tscn")
