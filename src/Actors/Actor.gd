class_name Actor

extends KinematicBody2D

var water = load("res://Assets/GUI/Cursor/CURSOR_WATER.png")

signal clicked
# signal hovered

func _ready():
	print("he entrat en escena") 
	assert(connect("input_event", self, "_on_input_event") == OK)

func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("clic")
			emit_signal("clicked")
	
	#elif event is InputEventMouseMotion:
	#	Input.set_custom_mouse_cursor(water)
	#	emit_signal("hovered")
	#	
	#	print("IN!")
		
		

# Funció On Hover Canvia El Punter

