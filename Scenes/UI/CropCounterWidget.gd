extends VBoxContainer

# HUD inventory counter; Used in InventoryHUD.gd

var plant_name
var count

func initialize(plant_species):
	self.plant_name = plant_species
	self.count = 0
	update_ui()

func set_count(new_count):
	self.count = new_count
	update_ui()

func update_ui():
	if self.count == 0:
		$Label.text = "-"
		$TextureRect.texture = load("res://Assets/Plants/SPRITE_SECRET.png")
	else:
		$Label.text = str(self.count)
		$TextureRect.texture = load("res://Assets/Plants/SPRITE_"+self.plant_name+".png")
