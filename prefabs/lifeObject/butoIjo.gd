extends KinematicBody2D

export var speed = 10
export var health = 1000

onready var spriteG = $Sprite
onready var ani = $AnimationPlayer
onready var obj = get_parent().get_node("bayu")
onready var bld = $blood
onready var shootTimer = $shootTimer
onready var rotater = $rotater
const projectile = preload("res://prefabs/lifeObject/projectile.tscn")
onready var bodycrush = $bodyCrush/CollisionShape2D
onready var vict = $"victoryScreen/Victory Screen"
onready var getHit = $gothit
onready var butoCry = $butoSound

var playerOnArea = false
var doing = 'chasing'
var phase = 1
var enemyArah = 'kiri'
var knockback = Vector2.ZERO

const rotateSpeed = 30
var shooterWaitTime = 0.5
const spawnPointCount = 4
const radius = 25


func die():
	pass
	
func doingFunction():
	if playerOnArea == true:
		doing = 'attack'
	if playerOnArea == false:
		doing = 'chasing'
		

func knocked(a):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * a)
	knockback = move_and_slide(knockback)
	

func normalAttack(delta):
		var dir = (obj.global_position - global_position).normalized()
		move_and_collide(dir * 100 * delta)
		enemyArah = get_dir(dir)
	
func attackPhase():
	if health > 700:
		pass
	if health < 700 and health > 300:
		shooterWaitTime = 1
		speed = 50
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
	if direction[0] > 0:
		return 'kanan'
	if direction[0] < 0:
		return 'kiri'
	

func _shootPatern():
	var step = 2 * PI / spawnPointCount
	for i in range(spawnPointCount):
		var spawnPoint = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step*i)
		spawnPoint.position = pos
		spawnPoint.rotation = pos.angle()
		rotater.add_child(spawnPoint)
		
	shootTimer.wait_time = shooterWaitTime
	shootTimer.start()
#=======================================================================	
func _ready():
	butoCry.play()
	_shootPatern()
	
func _process(delta):
	if health <=0:
		vict.visible = true
		die()
	
	var newRotation = rotater.rotation_degrees * rotateSpeed * delta
	rotater.rotation_degrees = fmod(newRotation, 360)
	knocked(delta)
	animationControll(enemyArah)
	attackPhase()
	
	if doing == 'chasing':
		var dir = (obj.global_position - global_position).normalized()
		move_and_collide(dir * speed * delta)
		enemyArah = get_dir(dir)
		
	if doing == 'attack':
		normalAttack(delta)
		bodycrush.disabled = false
	if doing == 'dizzy':
		pass
#============================================================


func _on_playerDetector_body_entered(body):
	if body.name == 'bayu':
		shootTimer.set_wait_time(3)
		doing = 'attack'


func _on_playerDetector_body_exited(body):
	if body.name == 'bayu':
		doing = 'chasing'


func _on_shootTimer_timeout():
	for s in rotater.get_children():
		var bullet = projectile.instance()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation


func _on_hurtBox_area_shape_entered(area_id, area, area_shape, local_shape):
	print(health)
	if area.name == 'keris':
		health -= 50
		getHit.play()
		bld.emitting = true
		if enemyArah == 'kanan':
			knockback = Vector2.LEFT*70
		if enemyArah == 'kiri':
			knockback = Vector2.RIGHT*70


func _on_bodyCrush_body_entered(body):
	if body.name == 'bayu':
		if enemyArah == 'kanan':
			knockback = Vector2.LEFT*70
		if enemyArah == 'kiri':
			knockback = Vector2.RIGHT*70
	bodycrush.disabled = true
	doing = 'idle'
	shootTimer.set_wait_time(4)
