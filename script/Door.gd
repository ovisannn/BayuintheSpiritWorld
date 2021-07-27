extends Node2D

onready var doorColl = $StaticBody2D/door
onready var doorTexture = $doorTexture
onready var lightOc = $LightOccluder2D

const doorOpen = preload("res://asset/dungeon/door open.png")
const doorClosed = preload("res://asset/dungeon/door closed.png")

export var bukaPintu = true

func openDoor():
	doorTexture.texture = doorOpen
	doorColl.disabled = true
	lightOc.visible = false
	
func closeDoor():
	doorTexture.texture = doorClosed
	doorColl.disabled = false
	lightOc.visible = true

func _init():
	pass
	
func _process(_delta):
	if bukaPintu == false:
		closeDoor()
	if bukaPintu == true:
		openDoor()

func _on_interactionArea_body_entered(body):
	pass


func _on_PlatformA_door_open():
	bukaPintu = true
