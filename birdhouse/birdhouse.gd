extends StaticBody2D

@onready var timer = $Timer

var bird_scene = preload("res://bird/bird.tscn")

#func _ready() -> void:
	#spawn_loop()
	#
#func spawn_loop() -> void:
	#timer.start()
	#var bird = bird_scene.instantiate()
	#
	#bird.position = position
	#pass


func _on_timer_timeout() -> void:
	var bird = bird_scene.instantiate()
	add_child(bird)
	bird.position = Vector2(1, -5)
