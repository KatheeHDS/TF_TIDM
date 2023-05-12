extends Node2D
#TODO THIS DOES NOTHING YETTTTTTT
# TOGGLE BGM ON/OFF
# TOGGLE SFX ON/OFF
# TOGGLE ANIMATIONS ON/OFF

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
