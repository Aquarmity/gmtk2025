extends Control


func _on_animated_sprite_2d_animation_finished() -> void:
	get_tree().change_scene_to_file.bind(GlobalVars.next_level_path).call_deferred()
