extends Node2D
# var Song1 = preload("res://Assets/Sounds/Morning Mood – Grieg (No Copyright Music).mp3")
# var Song2 = preload("res://Assets/Sounds/((NFM))-🎶((CLASSICAL))-🎵Requiem - Dies Irae-🎧Wolfgang Amadeus Mozart-💿((COPYRIGHT FREE MUSIC))🔊.mp3")
# var Song3 = preload("res://Assets/Sounds/Kevin MacLeod - Windswept.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	# music peer gynt morning
	$Track1.playing = true
	print("SONG PLAYING")
	# 10 segons tops
	yield(get_tree().create_timer(2.0), "timeout")
	progreso()
	yield(get_tree().create_timer(2.0), "timeout")
	rebirth()
	



func scaling(): 
	# l'attacharem al container de tots els sprites pq s'escalin correctament
	pass
	
func progreso(): 
	$Track2.playing = true
	$Track1.playing = false
	# animació de camions + núvols de pols
	# fa canviar el fons
	# canvia la música a summer 3rd mov
	pass

func houses():
	# houses pop from the floor up like shrooms
	# popping noises
	pass
	
func declive():
	# animació emportar-se les cases
	# deixa el background a default
	# pop 1 planta ^ 
	pass
	
func rebirth():
	#changes track for BGM
	$Track3.playing = true
	$Track2.playing = false
	# IntroSoundtrack.stream("res://Assets/Sounds/Morning Mood – Grieg (No Copyright Music).mp3")
	print("hola")
	pass
