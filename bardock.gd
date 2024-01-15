extends CharacterBody2D

signal health_depleted

var health = 1

@onready var player = get_node("/root/Game/Goku")
@onready var teleport_prevention_area = get_node(
	"/root/Game/Goku/TeleportPreventionArea/TeleportPreventionCollision2D"
)


func _ready():
	%Slime.play_walk()
	if player == null:
		player = %TestTargetCollisionShape2D


func take_damage():
	health -= 1
	%Slime.play_hurt()

	if health == 0:
		queue_free()

		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position

		health_depleted.emit()


func teleport():
	global_position = calc_random_position()
	look_at(player.global_position)
	flip_character_if_needed()


func _on_teleport_timer_timeout():
	teleport()
	%TeleportTimer.set_paused(true)
	%DelayUntilAimTimer.start()
	%DelayUntilAttackTimer.start()


func calc_random_position() -> Vector2:
	var new_position = Vector2(
		randf_range(0, get_viewport_rect().size.x), randf_range(0, get_viewport_rect().size.y)
	)

	var has_not_found_appropriate_position = true
	while has_not_found_appropriate_position and teleport_prevention_area != null:
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


func flip_character_if_needed():
	if (
		(global_rotation_degrees > 90 and global_rotation_degrees < 270)
		or (global_rotation_degrees < -90 and global_rotation_degrees > -270)
	):
		scale.y = -1
	else:
		scale.y = 1


func _on_delay_until_aim_timer_timeout():
	%AimBeam.is_casting = true


func _on_delay_until_attack_timer_timeout():
	%AimBeam.is_casting = false
	attack()


func _on_attack_timer_timeout():
	%EnemyBeam.is_casting = false
	%TeleportTimer.set_paused(false)


func attack():
	%EnemyBeam.is_casting = true
	%AttackTimer.start()
