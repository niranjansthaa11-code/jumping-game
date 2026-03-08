extends Marker2D

@export var log_scene: PackedScene 
@onready var player = $"../CharacterBody2D"

var spawn_distance = 250.0
var next_spawn_y = 0.0

func _ready():
	if player:
		next_spawn_y = player.global_position.y - spawn_distance

func _process(_delta):
	if player:
		if player.global_position.y < next_spawn_y + 600:
			spawn_log()
			var difficulty_jump = clamp(abs(player.global_position.y) / 5000, 0, 100)
			next_spawn_y -= (spawn_distance + difficulty_jump)
			

func spawn_log():
	var new_log = log_scene.instantiate()
	var random_x = randf_range(-200, 200)
	new_log.global_position = Vector2(random_x, next_spawn_y)
	#creating the random colour 
	var random_color = Color(randf(), randf(), randf(), 1.0)
	
	# i am trying to make the coin with the original colour 
	if new_log.has_node("Sprite2D"):
		new_log.get_node("Sprite2D").self_modulate = random_color
	if randf() < 0.5: 
		new_log.is_fake = true
	
	get_parent().add_child(new_log)
	
