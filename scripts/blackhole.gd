extends Node2D

# Export variables so you can edit them in the Inspector
@export var speed = 100.0
@export var acceleration = 2.0
@export var max_speed = 300

@onready var player = get_node("../CharacterBody2D")
@onready var dead_music =$Main_one/AudioStreamPlayer2
@onready var main_music =%Music_manager
@onready var anim_play = $"../CharacterBody2D/AnimatedSprite2D"

func _process(delta: float) -> void:
	if not player: return

	# 1. Calculate how far the player is
	var distance = position.y - player.global_position.y
	

	var target_speed = 350.0 
	
	if distance > 900:
		# Catch up quickly if the player is pro
		speed = move_toward(speed, 350.0, acceleration * 2 * delta)
	elif distance < 400:
		# Slow down to a "crawl" if the player is about to die
		speed = move_toward(speed, 100.0, acceleration * 10 * delta)
	else:
		# Normal cruising speed
		speed = move_toward(speed, target_speed, acceleration * delta)

	# 3. Apply the movement
	position.y -= speed * delta
	


func _on_main_one_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "CharacterBody2D":
		print("Player consumed by the void!")
		body.set_physics_process(false) #for stopping the overlapping of the animations
		main_music.stop()
		dead_music.play()
		# 3. Play the animation
		anim_play.play("dead")
		#Making the player sink
		var tween = create_tween()
		tween.tween_property(body, "scale", Vector2.ZERO, 0.8)
		tween.parallel().tween_property(body, "modulate:a", 0.0, 0.8) 
		#waitting time 
		await get_tree().create_timer(1.2).timeout
		get_tree().reload_current_scene()
