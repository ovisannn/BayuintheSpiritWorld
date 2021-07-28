extends Node2D


onready var Jawaban = get_node("../../../Puzzle 01").Answer
onready var Kunci = ["Sriwijaya","Singosari","Majapahit"]
onready var Anim = $Button
onready var music = $Pressed_platform

export (String) var answer 

signal door_open

func mechanic():
	Jawaban.append(answer)
	print(Jawaban)
	requirement()
	
	
func requirement():
	if Jawaban == Kunci :
		emit_signal("door_open")
	elif len(Jawaban) >= 3:
		Jawaban.clear()
		print(Jawaban)


func _on_Area2D_body_entered(body):
	Anim.play("Pressed")
	music.play()
	mechanic()


func _on_Area2D_body_exited(body):
	Anim.play("Pressed", true)
