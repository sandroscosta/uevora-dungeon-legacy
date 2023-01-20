extends Node2D

onready var EnemyBase = preload("res://src/scenes/EnemyBase.tscn")
onready var EnemySpawn = get_node("EnemySpawn")
onready var ManaFlask = preload("res://src/scenes/ManaFlask.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	GameState.generate_next_wave()
	enemy_spawn()

func _process(_delta):
	if GameState.wave < GameState.max_waves:
		if GameState.spawn_num_enemies == GameState.wave_enemy_kills:
			GameState.generate_next_wave()
			enemy_spawn()

func enemy_spawn():
	for i in GameState.spawn_num_enemies:
		var enemy = EnemyBase.instance()
		enemy.position = Vector2(rng.randi_range(50, 200), rng.randi_range(50, 200))
		EnemySpawn.add_child(enemy)


func _on_ManaSpawnTimer_timeout():
	var flask = ManaFlask.instance()
	flask.position = Vector2(rng.randi_range(50, 200), rng.randi_range(50, 200))
	add_child(flask)
