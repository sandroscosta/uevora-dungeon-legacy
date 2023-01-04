extends Node2D

onready var EnemyBase = preload("res://src/scenes/EnemyBase.tscn")
onready var EnemySpawn = get_node("EnemySpawn")

func _ready():
	enemy_spawn()


func enemy_spawn():
	var enemy = EnemyBase.instance()
	print(enemy)
	enemy.position = Vector2(100, 100)
	EnemySpawn.add_child(enemy)
