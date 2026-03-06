extends StaticBody2D
@onready var touch =$opps

var was_touched = false 
var is_fake = false  #
func get_score():
	if not was_touched:
		was_touched = true
		
		if is_fake:
			touch.play()
			start_disappearing()
			
		return 1
	return 0

func start_disappearing():
	# 1. Turn it dark immediately to warn the player
	modulate = Color(0.1, 0.1, 0.1, 1.0) 
	
	await get_tree().create_timer(0.3).timeout
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(0, 0, 0, 0), 0.5)
	tween.finished.connect(queue_free)

func _process(_delta):
	# Keep your existing cleanup code here to delete old logs
	var cam = get_viewport().get_camera_2d()
	if cam and global_position.y > cam.global_position.y + 1000:
		queue_free()
