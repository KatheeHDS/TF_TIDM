extends Node
#Aquí anirà la generació de plantes
# signal to_inventory

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

onready var inventory_hud = get_parent().get_node("InventoryHUD")

func _ready(): 
	var reader = data_reader.new()
	unlocks = reader.read_unlocks_data() #initialize unlocks table with data from csv .data
	Ecosystem = reader.read_ecosystem_data()
	inventory_hud.initialize(Ecosystem)
	biome = calculate_biome()
	create_plant()
	
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
	var selected_plant = randi() % biome.size() #tria un numero random del 0 al (total de plantes existents)
	nova_planta.set_position(Vector2(rand_range(90,1835), rand_range(422, 1080 - 170))) #TODO SPAWN AREA SIZE
	nova_planta.scale = Vector2(0.5, 0.5)
	habitat[next_id] = nova_planta #afegim la nova planta a la llista de plants
	add_child(nova_planta)
	#TODO CANVIAR ECOSYSTEM A BIOME
	nova_planta.initialize(Ecosystem[biome[selected_plant]], next_id)
	nova_planta.connect("harvested", self, "on_plant_harvested", [next_id])
	next_id += 1
	time_to_next_plant = DELAY


func plant_name_to_plant_code(plant_name):
	var plant_info = Ecosystem[plant_name]
	return plant_info.color + plant_info.type
	
func calculate_biome():
	var new_biome = []

	for plant_name in Ecosystem.keys():
		var plant_code = plant_name_to_plant_code(plant_name)
		var are_requirements_fulfilled = true # ho posem a false si falla algun
		var requirements = unlocks[plant_code]
		for requirement in requirements:
			if statistics.get(requirement.prereq_plant, 0) < requirement.prereq_amt:
				are_requirements_fulfilled = false

		if are_requirements_fulfilled:
			new_biome.append(plant_name)

	print("NEW BIOME ", new_biome)
	print("STATISTICS ", statistics)
	return new_biome

func increase_stats(plant_name, plant_type):
	if statistics.has(plant_type):
		statistics[plant_type] += 1
	else :
		statistics[plant_type] = 1
	inventory_hud.set_count(plant_name, statistics[plant_type])
	print("Number of species " + str(statistics))
	
func on_plant_harvested(id):
	var plant = habitat[id]
	#HERE: Play ani of fruit going UP

	# Increase the stats and compute the new biome with the list of unlocked plants
	increase_stats(plant.name_plant, plant.plant_type)
	biome = calculate_biome()

	print("PLANTA COLLIDA")
	plant.queue_free() # elimina la planta de pantalla
	habitat.erase(id) # elimina la planta del diccionari
	yield(get_tree().create_timer(1), "timeout")
	create_plant()
	# emit_signal("to_inventory", plant.tipus Arguments que diguin el tipus de la planta)

	# gestionar inventari: aquí o en funció dedicada? -> Enviar signal a un altre script. 
	# Caldrà que manager i inventari siguin germans i hi hagi un pare que els gestioni


# TODO
# - crear una variable de classe que sigui una array de textures
# - Omplir aquesta array a la funció initialize amb les 4 textures de la planta
# > load() NO PRELOAD!
# - Posar sprite del player_sprite a la primera textura (L10 plant.gd)
# - en la funcio de creixement, quan detecti que una planta canvia d'stage, canviar sprite
