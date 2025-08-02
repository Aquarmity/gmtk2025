extends Node2D

@onready var sfxStreams = $SFXStreams

enum SoundEffects {
	RESPAWN,
	EXPLOSION,
	STATUE,
	BUSH,
	NO_BUSH,
	BIRD_CHIRP
}

enum Songs {
	
}

const SFX_RESOURCES := {
	SoundEffects.RESPAWN: preload("res://player/respawn.wav"),
	SoundEffects.EXPLOSION: preload("res://player/explosion3.wav"),
	SoundEffects.STATUE: preload("res://player/statue3.wav"),
	SoundEffects.BUSH: preload("res://player/bush.wav"),
	SoundEffects.NO_BUSH: preload("res://player/no_bush.wav"),
	SoundEffects.BIRD_CHIRP: preload("res://bird/bird_chirp.wav")
}

const SONG_RESOURCES := {
	
}


func play_sfx(sfx: SoundEffects):
	for audioStreamPlayer in sfxStreams.get_children():
		if not audioStreamPlayer.is_playing():
			audioStreamPlayer.stream = SFX_RESOURCES[sfx]
			audioStreamPlayer.play()
			break

func play_song(song: Songs):
	$Music.stop()
	$Music.stream = SONG_RESOURCES[song]
	$Music.play()
