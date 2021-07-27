extends KinematicBody2D


onready var ani = $AnimatedSprite
onready var obj = get_parent().get_node("bayu")
onready var timer = get_node("Timer")
onready var playerDetect = $playerDetector/CollisionShape2D

var knockback = Vector2.ZERO

export var health = 100
export var speed = 50
export var attack = 50


var kanan = true
var doing = 'idle'
#doing = idle atau chasing

func knocked(a):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * a)
	knockback = move_and_slide(knockback)

func die():
	queue_free()

func aniController():
	if kanan == true :
		ani.flip_h = false
	if kanan == false:
		ani.flip_h = true
		
	if doing == 'idle':
		ani.play('idle')
	if doing == 'chasing':
		ani.play('run')
		
func get_dir(direction):
	if direction[0] > 0:
		return true
	if direction[0] < 0:
		return false
	
func _process(delta):
	aniController()
	knocked(delta)
	if doing == 'chasing':
		var dir = (obj.global_position - global_position).normalized()
		move_and_collide(dir * speed * delta)
		kanan = get_dir(dir)
	if health <= 0:
		die()


func _on_playerDetector_body_entered(body):
	if body.name == 'bayu':
		doing = 'chasing'

func _on_hurtBox_area_shape_entered(area_id, area, area_shape, local_shape):
	if area.name == 'keris':
		health-=30
		if kanan == true:
			knockback = Vector2.LEFT*200
		if kanan == false:
			knockback = Vector2.RIGHT*200


func _on_hurtBox_body_entered(body):
	if body.name == 'bayu':
		playerDetect.disabled = true
		doing = 'idle'
		timer.set_wait_time(1)
		playerDetect.disabled = false
		pass
