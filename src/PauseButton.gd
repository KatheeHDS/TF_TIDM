extends TextureButton

# UNUSED CODE, DEAD CODE. Intended use: to make the pause hint on the upper right corner interactable.

func open_pause_menu():
	print("pause opened?")
	# A) send signal to game manager to open pause menu?
	# B) crida _unhandled_input(event) simulant que es un press de la ESC KEY
	# event is InputEventKey and event.scancode == KEY_ESCAPE and event.is_pressed()

