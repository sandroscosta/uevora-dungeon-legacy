extends Area2D


var mana_value = 2



func _on_ManaFlask_body_entered(body):
	if body.name == "Player":
		GameState.player_mana += mana_value
		queue_free()