extends Node2D

signal score_increased

var score = 0
var current_enemy_count = 0
var can_score = false


func _on_goku_health_depleted():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	%GameOver.show()
	Input.set_custom_mouse_cursor(preload("res://cursors/menu_cursor.png"))
	get_tree().paused = true


func spawn_enemy():
	var enemy = preload("res://bardock.tscn").instantiate()
	enemy.health_depleted.connect(_on_enemy_health_depleted)
	%SpawnPath.progress_ratio = randf()
	enemy.global_position = %SpawnPath.global_position
	add_child(enemy)
	current_enemy_count += 1


func _on_spawn_timer_timeout():
	if current_enemy_count < score + 1:
		spawn_enemy()


func _on_enemy_health_depleted():
	current_enemy_count -= 1
	score += 1
	%ScoreLabel.text = str(score)
	score_increased.emit()


func _on_restart_button_pressed():
	Input.set_custom_mouse_cursor(preload("res://cursors/in_game_cursor.png"))
	get_tree().paused = false
	get_tree().reload_current_scene()
