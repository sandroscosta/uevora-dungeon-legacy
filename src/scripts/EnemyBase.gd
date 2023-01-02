extends KinematicBody2D

export (int) var health_point = 20
var speed : int = 50
var chase : bool = false

onready var player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	if chase:
		var direction = (player.position - position).normalized()
		move_and_slide(direction * speed)
	

func _on_ChaseArea_body_entered(body):
	if body == player:
		chase = true
