extends AudioStreamPlayer2D

signal finished_oof_sound

@onready var sound_teleport = preload("res://sound_effects/Teleport Sound Effect.mp3")
@onready var sound_attack = preload("res://sound_effects/laserrocket-5984.mp3")
@onready var sound_overload = preload("res://sound_effects/heavy-beam-weapon-7052.mp3")


func play_teleport_sound():
	stream = sound_teleport
	play(0.75)


func play_attack_sound():
	stream = sound_attack
	play()


func play_overload_sound():
	stream = sound_overload
	play()
#
