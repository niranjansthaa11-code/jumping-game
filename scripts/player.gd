extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -800
@onready var sprite = $AnimatedSprite2D
@onready var jump_sound = $Jumping
@onready var score_label = $"../CanvasLayer/ScoreLabel"
@onready var High_score_label = $"../CanvasLayer/Label"

var gravity = 1000
var score = 0
var has_played_high_score_sound = false

func _physics_process(delta):
	# Adding gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite.play("jump")

	# Jumping logic
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_sound.play()
		velocity.y = JUMP_VELOCITY

	# Movement logic
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Sprite flipping
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

	if is_on_floor():
		if direction != 0:
			sprite.play("run")
		else:
			sprite.play("idle")

	move_and_slide()
	
	# Score Collision Logic
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.has_method("get_score"):
			if collision.get_normal().dot(Vector2.UP) > 0.5:
				var points_to_add = collider.get_score()
				if points_to_add > 0:
					score += points_to_add
					
					# Only UI feedback here. DO NOT set ScoreManager.high_score yet!
					if score > ScoreManager.high_score:
						High_score_label.text = "HIGH SCORE !!"
						if not has_played_high_score_sound:
							if has_node("%High_score"): %High_score.play()
							has_played_high_score_sound = true 
					
					score_label.text = "Score: " + str(score)

func die(): 
	ScoreManager.update_high_score(score)
	get_tree().change_scene_to_file("res://Scences/exit_menu.tscn")
