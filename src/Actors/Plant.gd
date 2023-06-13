extends Actor

# Class Plant, inherits from class Actor. Manages each individual plant onscreen.
# Tasks: Create, Scale, Grow and Harvest plants; Animations; Cursor sprite feedback.
# Sends data to InventoryHUD.gd, PlantManager.gd and requires CursorManager.gd
# Keeping inline development comments in place as guide for future continued development

class_name Plant


signal harvested

export var num_crop = 0 #variable global -> Compta el total de plantes des de l'inici
var num_water = 0 #variable local
var sprites = []
onready var Plant_sprite = $PlantSprite #get_node("PlantSprite")
onready var Collision_shape = $CollisionShape2D 
const SCALING_MIN = 0.688
const SCALING_MAX = 1.5
const SKY = 422

var name_plant
var max_water # nombre de clicks
var max_sun # temps mínim de creixement de la planta
var collision_sizes
var scaling

var sunlight = 0 # delta de temps transcorregut (quantitat de sol rebut per la planta)
var plant_type # variable que desarà el tipus de planta (greenTree)
var growth_stage = 1 

var hovering = false

var is_harvested = false



func _ready():
	assert(connect("mouse_entered", self, "on_mouse_enter") == OK) #connects signal mouse_entered to on_mouse_enter function in this script (self)
	assert(connect("mouse_exited", self, "on_mouse_exit") == OK)
	SoundManager.sfx("sprout")
	
func initialize(plant_data, plant_id):
	print(plant_data)
	
	self.max_water = plant_data["water"] # nombre de clicks per a creixement total
	self.max_sun = plant_data["sun"] # nombre de segons per a creixement total
	self.name_plant = plant_data["name"] #
	self.plant_type = plant_data["color"] + plant_data["type"]
	self.num_crop = plant_id #Es una script variable que cal exportar!
	self.collision_sizes = plant_data["collision_sizes"]
	self.z_index = int(self.position.y)
	perspective()	
	sprites.append(load("res://Assets/Plants/" + name_plant + "_1.png"))
	sprites.append(load("res://Assets/Plants/" + name_plant + "_2.png"))
	sprites.append(load("res://Assets/Plants/" + name_plant + "_3.png"))
	sprites.append(load("res://Assets/Plants/" + name_plant + "_4.png"))
	set_sprite(sprites[0], collision_sizes[0])

func perspective():
	var y_global = self.position.y #422
	var factor = (y_global - SKY) / (get_viewport().size.y - SKY)
	scaling = lerp(SCALING_MIN, SCALING_MAX, factor)
	
	
func get_required_water_amount_for_growth_stage(stage):
	if stage <= 3:
		return ceil(self.max_water * 0.3333)
	else: 
		return 1
	
func get_required_sun_amount_for_growth_stage(stage):
	var sun_amount = 0
	if stage == 4:
		return 0
	else:
		for _i in range(0, stage):
			sun_amount += self.max_sun * 0.3333
		return sun_amount


func on_watered():
	var max_stage_water = get_required_water_amount_for_growth_stage(self.growth_stage)
	if num_water < max_stage_water:
		$WaterParticles.emitting = true
		num_water += 1
		SoundManager.sfx("water")
	else:
		SoundManager.sfx("dry")
		
		
func _process(delta):
	if is_harvested:
		return

	sunlight += delta 
	var required_stage_sun = get_required_sun_amount_for_growth_stage(self.growth_stage)
	var required_stage_water = get_required_water_amount_for_growth_stage(self.growth_stage)

	
	# Cursor sprites: VISUAL FEEDBACK
	
	if hovering:
		if growth_stage < 4 and num_water < required_stage_water:
			CursorManager.set_cursor("water")
		elif growth_stage == 4:
			CursorManager.set_cursor("pick")
		else:
			CursorManager.set_cursor("default")
		
	
	if sunlight >= required_stage_sun && num_water >= required_stage_water:
		if growth_stage < 4:
			increase_growth_stage()
			# PLAY SOUND GROW
			SoundManager.sfx("grow")
		else:
			harvest()
			CursorManager.set_cursor("default")
			# PLAY SOUND PICKUP
			SoundManager.sfx("pickup")

func harvest():
	is_harvested = true
	$CollisionShape2D.disabled = true # prevents spam clicks from affecting this plant

	var animation_duration = 0.5
	var animation_transition = Tween.TRANS_CUBIC
	var animation_easing = Tween.EASE_OUT

	$Tween.interpolate_property( # sprite moves downward
		self, 
		"position", 
		self.position, # valor inicial
		self.position - Vector2(0, -100), # valor final
		animation_duration,
		animation_transition,
		animation_easing
	)
	$Tween.interpolate_property( # sprite becomes transparent (alpha channel 1 to 0)
		self, 
		"modulate",
		self.modulate,
		Color(1, 1, 1, 0),
		animation_duration,
		animation_transition,
		animation_easing
	)
	$Tween.interpolate_property( # sprite becomes smaller
		self,
		"scale",
		self.scale,
		self.scale * 0.5,
		animation_duration,
		animation_transition,
		animation_easing
	)
	$Tween.start()
	
	yield(get_tree().create_timer(animation_duration - 0.2), "timeout") # wait for animation to end
	emit_signal("harvested")
	yield(get_tree().create_timer(0.2), "timeout")
	queue_free()


func increase_growth_stage():
	self.growth_stage += 1
	set_sprite(sprites[self.growth_stage - 1], collision_sizes[self.growth_stage - 1])
	num_water = 0

func decrease_growth_stage():
	self.growth_stage -= 1
	set_sprite(sprites[self.growth_stage - 1], collision_sizes[self.growth_stage - 1])
	num_water = 0

func set_sprite(texture, collision_size):
	Plant_sprite.texture = texture
	Plant_sprite.centered = true
	Plant_sprite.offset.x = 0
	Plant_sprite.offset.y = -texture.get_height() / 2
	Plant_sprite.scale = Vector2(scaling, scaling)
	
	Collision_shape.shape = Collision_shape.shape.duplicate()
	Collision_shape.shape.extents = collision_size * 0.5 * scaling
	Collision_shape.position.x = 0
	Collision_shape.position.y = -collision_size.y * 0.5 * scaling

	$WaterParticles.position.y = -collision_size.y * scaling
	
func on_mouse_enter():
	hovering = true
	
	
func on_mouse_exit():
	hovering = false
	CursorManager.set_cursor("default")
	
