extends Sprite

onready var speed = rand_range(0.1, 0.5)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#randomize y height?
func _process(delta):
	self.position.x += speed
	if self.position.x > get_viewport().size.x+250:
		self.position.x = -250
	
