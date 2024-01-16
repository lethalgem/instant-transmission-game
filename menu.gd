extends Control


func _ready():
	%StartButton.grab_focus()
	Input.set_custom_mouse_cursor(preload("res://cursors/menu_cursor.png"))


func _on_start_button_pressed():
	SceneTransition.change_scene_to_file("res://game.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_fullscreen_button_pressed():
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		%FullscreenButton.text = "Windowed"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		%FullscreenButton.text = "Fullscreen"


func _on_controls_button_pressed():
	%TopLevelMenu.hide()
	%Character.hide()
	%Controls.show()


func _on_controls_exit_pressed():
	%TopLevelMenu.show()
	%Character.show()
	%Controls.hide()
