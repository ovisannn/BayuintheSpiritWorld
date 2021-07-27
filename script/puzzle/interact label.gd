extends Label



func _on_interact_area_body_entered(body):
	self.set_visible(true)


func _on_interact_area_body_exited(body):
	self.set_visible(false)
