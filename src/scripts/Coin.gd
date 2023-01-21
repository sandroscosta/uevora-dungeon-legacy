extends Area2D

var coin_value = 1

func _on_Coin_body_entered(body):
	if body.name == "Player":
		GameState.treasure += coin_value
		queue_free()
