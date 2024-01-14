extends CharacterBody2D

var health = 1

@onready var teleport_prevention_area = get_node(
	"/root/Game/Goku/TeleportPreventionArea/TeleportPreventionCollision2D"
)


func _ready():
	%Slime.play_walk()


func take_damage():
	health -= 1
	%Slime.play_hurt()

	if health == 0:
		queue_free()

		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position


func teleport():
	global_position = calc_random_position()


func _on_teleport_timer_timeout():
	teleport()


func calc_random_position() -> Vector2:
	var new_position = Vector2(
		randf_range(0, get_viewport_rect().size.x), randf_range(0, get_viewport_rect().size.y)
	)

	var has_not_found_appropriate_position = true
	while has_not_found_appropriate_position:
		var prevention_zone = Rect2(
			teleport_prevention_area.global_position, teleport_prevention_area.shape.size
		)
		if prevention_zone.has_point(new_position):
			new_position = Vector2(
				randf_range(0, get_viewport_rect().size.x),
				randf_range(0, get_viewport_rect().size.y)
			)
		else:
			has_not_found_appropriate_position = false
	return new_position
