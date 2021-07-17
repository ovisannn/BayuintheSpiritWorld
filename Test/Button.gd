extends Node2D


onready var Jawaban = get_node("../Portal").Answer
onready var Kunci = ["red","blue","red"]
onready var Anim = $Button

signal door_open

func mechanic():
	Jawaban.append("red")
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
	mechanic()


func _on_Area2D_body_exited(body):
	Anim.play("Pressed", true)
