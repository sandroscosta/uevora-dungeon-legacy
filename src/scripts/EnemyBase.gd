extends KinematicBody2D

export (int) var health_points = 20
export (int) var damage = 5
var speed : int = 50
var direction

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var animationSprite = get_node("AnimatedSprite")

func _physics_process(_delta):
	direction = (player.position - position).normalized()
	move_and_slide(direction * speed)
	animationSprite.animation = "run"
	print(speed)
	check_death()

func _on_ChaseArea_body_entered(body):
	if body == player:
		speed *= 1.2

func handle_hit(value):
	health_points -= value

func deal_damage():
	return damage

func check_death():
	if health_points <= 0:
		GameState.enemies_killed += 1
		GameState.wave_enemy_kills += 1
		queue_free()


func _on_ChaseArea_body_exited(body):
	if body == player:
		speed = 50
