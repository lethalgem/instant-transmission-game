extends CharacterBody2D

#@onready var player = get_node("/root/Game/Goku")
@onready var teleport_prevention_area = get_node(
	"/root/Game/Goku/TeleportPreventionArea/TeleportPreventionCollision2D"
)


func _ready():
	%Slime.play_walk()


func teleport():
	global_position = calc_random_position()


func _on_teleport_timer_timeout():
	teleport()


func calc_random_position() -> Vector2:
	var new_position = Vector2(
		randf_range(0, get_viewport_rect().size.x), randf_range(0, get_viewport_rect().size.y)
	)

	print(teleport_prevention_area.global_position)
	print(get_viewport_rect())
	print(new_position)

	var has_not_found_appropriate_position = true
	while has_not_found_appropriate_position:
		var prevention_zone = Rect2(
			teleport_prevention_area.global_position, teleport_prevention_area.shape.size
		)
		if prevention_zone.has_point(new_position):
			print("recalcing position")
			#new_position = Vector2(
			#randf_range(0, get_viewport_rect().size.x),
			#randf_range(0, get_viewport_rect().size.y)
			#)
			has_not_found_appropriate_position = false
		else:
			has_not_found_appropriate_position = false
	return new_position
