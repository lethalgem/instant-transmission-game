extends CharacterBody2D

signal click_released(released_position)

var click_position = Vector2(0, 0)


func _ready():
	click_position = Vector2(position.x, position.y)
	%MuzzleFlash.hide()


func _physics_process(_delta):
	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
		global_position = click_position
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		%MuzzleFlash.show()
	elif Input.is_action_just_released("left_click"):
		%MuzzleFlash.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		click_released.emit(click_position)


func calculate_distance(position_one: Vector2, position_two: Vector2) -> float:
	var dx = position_two.x - position_one.x
	var dy = position_two.y - position_one.y
	var distance = sqrt(dx ** 2 + dy ** 2)
	return distance
