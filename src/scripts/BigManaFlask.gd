extends Area2D

var mana_value = GameState.mana_value + 2

func _on_ManaFlask_body_entered(body):
	if body.name == "Player":
		if GameState.player_mana+mana_value <= GameState.DEFAULT_MAX_MANA_VALUE:
			GameState.player_mana += mana_value
		queue_free()
