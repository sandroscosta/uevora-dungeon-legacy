extends Node2D

onready var EnemyBase = preload("res://src/scenes/EnemyBase.tscn")
onready var EnemySpawn = get_node("EnemySpawn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	generate_next_wave()

func _process(_delta):
	if GameState.spawn_num_enemies == GameState.enemies_killed:
		generate_next_wave()

func enemy_spawn():
	for i in GameState.spawn_num_enemies:
		var enemy = EnemyBase.instance()
		enemy.speed = rng.randi_range(35,55)
		enemy.position = Vector2(rng.randi_range(50, 200), rng.randi_range(50, 200))
		EnemySpawn.add_child(enemy)

func generate_next_wave():
	GameState.wave += 1
	GameState.spawn_num_enemies = GameState.MAX_ROUND_ENEMIES * GameState.wave
	enemy_spawn()
