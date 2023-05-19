extends TextureButton

func _ready():
	#self.z_index = 2000
	#assert(get_node("InventoryButton").connect("pressed", self, "open_inventory") == OK)
	pass 
func open_inventory():
	SoundManager.sfx("click")
	# emit_signal("back")
	print("opening inventory!")
