extends Node2D

func _ready():
	print("SFX controller ready")

func sfx(id):
	if id == "water":
		$SoundWater.playing = true
	elif id == "pickup": 
		$SoundPickup.playing = true
	elif id == "dry":
		$SoundDry.playing = true
	elif id == "sprout":
		$SoundSprout.playing = true
	elif id == "grow":
		$SoundGrow.playing = true
	elif id == "click":
		$SoundClicked.playing = true
	elif id == "error":
		$SoundError.playing = true
	
