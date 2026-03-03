extends Node2D

@export var speed =100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= speed * delta
	pass


func _on_main_one_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player is in voild")		
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
		
	pass # Replace with function body.
