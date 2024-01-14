extends CharacterBody2D

var is_frozen = false


func _ready():
	%HappyBoo.play_idle_animation()
	print(%TeleportPreventionCollision2D.get_path())


func _on_clicked_point_click_released(
	initial_click_position, released_position, did_exceed_distance
):
	if !is_frozen:
		global_position = initial_click_position
		if did_exceed_distance:
			look_at(released_position)
			%Beam.is_casting = true

		%Timer.start()
		is_frozen = true


func _on_timer_timeout():
	is_frozen = false
