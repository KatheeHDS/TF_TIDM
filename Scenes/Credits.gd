extends Node2D

# Credits scene manager

func _ready():
	assert(get_node("BackButton").connect("pressed", self, "go_back") == OK)
	
func go_back():
	SoundManager.sfx("click")
	self.queue_free()

