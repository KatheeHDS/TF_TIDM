extends Node

# Manages game progression. Combines ecosystem data with unlocks data and player actions.
# Requires data_reader.gd and plant.gd

signal win_state

var Planta = preload("res://src/Actors/Plant.tscn") 
var data_reader = preload("res://src/data_reader.gd")

var next_id = 0 
var habitat = {} 
var biome = {}
var statistics = {} 

var unlocks 
var Ecosystem

const DELAY = 5
var time_to_next_plant = DELAY

var seed_in_hand = null

onready var inventory_hud = get_parent().get_node("InventoryHUD")
var collision_manager

var play_area = Rect2(Vector2(90, 422), Vector2(1745, 488))

var is_victory_achieved = false


func _ready(): 
	collision_manager = preload("res://Scenes/CollisionManager.tscn").instance()
	add_child(collision_manager)

	var reader = data_reader.new()
	unlocks = reader.read_unlocks_data() #initialize unlocks table with data from csv .data
	Ecosystem = reader.read_ecosystem_data()
	inventory_hud.initialize(Ecosystem)
	biome = calculate_biome()
	spawn_plant()
	
func _process(delta):
	time_to_next_plant -= delta 
	if time_to_next_plant <= 0 :
		spawn_plant()
		
	if statistics.size() == Ecosystem.size() and not is_victory_achieved:
		emit_signal("win_state")
		is_victory_achieved = true
		
	if Input.is_action_just_pressed("debug_plant"):
		spawn_plant()
		
	if Input.is_action_just_pressed("debug_victory"):
		emit_signal("win_state")
		is_victory_achieved = true
		print("You cheated! But life won't be contained [Endgame Mode Enabled]")
		
	if Input.is_action_just_pressed("debug_reap") && is_victory_achieved:
		var plant_under_cursor = collision_manager.get_plant_under_cursor()
		if plant_under_cursor != null:
			plant_under_cursor.queue_free()
			SoundManager.sfx("dry")
		
	if Input.is_action_just_pressed("main_click"):
		var plant_under_cursor = collision_manager.get_plant_under_cursor()
		var mouse_position = get_viewport().get_mouse_position()
		if seed_in_hand:
			if play_area.has_point(mouse_position) && plant_under_cursor == null:
				create_plant(seed_in_hand, mouse_position)
				seed_in_hand = null
				CursorManager.clear_cursor_override()
			else:
				SoundManager.sfx("error")
		else:
			if plant_under_cursor != null:
				plant_under_cursor.on_watered()
	if Input.is_action_just_pressed("secondary_click"):
		var plant_under_cursor = collision_manager.get_plant_under_cursor()
		if not seed_in_hand && plant_under_cursor != null && plant_under_cursor.growth_stage == 4:
			seed_in_hand = plant_under_cursor.name_plant
			plant_under_cursor.decrease_growth_stage()
			CursorManager.set_cursor_override("seeds")

func spawn_plant():
	var random_position = Vector2(rand_range(90,1835), rand_range(422, 1080 - 170)) 
	var selected_plant = randi() % biome.size() 
	var selected_plant_name = biome[selected_plant]
	create_plant(selected_plant_name, random_position)

func create_plant(plant_to_spawn, position):
	var nova_planta = Planta.instance() 
	nova_planta.set_position(position) 
	nova_planta.scale = Vector2(0.5, 0.5)
	habitat[next_id] = nova_planta 
	add_child(nova_planta)
	nova_planta.initialize(Ecosystem[plant_to_spawn], next_id)
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
		var are_requirements_fulfilled = true 
		var requirements = unlocks[plant_code]
		for requirement in requirements:
			if statistics.get(requirement.prereq_plant, 0) < requirement.prereq_amt:
				are_requirements_fulfilled = false
		if are_requirements_fulfilled:
			new_biome.append(plant_name)
	return new_biome

func increase_stats(plant_name, plant_type):
	if statistics.has(plant_type):
		statistics[plant_type] += 1
	else :
		statistics[plant_type] = 1
	inventory_hud.set_count(plant_name, statistics[plant_type])
	
func on_plant_harvested(id):
	var plant = habitat[id]
	increase_stats(plant.name_plant, plant.plant_type)
	biome = calculate_biome()
	habitat.erase(id) 
