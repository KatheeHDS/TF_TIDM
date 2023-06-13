extends Sprite

# Cloud sprite animation manager

onready var speed = rand_range(0.1, 0.5)

# Sets the position for each cloud and animates it
func _process(_delta):
	self.position.x += speed
	if self.position.x > get_viewport().size.x+250:
		self.position.x = -250
	
