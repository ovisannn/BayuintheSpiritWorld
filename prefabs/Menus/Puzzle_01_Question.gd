extends Control



func _on_bayu_question_ui_on():
	self.set_visible(true)


func _on_bayu_question_ui_off():
	self.set_visible(false)


func _on_interact_area_body_exited(body):
	self.set_visible(false)


func _on_Button_pressed():
	self.set_visible(false)
