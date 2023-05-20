extends Control

var CropCounterWidget = preload("res://Scenes/UI/CropCounterWidget.tscn");

var plant_name_to_crop_counter = {}

func initialize(Ecosystem):
	var plant_names = Ecosystem.keys()
	plant_names.sort()
	for plant_name in plant_names:
		var crop_counter = CropCounterWidget.instance()
		crop_counter.initialize(plant_name);
		$TextureRect/MarginContainer/CounterList.add_child(crop_counter)
		plant_name_to_crop_counter[plant_name] = crop_counter

func set_count(plant_name, count):
	var counter = plant_name_to_crop_counter[plant_name]
	counter.set_count(count)
