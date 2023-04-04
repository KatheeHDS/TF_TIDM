extends Actor

signal harvested

export var num_crop = 0 #variable global -> Compta el total de plantes des de l'inici
var num_water = 0 #variable local
var max_hp = 100 
var textures = []
onready var Plant_sprite = $PlantSprite #get_node("PlantSprite")
var name_plant
var water # nombre de clicks
var sun # delta de temps per passar d'stage

func _ready():
	connect("clicked",self, "on_watered")

func initialize(plant_data, plant_id):
	print(plant_data)
	self.hp = plant_data["hp"] #
	self.name_plant = plant_data["name"] #
	self.num_crop = plant_id #Es una script variable que cal exportar!
	tex1 = load("res://Assets/Plants/" + name_plant + "_1.png")
	tex2 = load("res://Assets/Plants/" + name_plant + "_2.png")
	tex3 = load("res://Assets/Plants/" + name_plant + "_3.png")
	tex4 = load("res://Assets/Plants/" + name_plant + "_4.png")
	
func on_watered():
	num_water += 1 #DEBUG counter
	print(name_plant, " ", num_crop , " regada " , num_water , " vegades. HP ", hp)
	hp += 10 #increase value of hp by 10 points
	if hp <= 0:
		print("Error en ", name_plant, " ", num_crop, "HP NEGATIU") #DEBUG
	elif hp <= 50:
		Plant_sprite.texture = tex1
	elif hp <= 60:
		Plant_sprite.texture = tex2
	elif hp <= 80:
		Plant_sprite.texture = tex3
	elif hp == max_hp:
		print(name_plant, " ", num_crop, " is fully grown!")
		Plant_sprite.texture = tex4
	elif hp > max_hp:
		print(name_plant, " ", num_crop, " harvested!")
		emit_signal("harvested")
