extends KinematicBody2D

export var speed = 70
export var friction = 0.13
export var acceleration = 0.1
export var attack = 0
export var health = 0

var right = true

onready var ani = $AnimationPlayer

var velocity = Vector2()

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('ui_right'):
		input.x += 1
	if Input.is_action_pressed('ui_left'):
		input.x -= 1
	if Input.is_action_pressed('ui_down'):
		input.y += 1
	if Input.is_action_pressed('ui_up'):
		input.y -= 1
	return input

func animation(get_dir):
	
	if get_dir[0] == 0 and get_dir[1] == 0:
		if right == true:
			ani.play("idle_right")
		else:
			ani.play("idle_left")
	
	if get_dir[0] > 0:
		right = true
		ani.play("run_right")
	if get_dir[0] < 0:
		right = false
		ani.play("run_left")
		
	if get_dir[1] != 0:
		if right == true:
			ani.play("run_right")
		else:
			ani.play("run_left")

func _physics_process(_delta):
	var direction = get_input()
	animation(direction)
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	velocity = move_and_slide(velocity)
