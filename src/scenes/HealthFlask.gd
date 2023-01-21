extends Area2D

const FLASK_VALUE = 5

var health_recover = FLASK_VALUE

func _ready():
	if GameState.game_difficulty == GameState.Difficulty.HARD:
		health_recover += FLASK_VALUE

func _on_ManaFlask_body_entered(body):
	if body.name == "Player":
		if GameState.player_hp < GameState._player_max_hp:
			GameState.player_hp += health_recover
		queue_free()
