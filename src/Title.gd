extends Node2D

signal start_game
signal config_popup
signal exit_game

func _ready():
	assert(get_node("StartButton").connect("pressed", self, "on_game_start") == OK)
	assert(get_node("ExitButton").connect("pressed", self, "exit_game") == OK)
	assert(get_node("ConfigButton").connect("pressed", self, "open_config") == OK)
	
func on_game_start():
	SoundManager.sfx("click")
	emit_signal("start_game")

func exit_game():
	SoundManager.sfx("click")
	emit_signal("exit_game")

func open_config():
	SoundManager.sfx("error")
	emit_signal("config_popup")
