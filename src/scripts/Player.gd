extends KinematicBody2D

export(int) var SPEED = 75
var velocity: Vector2 = Vector2.ZERO
var player_scale: Vector2 = Vector2.ZERO

export (PackedScene) var weapon
export (PackedScene) var power
onready var aim = get_node("Aim")

var knockback := Vector2.ZERO

func _ready():
	player_scale = GameState.chose_proportions["regular"]
	weapon = load("res://src/scenes/" + GameState.chose_weapons[0])
	power = load("res://src/scenes/" + GameState.chose_powers[0])
	scale = player_scale
	
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
	
	knockback = knockback.move_toward(Vector2.ZERO, 200*delta)
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
