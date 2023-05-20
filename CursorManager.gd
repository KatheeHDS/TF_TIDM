extends Node

# Load the custom images for the mouse cursor.
var default = load("res://Assets/GUI/Cursor/CURSOR_DEFAULT.png")
var point = load("res://Assets/GUI/Cursor/CURSOR_POINT.png")
var water = load("res://Assets/GUI/Cursor/CURSOR_WATER.png")
var pick = load("res://Assets/GUI/Cursor/CURSOR_PICK.png")
var seeds = load("res://Assets/GUI/Cursor/CURSOR_SEEDS.png") # TODO: CHange with seeds
var prev_cursor = "default"

# This is used to set a cursor that takes priority over others
var override

func _ready():
	pass

func set_cursor_override(cursor_name):
	override = false
	set_cursor(cursor_name)
	override = true

func clear_cursor_override():
	override = false
	set_cursor("default")

func set_cursor(cursor_name):
	if override:
		return
	if cursor_name == prev_cursor:
		return
	elif cursor_name == "water":
		Input.set_custom_mouse_cursor(water)
	elif cursor_name == "default":
		Input.set_custom_mouse_cursor(default)
	elif cursor_name == "pick":
		Input.set_custom_mouse_cursor(pick)
	elif cursor_name == "point":
		Input.set_custom_mouse_cursor(point)
	elif cursor_name == "seeds":
		Input.set_custom_mouse_cursor(seeds)
	else:
		assert(false, "invalid cursor")
	#afegir variable que guardi l'últim cursor
	prev_cursor = cursor_name


func on_hovered():
	Input.set_custom_mouse_cursor(point)
	print("Hoverat")
