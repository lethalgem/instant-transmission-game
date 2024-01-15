extends Node2D

signal animation_finished(animation_name)


func play_idle_animation():
	%AnimatedSprite2D.play("flying")


func play_attack_begin_animation():
	%AnimatedSprite2D.play("attack_begin")


func play_attack_hold_animation():
	%AnimatedSprite2D.play("attack_hold")


func play_death_animation():
	%AnimatedSprite2D.play("death")


func play_overload_animation():
	%AnimatedSprite2D.play("overload")


func play_teleport_begin_animation():
	%AnimatedSprite2D.play("teleport_begin")


func play_teleport_end_animation():
	%AnimatedSprite2D.play("teleport_end")


func _on_animated_sprite_2d_animation_finished():
	animation_finished.emit(%AnimatedSprite2D.animation)
