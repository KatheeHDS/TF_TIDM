extends Node2D

# Help scene manager

signal back

func _ready():
	self.z_index = 2000
	assert(get_node("BackButton").connect("pressed", self, "go_back") == OK)
	
func go_back():
	SoundManager.sfx("click")
	emit_signal("back")
	self.queue_free()
