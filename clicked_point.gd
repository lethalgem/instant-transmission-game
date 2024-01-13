extends CharacterBody2D

var is_click_held = false
var click_position = Vector2(0,0)

func _ready():
	click_position = Vector2(position.x, position.y)

func _physics_process(delta):
	if Input.is_action_just_pressed("left_click"):
		print("DOWN")
		is_click_held = true
		click_position = get_global_mouse_position()
		global_position = click_position
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		%MuzzleFlash.show()
	elif Input.is_action_just_released("left_click"):
		print("UP")
		is_click_held = false
		%MuzzleFlash.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if is_click_held:




