extends Node2D


func _on_goku_health_depleted():
	%GameOver.show()
	get_tree().paused = true
