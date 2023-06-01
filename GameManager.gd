extends Node



var GameScene = preload("res://src/Main.tscn")
var SplashScreen = preload("res://Scenes/Splash.tscn")
var GameTitle = preload("res://Scenes/Title.tscn")
var PauseMenu = preload("res://Scenes/Pause.tscn")
var pause_opened = false
var HelpScreen = preload("res://Scenes/Help.tscn") 
var CreditsScreen = preload("res://Scenes/Credits.tscn")
var ConfigScreen = preload("res://Scenes/Options.tscn")
var GuideScreen = preload("res://Scenes/Almanac.tscn")
var RoadmapScreen = preload("res://Scenes/Roadmap.tscn")
var VictoryScreen = preload("res://Scenes/VICTORY_SCREEN.tscn")

var default = load("res://Assets/GUI/Cursor/CURSOR_DEFAULT.png")

func _ready():
	print ("hola")
	var splash = SplashScreen.instance()
	splash.name = "splash"
	add_child(splash)
	Input.set_custom_mouse_cursor(default) # sets custom cursor
	yield(get_tree().create_timer(2.0), "timeout") #splashscreen timer
	splash.queue_free()
	create_main_menu()

func create_main_menu():
	var title = GameTitle.instance()
	title.name = "title"
	add_child(title)
	print("menu created!")
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
	game.get_node("PlantManager").connect("win_state", self, "on_victory_achieved")
	
	
func on_game_exited():
	print("CLOSING GAME")
	on_credits_opened()
	yield(get_tree().create_timer(5.0), "timeout")
	get_tree().quit()

func on_help_seeked():
	var help = HelpScreen.instance()
	help.name = "help"
	add_child(help)
	
func on_victory_achieved():
	change_HUD()
	print("Victory popup")
	var win = VictoryScreen.instance()
	win.name = "win"
	add_child(win)
	
func change_HUD():
	$game.get_node("InventoryHUD").get_node("TextureRect").texture = load("res://Assets/GUI/INVENTORY_TAB_VICTORY.png")
	$game.get_node("Background").get_node("Mountain").texture = load("res://Assets/Backgrounds/MOUNTAIN_GREEN.png")


func on_almanac_opened():
	print("ALMANAC OPENS NOW")
	var almanac = GuideScreen.instance()
	almanac.name = "almanac"
	add_child(almanac)
	

func on_options_opened():
	print("OPTIONS OPENS NOW")
	var config = ConfigScreen.instance()
	config.name = "config"
	add_child(config)
	config.connect("almanac_popup", self, "on_almanac_opened")

	
func on_credits_opened():
	print("CREDITS OPENS NOW")
	var credits = CreditsScreen.instance()
	credits.name = "credits"
	add_child(credits)
	

func on_roadmap_opened():
	print("ROADMAP OPENS NOW")
	var roadmap = RoadmapScreen.instance()
	roadmap.name = "roadmap"
	add_child(roadmap)
	
func _unhandled_input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE and event.is_pressed():		
		if not pause_opened:
			var pause = PauseMenu.instance()
			pause.name = "pause"
			add_child(pause)
			pause.connect("help_popup", self, "on_help_seeked")
			pause.connect("config_popup", self, "on_options_opened")
			pause.connect("almanac_popup", self, "on_almanac_opened")
			pause.connect("back_menu", self, "back_to_menu")
			print("Paused")
			get_tree().paused = true
		else:
			get_node("pause").queue_free()
			print("Playing")
			get_tree().paused = false
		 
		pause_opened = not pause_opened

func back_to_menu():
	get_node("game").queue_free()
	get_node("pause").queue_free()
	create_main_menu()

