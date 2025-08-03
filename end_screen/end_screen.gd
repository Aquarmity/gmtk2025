extends Control

@onready var thanks = $Label

func _on_animated_sprite_2d_animation_finished() -> void:
	thanks.visible = true
