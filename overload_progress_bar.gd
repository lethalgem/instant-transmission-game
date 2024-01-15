extends ProgressBar

signal progress_bar_full


func _on_game_score_increased():
	value += 1
	if value == max_value:
		progress_bar_full.emit()


func _on_goku_has_overloaded():
	value = 0
