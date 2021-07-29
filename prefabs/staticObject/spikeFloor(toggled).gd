extends Node2D


onready var ani = $AnimatedSprite
onready var coll = $Area2D/CollisionShape2D


var spikeActive 

func _ready():
	spikeActive = false


func activate():
	coll.disabled = false
	ani.play('spikeOnAni')

func deactivate():
	coll.disabled = true
	ani.play('SpikeOffAni')



func _process(_delta):
	
	if spikeActive == true:
		deactivate()
	if spikeActive == false:
		activate()


func _on_AnimatedSprite_animation_finished():
	if ani.name == 'spikeOnAni':
		ani.play('on')
	if ani.name == 'SpikeOffAni':
		ani.play('off')
