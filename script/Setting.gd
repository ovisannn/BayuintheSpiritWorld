extends Control

var is_fullscreen 


func _ready():
	if OS.is_window_fullscreen() == true :
		is_fullscreen = true
#		print("bisa")
		$Fullscreen.set_pressed(is_fullscreen)
	else :
		is_fullscreen = false
		$Fullscreen.set_pressed(is_fullscreen)
	


func _on_Fullscreen_pressed():
	if is_fullscreen == false :
		is_fullscreen = true
#		print("full")
	elif is_fullscreen == true :
		is_fullscreen = false
#		print("not full")



func _on_Conf_button_pressed():
	OS.set_window_fullscreen(is_fullscreen)
