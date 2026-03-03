extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -800
@onready var sprite = $AnimatedSprite2D
#getting the gravity
var gravity = 1000

func _physics_process(delta):
	# adding gravity for the sprite
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite.play("jump")

	# Making the thing jump 
	if Input.is_action_just_pressed("jump") and is_on_floor():
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


func body_touch_by_floor(body: Node2D) -> void:
	if body.is_in_group("floor"):
		velocity.y= 300
	pass # Replace with function body.
