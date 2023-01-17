extends Area2D


export (int) var speed: int = 200
export (int) var damage: int = 5
var hit: bool = false

onready var animation = get_node("AnimationPlayer")

func _ready():
	animation.play("throw")


func _process(delta):
	position += transform.x * speed * delta

func _on_WeaponKnife_body_entered(body):
	if body.is_in_group("enemies"):
		if body.has_method("handle_hit"):
			body.handle_hit(damage)
			queue_free()
