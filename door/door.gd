extends Node2D

const FILE_BEGIN = "res://levels/level_"
@export var flip = false
@export var end = false

func _ready() -> void:
	if flip:
		$Sprite2D.flip_h = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		AudioManager.play_sfx(AudioManager.SoundEffects.LEVEL_COMPLETE)
		
		if end:
			AudioManager.play_song(AudioManager.Songs.MAIN_MENU)
			get_tree().change_scene_to_file.bind("res://end_screen/end_screen.tscn").call_deferred()
		else:
			var current_scene_file = get_tree().current_scene.scene_file_path
			var next_level_number = current_scene_file.to_int() + 1
			GlobalVars.next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
			
			get_tree().change_scene_to_file.bind("res://loading_screen/loading_screen.tscn").call_deferred()
