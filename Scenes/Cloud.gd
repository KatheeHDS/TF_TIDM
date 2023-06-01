extends Sprite

onready var speed = rand_range(0.1, 0.5)



func _ready():
	pass 

#randomize y height?
func _process(_delta):
	self.position.x += speed
	if self.position.x > get_viewport().size.x+250:
		self.position.x = -250
	
