extends Node
var game_scene = preload("res://src/Main.tscn")
var splash_screen = preload("res://Scenes/Splash.tscn")
var game_title = preload("res://Scenes/Title.tscn")
var pause_menu = preload("res://Scenes/Pause.tscn")
var pause_opened = false


func _ready():
	print ("hola")
	var splash = splash_screen.instance()
	splash.name = "splash"
	add_child(splash)
	yield(get_tree().create_timer(2.0), "timeout")
	splash.queue_free()
	var title = game_title.instance()
	title.name = "title"
	add_child(title)
	title.connect("start_game", self, "on_game_started")
	title.connect("exit_game", self, "on_game_exited")



func on_game_started():
	var game = game_scene.instance()
	game.name = "game"
	add_child(game)
	get_node("title").queue_free()
	
func on_game_exited():
	print("CLOSING GAME")
	get_tree().quit()

	
func _unhandled_input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE and event.is_pressed():		
		if not pause_opened:
			var pause = pause_menu.instance()
			pause.name = "pause"
			add_child(pause)
			print("Paused")
			get_tree().paused = true
		else:
			get_node("pause").queue_free()
			print("Playing")
			get_tree().paused = false
		 
		pause_opened = not pause_opened
