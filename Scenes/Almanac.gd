extends Node2D

# Almanac scene manager

func _ready():
	self.z_index = 2000
	assert(get_node("BackButton").connect("pressed", self, "go_back") == OK)

func go_back():
	SoundManager.sfx("click")
	self.queue_free()
