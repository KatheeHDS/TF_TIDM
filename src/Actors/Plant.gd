extends Actor

signal harvested

export var num_crop = 0 #variable global -> Compta el total de plantes des de l'inici
var num_water = 0 #variable local
var max_hp = 100 
var tex2 = preload("res://Assets/player2.png")
var tex3 = preload("res://Assets/player3.png")
onready var Player_sprite = $PlayerSprite #get_node("PlayerSprite")
var name_plant
var hp

func _ready():
	connect("clicked",self, "on_watered")

func initialize(plant_data, plant_id):
	print(plant_data)
	self.hp = plant_data["hp"] #
	self.name_plant = plant_data["name"] #
	self.num_crop = plant_id #Es una script variable que cal exportar!
	
	
func on_watered():
	num_water += 1 #DEBUG counter
	print(name_plant, " ", num_crop , " regada " , num_water , " vegades. HP ", hp)
	hp += 10 #increase value of hp by 10 points
	if hp <= 0:
		print("Error en ", name_plant, " ", num_crop, "HP NEGATIU") #DEBUG
	elif hp == 80:
		Player_sprite.texture = tex2
	elif hp == max_hp:
		print(name_plant, " ", num_crop, " is fully grown!")
		Player_sprite.texture = tex3
	elif hp > max_hp:
		print(name_plant, " ", num_crop, " harvested!")
		emit_signal("harvested")
