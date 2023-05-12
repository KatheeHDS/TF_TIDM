extends Node2D

signal config_popup
signal help_popup
signal almanac_popup

func _ready():
	assert(get_node("HelpButton").connect("pressed", self, "on_help_clicked") == OK)
	assert(get_node("OptionsButton").connect("pressed", self, "on_options_clicked") == OK)
	assert(get_node("AlmanacButton").connect("pressed", self, "open_almanac") == OK)
	
func on_help_clicked():
	SoundManager.sfx("error")
	emit_signal("help_popup")

func on_options_clicked():
	SoundManager.sfx("error")
	emit_signal("config_popup")

func open_almanac():
	SoundManager.sfx("click")
	emit_signal("almanac_popup")
