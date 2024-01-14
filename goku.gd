extends CharacterBody2D

var is_frozen = false
var health = 1


func _ready():
	%HappyBoo.play_idle_animation()
	print(%TeleportPreventionCollision2D.get_path())


func take_damage():
	health -= 1

	if health == 0:
		queue_free()

		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position


func _on_clicked_point_click_released(
	initial_click_position, released_position, did_exceed_distance
):
	if !is_frozen:
		global_position = initial_click_position
		if did_exceed_distance:
			look_at(released_position)
			%AttackBeam.is_casting = true

		%AttackTimer.start()
		is_frozen = true


func _on_timer_timeout():
	%AttackBeam.is_casting = false
	is_frozen = false
