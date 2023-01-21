extends Area2D


export (int) var speed: int = 100
export (int) var damage: int = 12
var hit: bool = false
var stamina_consumed = 3

var initial_position: Vector2 = Vector2.ZERO

onready var animation = get_node("AnimationPlayer")

func _ready():
	initial_position.x = position.x + 75
	animation.play("throw")


func _process(delta):
	if position.x >= initial_position.x:
		queue_free()
	position += transform.x * speed * delta

func _on_WeaponKnife_body_entered(body):
	if body.is_in_group("enemies"):
		if body.has_method("handle_hit"):
			body.handle_hit(damage)
			queue_free()
