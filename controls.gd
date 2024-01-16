extends Control

signal exit_pressed


func get_focus():
	%ExitButton.grab_focus()


func _on_exit_button_pressed():
	exit_pressed.emit()
