extends RayCast2D

# Enable to test
# func _unhandled_input(event):
# 	if event is InputEventMouseButton:
# 		is_casting = event.pressed

var cast_point = Vector2(0, 0)
var width = 0

var is_casting = false:
	set(new_value):
		%BeamParticles2D.emitting = new_value
		%CastingParticles2D.emitting = new_value

		if new_value:
			appear()
		else:
			%CollisionParticles2D.emitting = false
			disappear()

		is_casting = new_value
	get:
		return is_casting


func _ready():
	%Line2D.points[1] = Vector2.ZERO


func _physics_process(_delta):
	target_position = cast_point
	force_raycast_update()

	%CollisionParticles2D.emitting = is_colliding()

	if is_colliding():
		cast_point = to_local(get_collision_point())
		%CollisionParticles2D.global_rotation = get_collision_normal().angle() - 90
		%CollisionParticles2D.position = cast_point

	%Line2D.points[1] = cast_point
	%Line2D.width = width
	%BeamCollisionShape2D.shape.size = Vector2(width, cast_point.y)
	%BeamCollisionShape2D.position = Vector2(
		%BeamCollisionShape2D.position.x, cast_point.y / 2 + 10
	)
	%BeamParticles2D.position = cast_point * 0.5
	%BeamParticles2D.emission_rect_extents.y = cast_point.length() * 0.5


func appear():
	const RANGE = 2000
	const TIME_TO_FULL_RANGE = 0.2
	const WIDTH = 40
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "width", WIDTH, TIME_TO_FULL_RANGE)
	tween.tween_property(self, "cast_point", Vector2(0, RANGE), TIME_TO_FULL_RANGE)


func disappear():
	const TIME_TO_DISAPPEAR = 0.1
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "width", 0, TIME_TO_DISAPPEAR)
	tween.tween_property(self, "cast_point", Vector2(0, 0), TIME_TO_DISAPPEAR)


func _on_area_2d_body_entered(body):
	print("entered body")
	if body.has_method("take_damage"):
		body.take_damage()
