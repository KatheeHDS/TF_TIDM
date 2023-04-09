extends Node
#Aquí anirà la generació de plantes
signal to_inventory

var Planta = preload("res://src/Actors/Plant.tscn")
# Diccionari = {"id" : ["nom planta", HP inicial, "tipus", "color"],...} 
var Ecosystem = {
	0:{name = "Chard", water = 5, sun = 5, type = "Crop", color = "green"}, 
	1:{name = "Tomato", water = 5, sun = 7.5, type = "Crop", color = "red"}, 
	2:{name = "Corn", water = 5, sun = 7.5, type = "Crop", color = "blue"},
	3:{name = "Eggplant", water = 7, sun = 10.5, type = "Crop", color = "purple"},
	4:{name = "Potato", water = 7, sun = 10.5, type = "Crop", color = "yellow"},
	5:{name = "Pumpkin", water = 7, sun = 10.05, type = "Crop", color = "orange"},
	6:{name = "Cabbage", water = 9, sun = 13.5, type = "Crop", color = "teal"},
	7:{name = "Truffle", water = 9, sun = 13.5, type = "Crop", color = "black"},
	8:{name = "Turnip", water = 10, sun = 15, type = "Crop", color = "white"},
	9:{name = "Mum", water = 5, sun = 5, type = "Flower", color = "green"}, 
	10:{name = "Rose", water = 5, sun = 5, type = "Flower", color = "red"}, 
	11:{name = "Forget", water = 5, sun = 5, type = "Flower", color = "blue"},
	12:{name = "Violet", water = 7, sun = 7, type = "Flower", color = "purple"},
	13:{name = "Daffodil", water = 7, sun = 7, type = "Flower", color = "yellow"},
	14:{name = "Hibiscus", water = 7, sun = 7, type = "Flower", color = "orange"},
	15:{name = "Hyacynth", water = 9, sun = 9, type = "Flower", color = "teal"},
	16:{name = "Tulip", water = 9, sun = 9, type = "Tree", color = "black"},
	17:{name = "Daisy", water = 10, sun = 10, type = "Tree", color = "white"},
	18:{name = "Pear", water = 5, sun = 10, type = "Tree", color = "green"}, 
	19:{name = "Cherry", water = 5, sun = 7.5, type = "Tree", color = "red"}, 
	20:{name = "Blueberry", water = 5, sun = 10, type = "Tree", color = "blue"}, #TODO CHANGE COLOR OF SPRITE
	21:{name = "Grape", water = 7, sun = 14, type = "Tree", color = "purple"},
	22:{name = "Lemon", water = 7, sun = 14, type = "Tree", color = "yellow"},
	23:{name = "Mandarine", water = 7, sun = 14, type = "Tree", color = "orange"},
	24:{name = "Figtree", water = 9, sun = 18, type = "Tree", color = "teal"}, #TODO CHANGE COLOR OF SPRITE
	25:{name = "Blackberry", water = 9, sun = 18, type = "Tree", color = "black"},
	26:{name = "Apple", water = 10, sun = 20, type = "Tree", color = "white"},
}
# crear diccionari on s'emmagatzemin les plantes creades
var next_id = 0 #Serveix per al queuefree
var habitat = {} # List of plants currently onscreen
 # TODO DES-Randomitzar quin tipus de planta es crea

var statistics = {} # Compta quantes plantes de cada tipus s'han collit
# crear diccionari
# crear una nova funció que es digui increase stats: rebrà el tipus i color de la planta 
# i modificarà el diccionari d'statistics introduïnt-hi les dades noves
# incrementarà en 1 el valor associat a la clau, però a més la primera cosa que haurà de fer és comprovar si la clau no existeix:
# si no existeix la crearà i li donarà un valor inicial de 1
# mètode HAS de godot, research (if statistics.has cosa, diccionari[tipus]+=1, else diccionari[tipus]=1) 


const DELAY = 5
var time_to_next_plant = DELAY

func _ready(): 
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
	
	
func increase_stats(plant_type):
	if statistics.has(plant_type):
		statistics[plant_type] += 1
		
	else :
		statistics[plant_type] = 1
	print("Number of species " + str(statistics))
	
func on_plant_harvested(id):
	var plant = habitat[id]
	increase_stats(plant.plant_type)
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
