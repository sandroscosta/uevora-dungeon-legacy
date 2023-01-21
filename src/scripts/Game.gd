extends Node2D

onready var EnemySpawn = get_node("EnemySpawn")
onready var ManaFlask = preload("res://src/scenes/ManaFlask.tscn")
onready var BigManaFlask = preload("res://src/scenes/BigManaFlask.tscn")
onready var HealthFlask = preload("res://src/scenes/HealthFlask.tscn")

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
	var EnemyBase = load(GameState.get_basic_enemy())
	var enemy = EnemyBase.instance()
	enemy.position = Vector2(rng.randi_range(30, 550), rng.randi_range(30, 220))
	EnemySpawn.add_child(enemy)


func _on_ManaSpawnTimer_timeout():
	var mana_flask = null
	var health_flask = null
	
	if GameState.large_mana:
		mana_flask = BigManaFlask.instance()
	else:
		mana_flask = ManaFlask.instance()
	
	mana_flask.position = Vector2(rng.randi_range(80, 420), rng.randi_range(80, 160))
		
	if GameState.health_drops:
		health_flask = HealthFlask.instance()
		health_flask.position = Vector2(rng.randi_range(80, 420), rng.randi_range(80, 160))
		if rng.randi_range(0,5) < 4:
			add_child(mana_flask)
		else:
			add_child(health_flask)
	else:
		add_child(mana_flask)

func _on_EnemySpawnTimer_timeout():
	if spawn_counter < GameState.spawn_num_enemies:
		enemy_spawn()
		spawn_counter += 1
