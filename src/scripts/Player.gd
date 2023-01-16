extends KinematicBody2D

export (int) var health = GameState.get_max_hp()
export(int) var SPEED = 75
var velocity: Vector2 = Vector2.ZERO
var player_scale: Vector2 = Vector2.ZERO


func _ready():
	player_scale = GameState.proportions["regular"]
	scale = player_scale

func get_input():
	velocity = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized() * SPEED

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	die()

func die():
	if GameState.player_hp <= 0:
		print("DEAD")


func _on_HurtBox_body_entered(body):
	if body.is_in_group("enemies"):
		if body.has_method("deal_damage"):
			GameState.player_hp -= body.deal_damage()
