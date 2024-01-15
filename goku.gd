extends CharacterBody2D

signal health_depleted
signal teleported(new_global_position)

var is_frozen = false
var health = 1


func _ready():
	%HappyBoo.play_idle_animation()
	print(%TeleportPreventionCollision2D.get_path())


func _physics_process(_delta):
	if !is_frozen && Input.is_action_just_released("shoot"):
		attack()


func take_damage():
	health -= 1

	if health == 0:
		queue_free()

		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position

		health_depleted.emit()


func flip_character_if_needed():
	if (
		(global_rotation_degrees > 90 and global_rotation_degrees < 270)
		or (global_rotation_degrees < -90 and global_rotation_degrees > -270)
	):
		scale.y = -1
	else:
		scale.y = 1


func _on_clicked_point_click_released(released_position):
	if !is_frozen:
		teleported.emit(global_position)
		global_position = released_position


func attack():
	look_at(get_global_mouse_position())
	flip_character_if_needed()
	%AttackBeam.is_casting = true
	%AttackTimer.start()
	is_frozen = true


func _on_timer_timeout():
	%AttackBeam.is_casting = false
	is_frozen = false
