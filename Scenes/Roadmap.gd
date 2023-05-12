extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	assert(get_node("BackButton").connect("pressed", self, "go_back") == OK)

func go_back():
	SoundManager.sfx("click")
	# emit_signal("back")
	print("Going back!")
	self.queue_free()
