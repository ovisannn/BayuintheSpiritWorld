extends Control

var is_fullscreen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Fullscreen_pressed():
	if is_fullscreen == false :
		is_fullscreen = true
		print("full")
	elif is_fullscreen == true :
		is_fullscreen = false
		print("not full")



func _on_Conf_button_pressed():
	OS.set_window_fullscreen(is_fullscreen)
