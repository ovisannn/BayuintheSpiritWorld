extends Node2D

onready var ani = $AnimatedSprite
onready var coll = $Area2D/CollisionShape2D
onready var timer = $Timer

export var spikeActive = true

func activate():
	spikeActive = true
	coll.disabled = false
	ani.play('spikeOnAni')

func deactivate():
	spikeActive = false
	coll.disabled = true
	ani.play('SpikeOffAni')

func _ready():
	pass

func _process(_delta):
	spikeActive = false
	if spikeActive == true:
		deactivate()
	if spikeActive == false:
		activate()


func _on_AnimatedSprite_animation_finished():
	if ani.name == 'spikeOnAni':
		ani.play('on')
	if ani.name == 'SpikeOffAni':
		ani.play('off')
