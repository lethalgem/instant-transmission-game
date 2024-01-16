extends CharacterBody2D

signal health_depleted
signal teleported(new_global_position)
signal has_overloaded
signal attempted_overload

var is_frozen = false
var health = 1
var teleport_destination = Vector2.ZERO
var can_overload = false


func _ready():
	%PlayerCharacter.play_idle_animation()


func _physics_process(_delta):
	if !is_frozen && Input.is_action_just_released("shoot"):
		begin_attack()
	if Input.is_action_just_released("overload"):
		if can_overload:
			%PlayerCharacter.play_overload_animation()
		else:
			attempted_overload.emit()


func take_damage():
	health -= 1

	if health == 0:
		queue_free()

		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position

		health_depleted.emit()


func overload_attack():
	%OverloadSoundEffectPlayer.play_overload_sound()
	for body in %OverloadAttackArea.get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage()
	can_overload = false
	has_overloaded.emit()


func _on_clicked_point_click_released(released_position):
	if !is_frozen:
		begin_teleport(released_position)


func begin_teleport(to_position):
	teleport_destination = to_position
	%CharacterSoundEffectPlayer.play_teleport_sound()
	%PlayerCharacter.play_teleport_begin_animation()


func teleport():
	teleported.emit(teleport_destination)
	global_position = teleport_destination
	global_rotation = 0
	%PlayerCharacter.play_teleport_end_animation()


func begin_attack():
	look_at(get_global_mouse_position())
	flip_character_if_needed()
	%CharacterSoundEffectPlayer.play_attack_sound()
	%PlayerCharacter.play_attack_begin_animation()


func flip_character_if_needed():
	if (
		(global_rotation_degrees > 90 and global_rotation_degrees < 270)
		or (global_rotation_degrees < -90 and global_rotation_degrees > -270)
	):
		scale.y = -1
	else:
		scale.y = 1


func attack():
	%AttackBeam.is_casting = true
	%AttackTimer.start()
	is_frozen = true


func _on_attack_timer_timeout():
	%PlayerCharacter.play_idle_animation()
	%AttackBeam.is_casting = false
	is_frozen = false


func _on_player_character_animation_finished(animation_name):
	if animation_name == "teleport_begin":
		teleport()
	elif animation_name == "teleport_end":
		%PlayerCharacter.play_idle_animation()
	elif animation_name == "attack_begin":
		attack()
		%PlayerCharacter.play_attack_hold_animation()
	elif animation_name == "overload":
		overload_attack()
		%PlayerCharacter.play_idle_animation()


func _on_overload_progress_bar_progress_bar_full():
	can_overload = true
