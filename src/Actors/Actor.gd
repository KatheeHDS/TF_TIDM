class_name Actor

extends KinematicBody2D

signal clicked


func _ready():
	print("he entrat en escena") 
	connect("input_event", self, "_on_input_event")

func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("clic")
			emit_signal("clicked")


