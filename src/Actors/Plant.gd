extends Actor

signal harvested

export var num_crop = 0 #variable global -> Compta el total de plantes des de l'inici
var num_water = 0 #variable local
var sprites = []
onready var Plant_sprite = $PlantSprite #get_node("PlantSprite")
var name_plant
var max_water # nombre de clicks
var max_sun # temps mínim de creixement de la planta
var sunlight = 0 # delta de temps transcorregut (quantitat de sol rebut per la planta)
var plant_type # variable que desarà el tipus de planta (greenTree)
var growth_stage = 1 # TODO DOCUMENTACIO

func _ready():
	connect("clicked", self, "on_watered") #connects signal clicked to on_watered function in this script (self)
	
func initialize(plant_data, plant_id):
	print(plant_data)
	self.max_water = plant_data["water"] # nombre de clicks per a creixement total
	self.max_sun = plant_data["sun"] # nombre de segons per a creixement total
	self.name_plant = plant_data["name"] #
	self.plant_type = plant_data["color"] + plant_data["type"]
	self.num_crop = plant_id #Es una script variable que cal exportar!
	sprites.append(load("res://Assets/Plants/" + name_plant + "_1.png"))
	sprites.append(load("res://Assets/Plants/" + name_plant + "_2.png"))
	sprites.append(load("res://Assets/Plants/" + name_plant + "_3.png"))
	sprites.append(load("res://Assets/Plants/" + name_plant + "_4.png"))
	Plant_sprite.texture = sprites[0]
	
func get_max_water_amount_for_growth_stage(growth_stage):
	if growth_stage <= 3:
		return ceil(self.max_water * 0.3333)
	else: 
		return 1
	
func get_max_sun_amount_for_growth_stage(growth_stage):
	if growth_stage <= 3:
		return ceil(self.max_sun * 0.3333)
	else:
		return 1
		

func on_watered():
	var max_stage_water = get_max_water_amount_for_growth_stage(self.growth_stage)
	if num_water < max_stage_water:
		num_water += 1
		print("watered ", num_water)
	else:
		print("no accepta més aigua")
		
func _process(delta):
	sunlight += delta # TODO comptar temps
	## print("sunlight ", sunlight)
	var max_stage_sun = get_max_sun_amount_for_growth_stage(self.growth_stage)
	var max_stage_water = get_max_water_amount_for_growth_stage(self.growth_stage)
	if sunlight >= max_stage_sun && num_water >= max_stage_water:
		if growth_stage < 4:
			increase_growth_stage()
		else:
			emit_signal("harvested")

func increase_growth_stage():
	self.growth_stage += 1
	Plant_sprite.texture = sprites[self.growth_stage-1]
	num_water = 0
