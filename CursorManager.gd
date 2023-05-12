extends Node


# Load the custom images for the mouse cursor.
var default = load("res://Assets/GUI/Cursor/CURSOR_DEFAULT.png")
var point = load("res://Assets/GUI/Cursor/CURSOR_POINT.png")
var water = load("res://Assets/GUI/Cursor/CURSOR_WATER.png")
var pick = load("res://Assets/GUI/Cursor/CURSOR_PICK.png")


func _ready():
	pass

func set_cursor(cursor_name):
	if cursor_name == "water":
		Input.set_custom_mouse_cursor(water)
	elif cursor_name == "default":
		Input.set_custom_mouse_cursor(default)
	elif cursor_name == "pick":
			Input.set_custom_mouse_cursor(pick)
	elif cursor_name == "point":
		Input.set_custom_mouse_cursor(point)
	else:
		assert(false, "invalid cursor")



func on_hovered():
	Input.set_custom_mouse_cursor(point)
	print("Hoverat")
