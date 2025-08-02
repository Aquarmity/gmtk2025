extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
