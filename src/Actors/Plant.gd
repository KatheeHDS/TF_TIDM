extends Actor

signal harvested

export var num_crop = 0 #variable global -> Compta el total de plantes des de l'inici
var num_water = 0 #variable local
var sprites = []
onready var Plant_sprite = $PlantSprite #get_node("PlantSprite")
var name_plant
var water # nombre de clicks
var sun # temps mínim de creixement de la planta
var sunlight = 0 # delta de temps transcorregut (quantitat de sol rebut per la planta)
var plant_type # variable que desarà el tipus de planta (greenTree)

func _ready():
	connect("clicked",self, "on_watered") # DOUBT - What was this for?
	
func _process(delta):
	sunlight += delta # TODO comptar temps

func initialize(plant_data, plant_id):
	print(plant_data)
	self.water = plant_data["water"] # nombre de clicks per a creixement total
	self.sun = plant_data["sun"] # nombre de segons per a creixement total
	self.name_plant = plant_data["name"] #
	self.plant_type = plant_data["color"] + plant_data["type"]
	self.num_crop = plant_id #Es una script variable que cal exportar!
	sprites.append(load("res://Assets/Plants/" + name_plant + "_1.png"))
	sprites.append(load("res://Assets/Plants/" + name_plant + "_2.png"))
	sprites.append(load("res://Assets/Plants/" + name_plant + "_3.png"))
	sprites.append(load("res://Assets/Plants/" + name_plant + "_4.png"))
	Plant_sprite.texture = sprites[0]
	
func on_watered():
	num_water += 1 #DEBUG counter
	print(name_plant, " ", num_crop , " regada " , num_water , " vegades.")
	#water += 10 #increase value of water by 10 points
	var percent = float(num_water)/float(water)*100
	if percent < 0:
		print("Error en ", name_plant, " ", num_crop, "HP NEGATIU") #DEBUG
	elif percent > 100 && sunlight >= sun:
		print(name_plant, " ", num_crop, " harvested!")
		emit_signal("harvested")
	elif percent >= 80 && sunlight >= sun:
		print(name_plant, " ", num_crop, " is fully grown!")
		Plant_sprite.texture = sprites[3]
	elif percent >= 50:
		Plant_sprite.texture = sprites[2]
	elif percent >= 25:
		Plant_sprite.texture = sprites[1]




