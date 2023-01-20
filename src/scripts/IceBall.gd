extends Area2D

export (int) var speed: int = 300
export (int) var damage: int = 20
var hit: bool = false
var throwable: bool = true

func _process(delta):
	position += transform.x * speed * delta


func _on_IceBall_body_entered(body):
	if body.is_in_group("enemies"):
		if body.has_method("handle_hit"):
			body.handle_hit(damage)
			queue_free()
