extends AudioStreamPlayer2D


func _ready():
	create_tween().tween_property(self, "volume_db", 0, 10)


func _process(_delta):
	if !playing:
		play(9.5)
