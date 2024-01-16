extends Control

signal exit_pressed


func _on_exit_button_pressed():
	exit_pressed.emit()
