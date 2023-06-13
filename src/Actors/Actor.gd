class_name Actor

# Actor class: created to manage all planned actors: plants, 
# mobs and foes (these last two are unimplemented) 

extends KinematicBody2D

var water = load("res://Assets/GUI/Cursor/CURSOR_WATER.png")

signal clicked

func _ready():
	assert(connect("input_event", self, "_on_input_event") == OK)

func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked")
	
