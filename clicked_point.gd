extends CharacterBody2D

var is_click_held = false
var click_position = Vector2(0,0)

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

	if is_click_held:
		var distance_to_held_position = calculate_distance(click_position, get_global_mouse_position())
		if distance_to_held_position > 200:
			%ClickArrow.show()
	else:
		%ClickArrow.hide()


func calculate_distance(position_one: Vector2, position_two: Vector2) -> float:
	var dx = position_two.x - position_one.x
	var dy = position_two.y - position_one.y
	var distance = sqrt(dx**2 + dy**2)
	return distance


