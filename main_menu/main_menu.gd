extends Control

func _ready() -> void:
	if not GlobalVars.main_menu_music_playing:
		AudioManager.play_song(AudioManager.Songs.MAIN_MENU)
	GlobalVars.main_menu_music_playing = true

func _on_play_pressed() -> void:
	AudioManager.play_sfx(AudioManager.SoundEffects.MENU_BUTTON)
	GlobalVars.main_menu_music_playing = false
	AudioManager.play_song(AudioManager.Songs.LEVEL_THEME)
	get_tree().change_scene_to_file("res://levels/level_0.tscn")


func _on_options_pressed() -> void:
	AudioManager.play_sfx(AudioManager.SoundEffects.MENU_BUTTON)
	get_tree().change_scene_to_file("res://options_menu/options_menu.tscn")


func _on_credits_pressed() -> void:
	AudioManager.play_sfx(AudioManager.SoundEffects.MENU_BUTTON)
	get_tree().change_scene_to_file("res://credits_menu/credits_menu.tscn")
