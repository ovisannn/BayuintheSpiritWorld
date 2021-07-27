 extends "res://script/bayu.gd"

#iki script tambahan vi, script main e ndek scene bayu dewe , tujuane ben penak lak nambahi wkwkwkwk

signal question_ui_on
signal question_ui_off

var toggle_quest_ui = false



func interaction():
#	print("Kamu berhasil")
	if Input.is_action_just_pressed("interact"):
		if toggle_quest_ui == false :
			toggle_quest_ui = true
			emit_signal("question_ui_on")
		elif toggle_quest_ui == true :
			toggle_quest_ui = false
			emit_signal("question_ui_off")

func _on_interact_area_body_entered(body):
	action = true


func _on_interact_area_body_exited(body):
	action = false
	toggle_quest_ui = false
