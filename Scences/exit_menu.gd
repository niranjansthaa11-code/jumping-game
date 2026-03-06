extends Control
@onready var final_score_display = $Final_score
@onready var best_score_label = $Best_score
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	final_score_display.text = "Your Final Climb Score is : " + str(ScoreManager.total_score)
	best_score_label.text = "BEST EVER: " + str(ScoreManager.high_score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scences/main_menu.tscn")
	pass # Replace with function body.
	


func _on_restart_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Scences/game_manager.tscn")
	
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
