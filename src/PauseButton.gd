extends TextureButton

func _ready():
	#self.z_index = 2000
	#assert(get_node("PauseButton").connect("pressed", self, "open_pause_menu") == OK)
	pass
func open_pause_menu():
	print("pause opened?")
	# A) send signal to game manager to open pause menu?
	# B) crida _unhandled_input(event) simulant que es un press de la ESC KEY
	# event is InputEventKey and event.scancode == KEY_ESCAPE and event.is_pressed()

