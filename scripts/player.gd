extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -800
@onready var sprite = $AnimatedSprite2D
@onready var jump_sound =$Jumping
#getting the gravity
var gravity = 1000
var score = 0
@onready var score_label = $"../CanvasLayer/ScoreLabel"
@onready var High_score_label = $"../CanvasLayer/Label"
var has_played_high_score_sound = false



func _physics_process(delta):
	# adding gravity for the sprite
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite.play("jump")

	# Making the thing jump 
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_sound.play()
		velocity.y = JUMP_VELOCITY

	# this gets the direction as input as the -1,0,1 resp..
	var direction = Input.get_axis("Left", "Right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		# Smoothly stop the character (Friction)
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#flipping the velcoity
	if direction>0:
		sprite.flip_h = false
	if direction<0:
		sprite.flip_h = true
	if is_on_floor():
		if direction != 0:
			sprite.play("run")
		else :
			sprite.play("idle")
	# 4. Final step: Apply the movement
	move_and_slide()
	
	# Check for collisions AFTER moving
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.has_method("get_score"):
			if collision.get_normal().dot(Vector2.UP) > 0.5:
				var points_to_add = collider.get_score()
				if points_to_add > 0:
					score += points_to_add
					if score > ScoreManager.high_score:
						High_score_label.text = "HIGH SCORE !!"
						if not has_played_high_score_sound:
							%High_score.play()
							has_played_high_score_sound = true 
				# Update the high score record
					ScoreManager.high_score = score
					ScoreManager.total_score = score
					
					score_label.text = "  Score: " + str(score)

func die():
	ScoreManager.update_high_score()
	get_tree().change_scene_to_file("res://Scences/exit_menu.tscn")
func body_touch_by_floor(body: Node2D) -> void:
	if body.is_in_group("floor"):
		velocity.y= 300
	pass # Replace with function body.
