extends Node2D


var speed = 80

func _process(delta):
	position += transform.x* speed*delta


func _on_Timer_timeout():
	queue_free()
