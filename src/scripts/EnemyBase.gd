extends KinematicBody2D

export (int) var health_points = 20
export (int) var damage = 5
var speed : int = 50
var chase : bool = false

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var animationSprite = get_node("AnimatedSprite")

func _physics_process(_delta):
	if chase:
		var direction = (player.position - position).normalized()
		move_and_slide(direction * speed)
	
	check_death()

func _on_ChaseArea_body_entered(body):
	if body == player:
		chase = true
		animationSprite.animation = "run"

func handle_hit(value):
	# body.has_method("handle_hit")
	health_points -= value

func deal_damage():
	return damage

func check_death():
	if health_points <= 0:
		GameState.enemies_killed += 1
		queue_free()
