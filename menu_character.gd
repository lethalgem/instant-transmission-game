extends AnimatedSprite2D

var hovering_up = true
const HOVER_DISTANCE = 50


func _ready():
	hover()


func _on_float_timer_timeout():
	hover()


func hover():
	var distance = HOVER_DISTANCE
	if !hovering_up:
		distance = -HOVER_DISTANCE
	hovering_up = !hovering_up

	(
		create_tween()
		. tween_property(
			self,
			"global_position",
			Vector2(global_position.x, global_position.y + distance),
			%HoverTimer.wait_time
		)
		. set_ease(Tween.EASE_IN_OUT)
		. set_trans(Tween.TRANS_SINE)
	)
