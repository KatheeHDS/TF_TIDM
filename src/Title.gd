extends Node2D

signal start_game
signal exit_game

func _ready():
	get_node("StartButton").connect("pressed", self, "on_game_start")
	get_node("ExitButton").connect("pressed", self, "exit_game")
	
func on_game_start():
	emit_signal("start_game")

func exit_game():
	emit_signal("exit_game")
