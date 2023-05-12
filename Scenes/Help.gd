extends Node2D
signal back

func _ready():
	assert(get_node("BackButton").connect("pressed", self, "go_back") == OK)
	
func go_back():
	SoundManager.sfx("click")
	# emit_signal("back")
	print("Going back!")
	self.queue_free()
