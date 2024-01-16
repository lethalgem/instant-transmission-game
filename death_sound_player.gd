extends AudioStreamPlayer2D

@onready var sound_oof_1 = preload("res://sound_effects/oof 1.wav")
@onready var sound_oof_2 = preload("res://sound_effects/oof 2.wav")
@onready var sound_oof_3 = preload("res://sound_effects/oof 3.wav")
@onready var sound_oof_4 = preload("res://sound_effects/oof 4.wav")
@onready var sound_oof_5 = preload("res://sound_effects/oof 5.wav")
@onready var sound_oof_6 = preload("res://sound_effects/oof 6.wav")
@onready var sound_oof_7 = preload("res://sound_effects/oof 7.wav")
@onready var sound_oof_8 = preload("res://sound_effects/oof 8.wav")
@onready var sound_oof_9 = preload("res://sound_effects/oof 9.wav")
@onready var sound_oof_10 = preload("res://sound_effects/oof 10.wav")
@onready var sound_oof_11 = preload("res://sound_effects/oof 11.wav")
var oof_sounds: Array


func _ready():
	oof_sounds = [
		sound_oof_1,
		sound_oof_2,
		sound_oof_3,
		sound_oof_4,
		sound_oof_5,
		sound_oof_6,
		sound_oof_7,
		sound_oof_8,
		sound_oof_9,
		sound_oof_10,
		sound_oof_11,
	]
	randomize()


func play_oof_sound():
	stream = oof_sounds[randi() % oof_sounds.size()]
	play(0.02)
