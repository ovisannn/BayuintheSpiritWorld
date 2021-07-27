extends KinematicBody2D


onready var ani = $AnimatedSprite
onready var obj = get_parent().get_node("bayu")

export var health = 100
export var speed = 50
export var attack = 50

var kanan = true
var doing = 'idle'
#doing = idle atau chasing

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
	print(health)
	if area.name == 'keris':
		#knockback
		health-=30
