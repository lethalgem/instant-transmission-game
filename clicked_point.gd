extends CharacterBody2D

signal click_released(released_position)

var click_position = Vector2(0, 0)


func _ready():
	click_position = Vector2(position.x, position.y)
	%Cursor.hide()


func _physics_process(_delta):
	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
		global_position = click_position
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		%Cursor.show()
		var tween = create_tween()
		tween.tween_property(%Cursor, "rotation", deg_to_rad(45), 0.1)
	elif Input.is_action_just_released("left_click"):
		%Cursor.hide()
		var tween = create_tween()
		tween.tween_property(%Cursor, "rotation", deg_to_rad(-45), 0.1)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		click_released.emit(click_position)
