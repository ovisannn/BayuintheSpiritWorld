extends Node2D

var selected = false
var rest_point 
var rest_node 

func _ready():
	rest_node = get_tree().get_nodes_in_group("Jawaban")
	rest_point = rest_node[1].global_position

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

func _physics_process(delta):
	if selected :
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else :
		global_position = lerp(global_position, rest_point, 10*delta)
#		pass

func _input(event):
	if event is InputEventMouseButton :
		selected = false
		var shortest_dist = 30
		for child in rest_node :
				var distance = global_position.distance_to(child.global_position)
				if distance < shortest_dist :
					child.select()
					rest_point = child.global_position
					shortest_dist = distance
