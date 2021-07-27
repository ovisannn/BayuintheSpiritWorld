extends Node2D

onready var ani = $AnimatedSprite
onready var coll = $Area2D/CollisionShape2D

export var spikeActive = true

func activate():
	spikeActive = true
	coll.disabled = false
	ani.play('spikeOnAni')

func deactivate():
	spikeActive = true
	coll.disabled = false
	ani.play('SpikeOffAni')

func _process(_delta):
	if spikeActive == false:
		activate()
	elif spikeActive == true:
		deactivate()


func _on_AnimatedSprite_animation_finished():
	if ani.name == 'spikeOnAni':
		ani.play('on')
	if ani.name == 'SpikeOffAni':
		ani.play('off')
