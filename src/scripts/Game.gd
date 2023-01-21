extends Node2D

onready var EnemyBase = preload("res://src/scenes/EnemyBase.tscn") 
onready var EnemySpawn = get_node("EnemySpawn")
onready var ManaFlask = preload("res://src/scenes/ManaFlask.tscn")
var BossEnemySprite
var boss
var activate_boss: bool = false

var spawn_counter: int = 0

var rng = RandomNumberGenerator.new()

func _ready():
	BossEnemySprite = load(GameState.get_boss_fight())
	boss = BossEnemySprite.instance()
	rng.randomize()
	GameState.generate_next_wave()
	enemy_spawn()

func _process(_delta):
	if GameState.wave < GameState.max_waves:
		if GameState.spawn_num_enemies == GameState.wave_enemy_kills:
			GameState.generate_next_wave()
			spawn_counter = 0
	elif GameState.wave == GameState.max_waves && GameState.spawn_num_enemies == GameState.wave_enemy_kills:
		if !activate_boss:
			boss.position = Vector2(rng.randi_range(30, 550), rng.randi_range(30, 220))
			add_child(boss)
			activate_boss = true
	
	if GameState.boss_killed:
		get_tree().change_scene("res://src/scenes/TreasuryRoomEndGame.tscn")

func enemy_spawn():
	var enemy = EnemyBase.instance()
	enemy.position = Vector2(rng.randi_range(30, 550), rng.randi_range(30, 220))
	EnemySpawn.add_child(enemy)


func _on_ManaSpawnTimer_timeout():
	var flask = ManaFlask.instance()
	flask.position = Vector2(rng.randi_range(50, 450), rng.randi_range(50, 180))
	add_child(flask)


func _on_EnemySpawnTimer_timeout():
	if spawn_counter < GameState.spawn_num_enemies:
		enemy_spawn()
		spawn_counter += 1
