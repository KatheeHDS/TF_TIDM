extends Node2D

# Mouse manager: returns which plant is the closest, Z-index wise, to the mouse

func get_plant_under_cursor():
	var state = get_world_2d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	var results = state.intersect_point(mouse_position)

	if results.size() > 0:
		# if the mouse is hovering over an actor, determines which actor is the "closest" to the player
		var closest_plant = null
		var closest_plant_z_index = 0
		for result in results:
			if result.collider.is_in_group("Plant"):
				var plant = result.collider
				if plant.z_index > closest_plant_z_index:
					closest_plant_z_index = plant.z_index
					closest_plant = plant
		
		if closest_plant != null:
			return closest_plant
		else:
			return null
	else:
		return null
