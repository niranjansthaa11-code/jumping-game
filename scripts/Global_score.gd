extends Node

var total_score: int = 0
var high_score:int=0
var previous_high_score: int = 0
func update_high_score():
	if total_score > high_score:
		high_score=total_score
