extends Node

func read_unlocks_data():
	var f = File.new()
	var err = f.open("res://db/unlocks.data", File.READ)
	if err != OK:
		print("Failed to open Unlocks File")
		assert(false) # this will stop the game
	var _header = f.get_csv_line(";")
	var line = f.get_csv_line(";")
	var unlocks = {}
	
	while not f.eof_reached() :
		var plant_name = line[0]
		var plant_unlocks = []
		if line[1] != "":
			plant_unlocks.append({"prereq_plant": line[1], "prereq_amt": int(line[2])})
		if line[3] != "":
			plant_unlocks.append({"prereq_plant": line[3], "prereq_amt": int(line[4])})
		if line[5] != "":
			plant_unlocks.append({"prereq_plant": line[5], "prereq_amt": int(line[6])})
		unlocks[plant_name] = plant_unlocks
		line =  f.get_csv_line(";")
	return unlocks


func read_ecosystem_data():
	var f = File.new()
	var err = f.open("res://db/growth.data", File.READ)
	if err != OK:
		print("Failed to open Unlocks File")
		assert(false) # this will stop the game
	var _header = f.get_csv_line(";")
	var line = f.get_csv_line(";")
	var Ecosystem = {}
	#clau: nom planta: valor {nested diccionari}
	
	while not f.eof_reached() :
		var plant_info = {
			"name" : line[0],
			"water" : float(line[1]),
			"sun" : float(line[2]),
			"type" : line[3],
			"color": line[4],
			"collision_sizes" : [
				Vector2(float(line[5]), float(line[6])),
				Vector2(float(line[7]), float(line[8])),
				Vector2(float(line[9]), float(line[10])),
				Vector2(float(line[11]), float(line[12]))
			]
		}
		
		Ecosystem[plant_info.name] = plant_info
		line =  f.get_csv_line(";")
		
		
	return Ecosystem
	
