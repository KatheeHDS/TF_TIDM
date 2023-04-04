extends Node
#Aquí anirà la generació de plantes
signal to_inventory

var Planta = preload("res://src/Actors/Plant.tscn")
# Diccionari = {"id" : ["nom planta", HP inicial, "tipus", "color"],...} 
var Ecosystem = {
	0:{name = "Chard", water = 5, sun = 5, type = "crop", color = "green"}, 
	1:{name = "Tomato", water = 5, sun = 7.5, type = "crop", color = "red"}, 
	2:{name = "Corn", water = 5, sun = 7.5, type = "crop", color = "blue"},
	3:{name = "Eggplant", water = 7, sun = 10.5, type = "crop", color = "purple"},
	4:{name = "Potato", water = 7, sun = 10.5, type = "crop", color = "yellow"},
	5:{name = "Pumpkin", water = 7, sun = 10.05, type = "crop", color = "orange"},
	6:{name = "Cabbage", water = 9, sun = 13.5, type = "crop", color = "turquoise"},
	7:{name = "Truffle", water = 9, sun = 13.5, type = "crop", color = "black"},
	8:{name = "Turnip", water = 10, sun = 15, type = "crop", color = "white"},
	9:{name = "Mum", water = 5, sun = 5, type = "flower", color = "green"}, 
	10:{name = "Rose", water = 5, sun = 5, type = "flower", color = "red"}, 
	11:{name = "Forget", water = 5, sun = 5, type = "flower", color = "blue"},
	12:{name = "Violet", water = 7, sun = 7, type = "flower", color = "purple"},
	13:{name = "Daffodil", water = 7, sun = 7, type = "flower", color = "yellow"},
	14:{name = "Hibiscus", water = 7, sun = 7, type = "flower", color = "orange"},
	15:{name = "Hyacynth", water = 9, sun = 9, type = "flower", color = "turquoise"},
	16:{name = "Tulip", water = 9, sun = 9, type = "tree", color = "black"},
	17:{name = "Daisy", water = 10, sun = 10, type = "tree", color = "white"},
	18:{name = "Pear", water = 5, sun = 10, type = "tree", color = "green"}, 
	19:{name = "Cherry", water = 5, sun = 7.5, type = "tree", color = "red"}, 
	20:{name = "Blueberry", water = 5, sun = 10, type = "tree", color = "blue"}, #TODO CHANGE COLOR OF SPRITE
	21:{name = "Grape", water = 7, sun = 14, type = "tree", color = "purple"},
	22:{name = "Lemon", water = 7, sun = 14, type = "tree", color = "yellow"},
	23:{name = "Mandarine", water = 7, sun = 14, type = "tree", color = "orange"},
	24:{name = "Figtree", water = 9, sun = 18, type = "tree", color = "turquoise"}, #TODO CHANGE COLOR OF SPRITE
	25:{name = "Blackberry", water = 9, sun = 18, type = "tree", color = "black"},
	26:{name = "Apple", water = 10, sun = 20, type = "tree", color = "white"},
}
# crear diccionari on s'emmagatzemin les plantes creades
var next_id = 0
var habitat = {} # List of plants currently onscreen
 # TODO randomitzar quin tipus de planta es crea

const DELAY = 5
var time_to_next_plant = DELAY

func _ready(): #TODO ara mateix aquesta func només s'executa UNA VEGADA. Canviar pq s'executi quan llegeix la senyal harvest
	create_plant()
	
	
func _process(delta):
	time_to_next_plant -= delta # TODO comptar temps
	if time_to_next_plant <= 0 :
		create_plant()
	# print("temps passat ", time_to_next_plant)
	if Input.is_action_just_pressed("debug_plant"):
		create_plant()
	# receive plant id to add it to the habitat.
# TODO Crear diferents tipus de plantes des del plant manager	
	
func create_plant():
	var nova_planta = Planta.instance() # Afegeix una nova planta a la llista de plantes existents
	var selected_plant = randi() % Ecosystem.size() #tria un numero random del 0 al (total de plantes existents)
	nova_planta.set_position(Vector2(rand_range(0,920), rand_range(150, 500))) #TODO SPAWN AREA SIZE
	nova_planta.scale = Vector2(0.5, 0.5)
	habitat[next_id] = nova_planta #afegim la nova planta a la llista de plants
	add_child(nova_planta)
	nova_planta.initialize(Ecosystem[selected_plant], next_id)
	nova_planta.connect("harvested", self, "on_plant_harvested", [next_id])
	next_id += 1
	time_to_next_plant = DELAY
	
	
func on_plant_harvested(id):
	var plant = habitat[id]
	print("S'ESTA CRIDANT")
	create_plant()
	# emit_signal("to_inventory", plant.tipus Arguments que diguin el tipus de la planta)
	plant.queue_free() # elimina la planta de pantalla
	habitat.erase(id) # elimina la planta del diccionari
	# gestionar inventari: aquí o en funció dedicada? -> Enviar signal a un altre script. 
	# Caldrà que manager i inventari siguin germans i hi hagi un pare que els gestioni


# TODO
# - crear una variable de classe que sigui una array de textures
# - Omplir aquesta array a la funció initialize amb les 4 textures de la planta
# > load() NO PRELOAD!
# - Posar sprite del player_sprite a la primera textura (L10 plant.gd)
# - en la funcio de creixement, quan detecti que una planta canvia d'stage, canviar sprite
