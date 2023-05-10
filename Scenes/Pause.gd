extends Node2D

signal options_popup
signal help_popup
signal exit_game

func _ready():
	get_node("HelpButton").connect("pressed", self, "on_help_clicked")
	get_node("OptionsButton").connect("pressed", self, "on_options_clicked")	
	get_node("ExitButton").connect("pressed", self, "exit_game")
	
func on_help_clicked():
	SoundManager.sfx("error")
	emit_signal("help_popup")

func on_options_clicked():
	SoundManager.sfx("error")
	emit_signal("options_popup")

func exit_game():
	SoundManager.sfx("click")
	emit_signal("exit_game")
