extends KinematicBody2D

export var speed = 10
export var health = 1000
onready var obj = get_parent().get_node("bayu")
var playerOnArea = false

var doing = 'idle'
var phase = 1

func doingFunction():
	if playerOnArea == true:
		doing = 'attack'
	if playerOnArea == false:
		doing = 'chasing'
		
func phaseFunction():
	if health < 700 and health > 300:
		phase = 2
	elif health <= 300:
		phase = 3

func attackPhase():
	if phase == 1:
		pass
	if phase == 2:
		pass
	if phase == 3:
		pass

func animationControll():
	pass
		
func _ready():
	pass
	
func _process(delta):
	phaseFunction()
	animationControll()
	print(doing)
	if doing == 'chasing':
		var dir = (obj.global_position - global_position).normalized()
		move_and_collide(dir * speed * delta)
	if doing == 'attack':
		attackPhase()

func _on_playerDetector_body_entered(body):
	if body.name == 'bayu':
		doing = 'attack'


func _on_playerDetector_body_exited(body):
	if body.name == 'bayu':
		doing = 'chasing'
