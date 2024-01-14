extends RayCast2D

var cast_point = Vector2(0, 0)

var is_casting = false:
	set(new_value):
		print("setting is casting to {a}".format({"a": new_value}))
		if new_value:
			appear()
		else:
			disappear()
		set_physics_process(new_value)
		is_casting = new_value
	get:
		return is_casting


func _ready():
	print("ready")
	set_physics_process(false)
	%Line2D.points[1] = Vector2.ZERO


func _unhandled_input(event):
	if event is InputEventMouseButton:
		self.is_casting = event.pressed


func _physics_process(delta):
	target_position = cast_point
	force_raycast_update()
#
	if is_colliding():
		cast_point = to_local(get_collision_point())

	print(cast_point)
	%Line2D.points[1] = cast_point


func appear():
	print("Appearing")
	const RANGE = 2000
	const TIME_TO_FULL_RANGE = 0.2
	const WIDTH = 10
	#var tween = create_tween()
	var tween = create_tween().set_parallel(true)
	tween.tween_property(%Line2D, "width", WIDTH, TIME_TO_FULL_RANGE)
	tween.tween_property(self, "cast_point", Vector2(0, RANGE), TIME_TO_FULL_RANGE)


func disappear():
	print("Disappearing")
	const TIME_TO_DISAPPEAR = 0.1
	var tween = create_tween().set_parallel(true)
	tween.tween_property(%Line2D, "width", 0, TIME_TO_DISAPPEAR)
	tween.tween_property(self, "cast_point", Vector2(0, 0), TIME_TO_DISAPPEAR)
