extends KinematicBody2D

export(int) var SPEED = 75
var velocity: Vector2 = Vector2.ZERO

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * SPEED

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
