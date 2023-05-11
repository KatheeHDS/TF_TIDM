extends Node
var GameScene = preload("res://src/Main.tscn")
var SplashScreen = preload("res://Scenes/Splash.tscn")
var GameTitle = preload("res://Scenes/Title.tscn")
var PauseMenu = preload("res://Scenes/Pause.tscn")
var pause_opened = false
var CreditsScreen = preload("res://Scenes/Credits.tscn")
var default = load("res://Assets/GUI/Cursor/CURSOR_DEFAULT.png")

func _ready():
	print ("hola")
	var splash = SplashScreen.instance()
	splash.name = "splash"
	add_child(splash)
	Input.set_custom_mouse_cursor(default) # sets custom cursor
	yield(get_tree().create_timer(2.0), "timeout") #splashscreen timer
	splash.queue_free()
	var title = GameTitle.instance()
	title.name = "title"
	add_child(title)
	title.connect("start_game", self, "on_game_started")
	title.connect("exit_game", self, "on_game_exited")




func on_game_started():
	var game = GameScene.instance()
	game.name = "game"
	add_child(game)
	get_node("title").queue_free()
	
func on_game_exited():
	print("CLOSING GAME")
	var credits = CreditsScreen.instance()
	credits.name = "credits"
	add_child(credits)
	yield(get_tree().create_timer(5.0), "timeout")
	credits.queue_free()
	get_tree().quit()

	
func _unhandled_input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE and event.is_pressed():		
		if not pause_opened:
			var pause = PauseMenu.instance()
			pause.connect("exit_game", self, "on_game_exited")
			pause.name = "pause"
			add_child(pause)
			print("Paused")
			get_tree().paused = true
		else:
			get_node("pause").queue_free()
			print("Playing")
			get_tree().paused = false
		 
		pause_opened = not pause_opened
