extends RayCast2D

# Enable to test
#func _unhandled_input(event):
#if event is InputEventMouseButton:
#is_casting = event.pressed

var cast_to_point = Vector2.ZERO
var cast_from_point = Vector2.ZERO

var width = 0

var is_casting = false:
	set(new_value):
		if new_value:
			appear()
		else:
			disappear()

		is_casting = new_value
	get:
		return is_casting


func _ready():
	%Line2D.points[0] = Vector2.ZERO
	%Line2D.points[1] = Vector2.ZERO


func _physics_process(_delta):
	if (
		cast_from_point >= cast_to_point
		and (cast_to_point != Vector2.ZERO or cast_from_point != Vector2.ZERO)
	):
		cast_to_point = Vector2.ZERO
		cast_from_point = Vector2.ZERO

	target_position = cast_to_point
	force_raycast_update()

	%Line2D.points[0] = cast_from_point
	%Line2D.points[1] = cast_to_point
	%Line2D.width = width


func appear():
	const RANGE = 2000
	const TIME_TO_FULL_RANGE = 0.2
	const WIDTH = 5
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "width", WIDTH, TIME_TO_FULL_RANGE)
	tween.tween_property(self, "cast_to_point", Vector2(0, RANGE), TIME_TO_FULL_RANGE).set_trans(
		Tween.TRANS_EXPO
	)


func disappear():
	const TIME_TO_DISAPPEAR = 0.1
	const FINAL_WIDTH = 0
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "width", FINAL_WIDTH, TIME_TO_DISAPPEAR)
	tween.tween_property(self, "cast_from_point", cast_to_point, TIME_TO_DISAPPEAR)


func _on_area_2d_body_entered(body):
	print("entered body")
	if body.has_method("take_damage"):
		body.take_damage()
