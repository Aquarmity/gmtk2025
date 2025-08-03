extends Control


func _on_back_pressed() -> void:
	AudioManager.play_sfx(AudioManager.SoundEffects.MENU_BUTTON)
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
