extends Camera2D


func _process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var velocity = direction * 600 * delta
	global_translate(velocity)


func _on_goku_teleported(new_global_position):
	const TIME_TO_TRANSLATE = 2

	var direction = new_global_position - %CenterOfScreenMarker.global_position
	var magnitude = new_global_position.distance_to(%CenterOfScreenMarker.global_position)
	var normalized = direction / magnitude
	var new_camera_position = %CenterOfScreenMarker.global_position + (4 * normalized)

	var tween = create_tween()
	tween.tween_property(self, "global_position", new_camera_position, TIME_TO_TRANSLATE)
