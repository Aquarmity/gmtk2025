extends StaticBody2D

@onready var timer = $Timer

var bird_scene = preload("res://bird/bird.tscn")
@export var direction = GlobalVars.Direction.RIGHT

func _on_timer_timeout() -> void:
	var bird = bird_scene.instantiate()
	add_child(bird)
	bird.set_direction(direction)
	bird.position = Vector2(1, -5)
