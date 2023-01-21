extends KinematicBody2D

const DEFAULT_SPEED = 75

export (int) var health_points = 10
export (int) var damage = 1
var speed : int = DEFAULT_SPEED
var direction: Vector2

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var animationSprite = get_node("AnimatedSprite")

onready var coin = preload("res://src/scenes/Coin.tscn")

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
		speed *= 1.1

func handle_hit(value):
	health_points -= value

func deal_damage():
	return damage

func check_death():
	if health_points <= 0:
		GameState.enemies_killed += 1
		GameState.wave_enemy_kills += 1
		var drop_coin = coin.instance()
		drop_coin.position = position
		get_parent().add_child(drop_coin)
		queue_free()

func _on_ChaseArea_body_exited(body):
	if body == player:
		speed = DEFAULT_SPEED
