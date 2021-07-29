extends Node2D

onready var ost = $OST


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicController.stop_music()
	ost.play()
	get_tree().set_pause(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
