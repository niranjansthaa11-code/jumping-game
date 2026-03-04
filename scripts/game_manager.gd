extends Node2D

@onready var platforms = preload("res://Scences/floor.tscn")
@onready var music =$Music_manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
