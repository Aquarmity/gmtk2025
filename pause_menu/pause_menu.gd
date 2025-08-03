extends CanvasLayer

@onready var main = $"../"

func _on_resume_pressed() -> void:
	AudioManager.play_sfx(AudioManager.SoundEffects.MENU_BUTTON)
	main.pauseMenu()


func _on_main_menu_pressed() -> void:
	AudioManager.play_sfx(AudioManager.SoundEffects.MENU_BUTTON)
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
