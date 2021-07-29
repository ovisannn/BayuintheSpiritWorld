extends KinematicBody2D

export var speed = 70
export var friction = 0.13
export var acceleration = 0.1
export var attack = 0
export var health = 3

var right = true
var interact = false
var atk = false
signal paused_state
var not_move = false
var knockback = Vector2.ZERO
var alive = true
var asd = Vector2.ZERO

onready var ani = $bayuAnimation
onready var weapAni = $weapAnimation
onready var weapCol = $weapon/Sprite/keris/CollisionShape2D
onready var bld = $blood

signal mati

var velocity = Vector2()

func get_input():
	var input = Vector2()
	if not_move == false :
		if Input.is_action_pressed('ui_right'):
			input.x += 1
		if Input.is_action_pressed('ui_left'):
			input.x -= 1
		if Input.is_action_pressed('ui_down'):
			input.y += 1
		if Input.is_action_pressed('ui_up'):
			input.y -= 1

	return input


func knocked(a):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * a)
	knockback = move_and_slide(knockback)


func attack(get_dir):
	if Input.is_action_pressed("attack") and atk == false:
		atk = true
		if right == true or get_dir[0] > 0:
			weapAni.play("atkRight")
		if right == false or get_dir[0] < 0:
			weapAni.play("atkLeft")
		if get_dir[1] > 0 :
			weapAni.play("atkBottom")
		if get_dir[1] < 0 :
			weapAni.play("atkUp")
		
		
func animation(get_dir):
	if get_dir[0] == 0 and get_dir[1] == 0 and atk == false:
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

func interaction():
	pass
   
func hidup():
	if health <= 0:
		return false
	if health > 0 :
		return true


func _physics_process(delta):
	alive = hidup()
	
	if alive == true:
		knocked(delta)
		var direction = get_input()
		asd = direction
		if not_move == false :
			animation(direction)
			attack(direction)
		
		
			if direction.length() > 0:
				velocity = lerp(velocity, direction.normalized() * speed, acceleration)
			else:
				velocity = lerp(velocity, Vector2.ZERO, friction)
			velocity = move_and_slide(velocity)
				
		
		if interact == true : #TEST PUZZLE
			interaction()   #TESTPUZZLE
			
		
		if Input.is_action_just_pressed("pause"):
			emit_signal("paused_state")
		
	if alive == false:
		emit_signal("mati")
		get_tree().paused


func _on_weapAnimation_animation_finished(anim_name):
	if anim_name == 'atkLeft' or anim_name == 'atkRight' or anim_name == 'atkBottom' or anim_name == 'atkUp':
		atk = false


func _on_weapAnimation_animation_started(anim_name):
	if anim_name == 'atkLeft' or anim_name == 'atkRight' or anim_name == 'atkBottom' or anim_name == 'atkUp':
		weapCol.disabled = false


func _on_hitBox_area_shape_entered(area_id, area, area_shape, local_shape):
	if area.is_in_group('enemy'):
		health-=1
		bld.emitting = true
		if right == true:
			knockback = Vector2.LEFT*200
		if right == false:
			knockback = Vector2.RIGHT*200
		if asd[1] == -1:
			knockback = Vector2.DOWN*200
		if asd[1] == 1:
			knockback = Vector2.UP*200


func _on_bayu_mati():
	pass # Replace with function body.
