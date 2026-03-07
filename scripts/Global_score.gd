extends Node

var high_score: int = 0
var last_run_score: int = 0 # Use this to store what the player just got

# Notice the 'final_score' inside the () below!
func update_high_score(final_score: int):
	last_run_score = final_score
	if last_run_score > high_score:
		high_score = last_run_score
		# save_score() would go here if you added it
