extends Camera2D

var current_corner = 1
const IMPULSE_AMOUNT = 5


func _ready():
	shake_camera()


func shake_camera():
	var TIME_TO_TRANSLATE = %ShakeTimer.wait_time

	var new_camera_position = Vector2.ZERO

	if current_corner == 1:
		new_camera_position = Vector2(
			global_position.x + IMPULSE_AMOUNT, global_position.y + IMPULSE_AMOUNT
		)
		current_corner += 1
	elif current_corner == 2:
		new_camera_position = Vector2(
			global_position.x - IMPULSE_AMOUNT, global_position.y + IMPULSE_AMOUNT
		)
		current_corner += 1
	elif current_corner == 3:
		new_camera_position = Vector2(
			global_position.x - IMPULSE_AMOUNT, global_position.y - IMPULSE_AMOUNT
		)
		current_corner += 1
	elif current_corner == 4:
		new_camera_position = Vector2(
			global_position.x + IMPULSE_AMOUNT, global_position.y - IMPULSE_AMOUNT
		)
		current_corner = 1

	var tween = create_tween()
	(
		tween
		. tween_property(self, "global_position", new_camera_position, TIME_TO_TRANSLATE)
		. set_ease(Tween.EASE_IN_OUT)
		. set_trans(tween.TRANS_SINE)
	)


func _on_shake_timer_timeout():
	shake_camera()
