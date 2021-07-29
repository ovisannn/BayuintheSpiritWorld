extends Node2D


var speed = 80

onready var timer = $Timer

func _ready():
	timer.start(3)

func _process(delta):
	position += transform.x* speed*delta


func _on_Timer_timeout():
	queue_free()
