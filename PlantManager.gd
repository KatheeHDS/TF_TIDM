extends Node
#Aquí anirà la generació de plantes
var Planta = preload("res://src/Actors/Player.tscn")

func _ready():
	var nova_planta = Planta.instance()
	nova_planta.max_hp = 120
	add_child(nova_planta)
	# test git sync
	
	#
