extends RigidBody2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("explosion"):
		queue_free()
