extends Node
#Aquí anirà la generació de plantes
signal to_inventory

var Planta = preload("res://src/Actors/Plant.tscn")
# Diccionari = {"id" : ["nom planta", HP inicial, "tipus", "color"],...} 
var data_reader = preload("res://src/data_reader.gd")


# crear diccionari on s'emmagatzemin les plantes creades
var next_id = 0 #Serveix per al queuefree
var habitat = {} # List of plants currently onscreen
 # WIP DES-Randomitzar quin tipus de planta es crea
var biome = {}
var statistics = {} # Compta quantes plantes de cada tipus s'han collit

var unlocks # stores prerequisites to unlock plants
var Ecosystem

const DELAY = 5
var time_to_next_plant = DELAY

func _ready(): 
	var reader = data_reader.new()
	unlocks = reader.read_unlocks_data() #initialize unlocks table with data from csv .data
	Ecosystem = reader.read_ecosystem_data()
	create_plant()
	biome = {}
	
	
func _process(delta):
	time_to_next_plant -= delta # TODO comptar temps
	if time_to_next_plant <= 0 :
		create_plant()
	# print("temps passat ", time_to_next_plant)
	if Input.is_action_just_pressed("debug_plant"):
		create_plant()
	
func create_plant():
	var nova_planta = Planta.instance() # Afegeix una nova planta a la llista de plantes existents
	# TODO CANVIAR ECOSYSTEM A BIOME
	var selected_plant = randi() % Ecosystem.size() #tria un numero random del 0 al (total de plantes existents)
	nova_planta.set_position(Vector2(rand_range(0,960), rand_range(150, 500))) #TODO SPAWN AREA SIZE
	nova_planta.scale = Vector2(0.5, 0.5)
	habitat[next_id] = nova_planta #afegim la nova planta a la llista de plants
	add_child(nova_planta)
	#TODO CANVIAR ECOSYSTEM A BIOME
	nova_planta.initialize(Ecosystem.values()[selected_plant], next_id)
	nova_planta.connect("harvested", self, "on_plant_harvested", [next_id])
	next_id += 1
	time_to_next_plant = DELAY
	
func calculate_biome():
	if 1 : # utilitzant unlocks i statistics calcular quines plantes compleixen els requisits
		#TODO: crear BUCLE que recorri tots els requisits de la taula unlocks 
		# per recorrer un diccionari fer un bucle que iteri sobre les keys (funció godot -> mètode diccionari.keys)
		# per accedir a les values fem servir claudators diccionari[key]
		# el value serà una llista de reqs. Comprovar si cada element es compleix.
		#if tots requisits then append la clau nom_planta a la llista biome (biome.append)
		
		#TODO: funcio creixement
		# implementar una funcio que donada una planta i un estadi de creixement calculi 
		# quants clicks ha de rebre la planta i quants segons de sol ha de rebre en aquell estadi
		# valor de sol total * fracció corresponent i arrodonir cap amunt.
		
		print("placeholder")

func increase_stats(plant_type):
	if statistics.has(plant_type):
		statistics[plant_type] += 1
		
	else :
		statistics[plant_type] = 1
	print("Number of species " + str(statistics))
	
func on_plant_harvested(id):
	var plant = habitat[id]
	increase_stats(plant.plant_type)
	print("PLANTA COLLIDA")
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
