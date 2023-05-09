extends Node2D

var sprites = [
	preload("res://Assets/GUI/Clock_0.png"),
	preload("res://Assets/GUI/Clock_1.png"),
	preload("res://Assets/GUI/Clock_2.png"),
	preload("res://Assets/GUI/Clock_3.png"),
	preload("res://Assets/GUI/Clock_4.png"),
]

func set_amount(fraction):
	# var amount
	if fraction < 0.25:
		#amount = 0
		$ClockSprite.texture = sprites[0]
	elif fraction < 0.50:
		$ClockSprite.texture = sprites[1]
	elif fraction < 0.75:
		$ClockSprite.texture = sprites[2]
	elif fraction < 1:
		$ClockSprite.texture = sprites[3]
	elif fraction < 1.25:
		$ClockSprite.texture = sprites[4]
	else:
		$ClockSprite.texture = null
	#$ClockSprite.texture = sprites[amount]
	
	


