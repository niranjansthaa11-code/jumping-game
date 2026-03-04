extends Node2D

# Export variables so you can edit them in the Inspector
@export var speed = 100.0
@export var acceleration = 2.0
@export var max_speed = 300

@onready var player = get_node("../CharacterBody2D")
@onready var dead_music =$Main_one/AudioStreamPlayer2

func _process(delta: float) -> void:
	if not player: return

	# 1. Calculate how far the player is
	var distance = position.y - player.global_position.y
	
	# 2. TARGET SPEED: If the player is far, go fast. If close, go slow.
	# This "Target" will be our max speed limit.
	var target_speed = 350.0 
	
	if distance > 900:
		# Catch up quickly if the player is pro
		speed = move_toward(speed, 500.0, acceleration * 5 * delta)
	elif distance < 400:
		# Slow down to a "crawl" if the player is about to die
		speed = move_toward(speed, 150.0, acceleration * 10 * delta)
	else:
		# Normal cruising speed
		speed = move_toward(speed, target_speed, acceleration * delta)

	# 3. Apply the movement
	position.y -= speed * delta
	


func _on_main_one_body_entered(body: Node2D) -> void:
	dead_music.play()
	if body.is_in_group("player") or body.name == "CharacterBody2D":
		print("Player consumed by the void!")		
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
	pass # Replace with function body.
