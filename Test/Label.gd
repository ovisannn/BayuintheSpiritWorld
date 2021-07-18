extends Label




func _on_Area2D_body_entered(body):
	self.set_visible(true)


func _on_Area2D_body_exited(body):
	self.set_visible(false)
