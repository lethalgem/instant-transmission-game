extends Control


func _ready():
	%StartButton.grab_focus()
	Input.set_custom_mouse_cursor(preload("res://cursors/menu_cursor.png"))


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
