extends Actor

export var num_crop = 0 #variable global
export var type_crop = "P" # P = Vegetable, A = Tree, F = Flower
var num_water = 0 #variable local
var max_hp = 100 
var hp = 70 #hp inicial
var tex2 = preload("res://Assets/player2.png")
var tex3 = preload("res://Assets/player3.png")
onready var Player_sprite = $PlayerSprite #get_node("PlayerSprite")


func _ready():
	connect("clicked",self, "on_watered")
	
func on_watered():
	num_water += 1 #DEBUG counter
	print(type_crop, " ", num_crop , " regada " , num_water , " vegades")
	hp += 10 #increase value of hp by 10 points
	if hp <= 0:
		print("Error en ", type_crop, " ", num_crop, "HP NEGATIU") #DEBUG
	elif hp == 80:
		Player_sprite.texture = tex2
	elif hp == max_hp:
		print(type_crop, " ", num_crop, " is fully grown!")
		Player_sprite.texture = tex3
	elif hp > max_hp:
		print(type_crop, " ", num_crop, " harvested!")
		queue_free() #Elimina la planta
