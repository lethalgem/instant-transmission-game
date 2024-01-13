extends CharacterBody2D


func _ready():
	%HappyBoo.play_idle_animation()


func _on_clicked_point_click_released(
	initial_click_position, released_position, did_exceed_distance
):
	global_position = initial_click_position
	if did_exceed_distance:
		look_at(released_position)
