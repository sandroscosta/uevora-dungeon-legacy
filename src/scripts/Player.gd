extends KinematicBody2D

export(int) var SPEED = 75
var velocity: Vector2 = Vector2.ZERO

# comes from the generated build
var player_build: Dictionary

export (PackedScene) var weapon
export (PackedScene) var power
onready var aim = get_node("Aim")
onready var sprite = get_node("AnimatedSprite")

var knockback := Vector2.ZERO
var cursed: bool = false

func _ready():
	player_build = GameState.build
	weapon = load("res://src/scenes/" + player_build["weapon"])
	power = load("res://src/scenes/" + player_build["power"])
	sprite.scale = player_build["build"]["scale"]
	SPEED = player_build["build"]["speed"]
	cursed = GameState.active_curse
	
	if cursed:
		sprite.self_modulate = Color.greenyellow
	
func _input(event):
	if event.is_action_pressed("attack"):
		attack()
	if event.is_action_pressed("power"):
		power()

func get_input():
	velocity = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized() * SPEED

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
	if velocity != Vector2.ZERO:
		sprite.animation = "run"
	else:
		sprite.animation = "idle"
	
	knockback = knockback.move_toward(Vector2.ZERO, 250 * delta)
	knockback = move_and_slide(knockback)
	
	die()

func die():
	if GameState.player_hp <= 0:
		get_tree().change_scene("res://src/scenes/GameOver.tscn")

func attack():
	var weapon_attack = weapon.instance()
	add_child(weapon_attack)
	weapon_attack.transform = aim.transform
	
func power():
	if GameState.player_mana > 0:
		var power_attack = power.instance()
		add_child(power_attack)
		power_attack.transform = aim.transform
		GameState.player_mana -= 2

func _on_HurtBox_body_entered(body):
	if body.is_in_group("enemies"):
		knockback = body.direction * 120
		if body.has_method("deal_damage"):
			GameState.player_hp -= body.deal_damage()


func _on_Timer_timeout():
	if cursed:
		GameState.player_hp -= 1
