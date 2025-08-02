extends Area2D

func _on_area_entered(_area: Area2D) -> void:
	queue_free()

func _on_tree_exiting() -> void:
	SignalBus.append_queue.emit(GlobalVars.PlayerColor.GREEN)
