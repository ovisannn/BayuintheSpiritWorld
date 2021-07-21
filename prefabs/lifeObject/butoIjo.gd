extends KinematicBody2D

export var speed = 10
export var health = 1000

onready var spriteG = $Sprite
onready var ani = $AnimationPlayer
onready var obj = get_parent().get_node("bayu")

var playerOnArea = false
var doing = 'idle'
var phase = 1
var enemyArah = 'kiri'


func doingFunction():
	if playerOnArea == true:
		doing = 'attack'
	if playerOnArea == false:
		doing = 'chasing'
		
		
func attackPhase():
	if health > 700:
		#stomp
		pass
	if health < 700 and health > 300:
		#stomp
		#summon
		pass
	if health <= 300:
		#stomp
		#summon
		#pattern ranged attack
		pass


func animationControll(arah):
	if arah == 'kanan':
		spriteG.flip_h = false
	if arah == 'kiri':
		spriteG.flip_h = true
	
	if doing == 'chasing':
		ani.play("walk")
	if doing == 'attack':
		pass
		


func get_dir(direction):
	var arah = 'kiri'
	if direction[0] > 0:
		arah = 'kanan'
	if direction[0] < 0:
		arah = 'kiri'
	return arah
	
	
#=======================================================================	
func _ready():
	pass
	
func _process(delta):
	
	animationControll(enemyArah)
	
	if doing == 'chasing':
		var dir = (obj.global_position - global_position).normalized()
		move_and_collide(dir * speed * delta)
		enemyArah = get_dir(dir)
		
	if doing == 'attack':
		attackPhase()
		
	if doing == 'dizzy':
		pass
#============================================================


func _on_playerDetector_body_entered(body):
	if body.name == 'bayu':
		doing = 'attack'


func _on_playerDetector_body_exited(body):
	if body.name == 'bayu':
		doing = 'chasing'
