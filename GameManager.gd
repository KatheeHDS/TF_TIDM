extends Node



var GameScene = preload("res://src/Main.tscn")
var SplashScreen = preload("res://Scenes/Splash.tscn")
var GameTitle = preload("res://Scenes/Title.tscn")
var PauseMenu = preload("res://Scenes/Pause.tscn")
var pause_opened = false
var HelpScreen = preload("res://Scenes/Help.tscn")
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
	title.connect("help_popup", self, "on_help_seeked")
	# title.connect("back", self, "on_back_clicked")
	title.connect("almanac_popup", self, "on_almanac_opened")
	title.connect("config_popup", self, "on_options_opened")
	title.connect("credits_popup", self, "on_credits_opened")
	title.connect("roadmap_popup", self, "on_roadmap_opened")

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

func on_help_seeked():
	var help = HelpScreen.instance()
	help.name = "help"
	add_child(help)
	


func on_almanac_opened():
	print("ALMANAC OPENS NOW")

func on_options_opened():
	print("OPTIONS OPENS NOW")
	
func on_credits_opened():
	print("CREDITS OPENS NOW")

func on_roadmap_opened():
	print("ROADMAP OPENS NOW")
	
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
