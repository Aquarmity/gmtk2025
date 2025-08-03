extends Node2D

@onready var sfxStreams = $SFXStreams

enum SoundEffects {
	RESPAWN,
	EXPLOSION,
	STATUE,
	BUSH,
	NO_BUSH,
	BIRD_CHIRP,
	MENU_BUTTON
}

enum Songs {
	MAIN_MENU,
	LEVEL_THEME
}

const SFX_RESOURCES := {
	SoundEffects.RESPAWN: preload("res://player/respawn.wav"),
	SoundEffects.EXPLOSION: preload("res://player/explosion.wav"),
	SoundEffects.STATUE: preload("res://player/statue.wav"),
	SoundEffects.BUSH: preload("res://player/bush.wav"),
	SoundEffects.NO_BUSH: preload("res://player/no_bush.wav"),
	SoundEffects.BIRD_CHIRP: preload("res://bird/bird_chirp.wav"),
	SoundEffects.MENU_BUTTON: preload("res://main_menu/menu_select.wav")
}

const SONG_RESOURCES := {
	Songs.MAIN_MENU: preload("res://main_menu/main_menu.mp3"),
	Songs.LEVEL_THEME: preload("res://levels/level_theme.mp3")
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
