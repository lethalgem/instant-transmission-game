extends AudioStreamPlayer2D

@onready var current_db = volume_db


func _on_goku_has_overloaded():
	create_tween().tween_property(self, "volume_db", -80, %Timer.wait_time)
	%Timer.start()


func _on_timer_timeout():
	create_tween().tween_property(self, "volume_db", current_db, %Timer.wait_time)
