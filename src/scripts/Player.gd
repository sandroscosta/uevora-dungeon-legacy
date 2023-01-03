extends KinematicBody2D

export(int) var SPEED = 75
var velocity: Vector2 = Vector2.ZERO

func get_input():
	velocity = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized() * SPEED

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
