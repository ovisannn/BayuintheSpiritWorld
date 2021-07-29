extends Node2D

signal spike_off

onready var music = $Pressed_platform
onready var platform = $Button

func _on_Area2D_body_entered(body):
	$Button.play("Pressed")
	music.play()
	emit_signal("spike_off")
