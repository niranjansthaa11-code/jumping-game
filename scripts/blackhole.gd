extends Node2D

@export var speed =100
@export var acceleration = 5
@export var max_speed = 400

func _process(delta: float) -> void:
	
	if speed < max_speed:
		speed += acceleration * delta
		position.y -= speed * delta

func _on_main_one_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player is in void")		
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
func _ready() -> void:
	pass 
