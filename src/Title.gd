extends Node2D

signal start_game
signal config_popup
signal exit_game
signal credits_popup
signal help_popup
signal almanac_popup
signal roadmap_popup

func _ready():
	assert(get_node("StartButton").connect("pressed", self, "on_game_start") == OK)
	assert(get_node("ExitButton").connect("pressed", self, "exit_game") == OK)
	assert(get_node("ConfigButton").connect("pressed", self, "open_config") == OK)
	assert(get_node("HelpButton").connect("pressed", self, "open_help") == OK)
	assert(get_node("CreditsButton").connect("pressed", self, "open_credits") == OK)
	assert(get_node("AlmanacButton").connect("pressed", self, "open_almanac") == OK)
	assert(get_node("FutureButton").connect("pressed", self, "open_roadmap") == OK)
	assert(get_node("BackButton").connect("pressed", self, "go_back") == OK)


	
func on_game_start(): #OK
	SoundManager.sfx("click")
	emit_signal("start_game")

func exit_game(): #OK
	SoundManager.sfx("click")
	emit_signal("exit_game")

func open_config(): #OK
	SoundManager.sfx("click")
	emit_signal("config_popup")

func open_credits(): #OK
	SoundManager.sfx("click")
	emit_signal("credits_popup")

func open_help(): #OK
	SoundManager.sfx("click")
	emit_signal("help_popup")

#TODO
func open_almanac(): #OK
	SoundManager.sfx("click")
	emit_signal("almanac_popup")

#TODO (ESTEM A TITLE.GD)
func open_roadmap():#OK
	SoundManager.sfx("click")
	emit_signal("roadmap_popup")
	
func go_back():#UNUSED
	SoundManager.sfx("click")
	emit_signal("back")
