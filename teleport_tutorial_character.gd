extends AnimatedSprite2D


func _ready():
	begin_teleport()


func begin_teleport():
	play("teleport_begin")
	await animation_finished
	modulate.a = 0
	%TeleportTutorialTimer.start()


func _on_teleport_tutorial_timer_timeout():
	modulate.a = 255
	play("teleport_end")
	await animation_finished
	begin_teleport()
