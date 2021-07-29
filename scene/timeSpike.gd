extends Node2D

onready var timer = $Timer

func _ready():
	for _i in self.get_children():
		print(_i)

func _process(delta):
	pass
