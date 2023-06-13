extends Node

# Cursor sprite manager; Used in Plant.gd

var default = load("res://Assets/GUI/Cursor/CURSOR_DEFAULT.png")
var point = load("res://Assets/GUI/Cursor/CURSOR_POINT.png")
var water = load("res://Assets/GUI/Cursor/CURSOR_WATER.png")
var pick = load("res://Assets/GUI/Cursor/CURSOR_PICK.png") #Art By IG @CuervoSolsticio
var seeds = load("res://Assets/GUI/Cursor/CURSOR_SEEDS.png") 
var prev_cursor = "default"
var override

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
	prev_cursor = cursor_name


func on_hovered():
	Input.set_custom_mouse_cursor(point)

