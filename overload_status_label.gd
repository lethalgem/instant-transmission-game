extends Label

var overload_ready = false
var speed = 3
var time = 0
var sinTime = 0
var _visible = false
var fade = false
""":
	set(value):
		if value:
			time = 0
			sinTime = 0
		else:
			sinTime = 0
		fade = value
	get:
		return fade"""


func flashText():
	if !fade:
		if sinTime > 0:
			_visible = true
		else:
			_visible = false
	else:
		_visible = true
		modulate.a = sinTime
	visible = _visible


func _physics_process(delta):
	time += delta
	sinTime = sin(time * speed)
	flashText()


func update_label():
	if overload_ready:
		text = "OVERLOAD READY! PRESS F TO USE!"
	else:
		text = "OVERLOAD NOT READY. DEFEAT MORE ENEMIES!"


func _on_overload_progress_bar_progress_bar_full():
	overload_ready = true
	update_label()
	fade = true


func _on_goku_has_overloaded():
	overload_ready = false
	update_label()
	fade = false


func _on_goku_attempted_overload():
	overload_ready = false
	update_label()
	fade = true
	%ShowTimer.start()


func _on_show_timer_timeout():
	fade = false
