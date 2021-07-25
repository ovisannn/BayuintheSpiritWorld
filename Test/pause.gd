extends Node2D

var pause = false


func _on_bayu_paused_state():
	if pause == false :
		get_tree().paused = true
		pause = true
		$bayu/Pause_screen.show()
	elif pause == true :
		$bayu/Pause_screen.hide()
		pause = false
		get_tree().paused = false
	
