extends CharacterBody2D

# 1. Setup your constants
const SPEED = 400.0
const JUMP_VELOCITY = -500.0 # Negative is UP in Godot

# 2. Get the gravity from Project Settings (standard is 980)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# 3. Add Gravity if not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta

	# 4. Handle Jump (Using your 'space' action)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 5. Get direction using your 'left' and 'right' actions
	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		# Smoothly stop when no button is pressed
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 6. Apply movement and check for the floor
	move_and_slide()
