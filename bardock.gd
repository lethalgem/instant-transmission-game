extends CharacterBody2D

signal health_depleted

var health = 1

@onready var player = get_node("/root/Game/Goku")
@onready var teleport_prevention_area = get_node(
	"/root/Game/Goku/TeleportPreventionArea/TeleportPreventionCollision2D"
)


func take_damage():
	health -= 1

	if health == 0:
		queue_free()

		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position

		health_depleted.emit()


func teleport():
	%TeleportTimer.set_paused(true)
	%DelayUntilAimTimer.start()
	%DelayUntilAttackTimer.start()
	global_position = calc_random_position()
	look_at(player.global_position)
	flip_character_if_needed()
	%EnemyCharacter.play_teleport_end_animation()


func _on_teleport_timer_timeout():
	%CharacterSoundEffectPlayer.play_teleport_sound()
	%EnemyCharacter.play_teleport_begin_animation()


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
	%EnemyCharacter.play_attack_begin_animation()
	%AimBeam.is_casting = true


func _on_delay_until_attack_timer_timeout():
	%AimBeam.is_casting = false
	%EnemyCharacter.play_attack_hold_animation()
	attack()


func _on_attack_timer_timeout():
	%EnemyBeam.is_casting = false
	%EnemyCharacter.play_idle_animation()
	%TeleportTimer.set_paused(false)


func attack():
	%CharacterSoundEffectPlayer.play_attack_sound()
	%EnemyBeam.is_casting = true
	%AttackTimer.start()


func _on_enemy_character_animation_finished(animation_name):
	if animation_name == "teleport_begin":
		teleport()
	if animation_name == "teleport_end":
		%EnemyCharacter.play_idle_animation()
