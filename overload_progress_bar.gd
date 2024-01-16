extends ProgressBar

signal progress_bar_full

var can_fill = true


func _on_game_score_increased():
	if can_fill:
		value += 1
		if value == max_value:
			progress_bar_full.emit()


func _on_goku_has_overloaded():
	value = 0
	can_fill = false
	%PauseOverloadFillTimer.start()


func _on_pause_score_timer_timeout():
	can_fill = true
