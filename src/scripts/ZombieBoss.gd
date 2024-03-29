extends KinematicBody2D

const DEFAULT_SPEED = 40

export (int) var health_points = 120
export (int) var damage = 40
var speed : int = DEFAULT_SPEED
var direction: Vector2

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var animationSprite = get_node("AnimatedSprite")

func _ready():
	if GameState.game_difficulty == GameState.Difficulty.HARD:
		health_points *= GameState.HARDGAME_MODIFIER
		damage *= GameState.HARDGAME_MODIFIER

func _physics_process(_delta):
	direction = (player.position - position).normalized()
	move_and_slide(direction * speed)
	animationSprite.animation = "run"
	check_death()

func _on_ChaseArea_body_entered(body):
	if body == player:
		speed *= 2

func handle_hit(value):
	health_points -= value

func deal_damage():
	return damage

func check_death():
	if health_points <= 0:
		GameState.boss_killed = true
		GameState.treasure += 1000
		queue_free()


func _on_ChaseArea_body_exited(body):
	if body == player:
		speed = DEFAULT_SPEED
