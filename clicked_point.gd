extends CharacterBody2D

signal click_released(initial_click_position, released_position, did_exceed_distance)

var is_click_held = false
var click_position = Vector2(0, 0)


func _ready():
	click_position = Vector2(position.x, position.y)
	%MuzzleFlash.hide()


func _physics_process(_delta):
	if Input.is_action_just_pressed("left_click"):
		is_click_held = true
		click_position = get_global_mouse_position()
		global_position = click_position
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		%MuzzleFlash.show()
	elif Input.is_action_just_released("left_click"):
		is_click_held = false
		%MuzzleFlash.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		(
			click_released
			. emit(
				click_position,
				get_global_mouse_position(),
				is_exceeding_required_distance(
					click_position,
					get_global_mouse_position(),
				)
			)
		)

	if is_click_held:
		if is_exceeding_required_distance(
			click_position,
			get_global_mouse_position(),
		):
			%ClickArrow.show()
	else:
		%ClickArrow.hide()


func is_exceeding_required_distance(position_one: Vector2, position_two: Vector2) -> bool:
	const DISTANCE_REQUIRED = 100
	var distance_to_held_position = calculate_distance(
		click_position,
		get_global_mouse_position(),
	)
	return distance_to_held_position > DISTANCE_REQUIRED


func calculate_distance(position_one: Vector2, position_two: Vector2) -> float:
	var dx = position_two.x - position_one.x
	var dy = position_two.y - position_one.y
	var distance = sqrt(dx ** 2 + dy ** 2)
	return distance
