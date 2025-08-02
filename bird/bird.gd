extends CharacterBody2D

const BIRD_SPEED = 90
var a = 0

func _physics_process(delta: float) -> void:
	#velocity.x = BIRD_SPEED
	velocity = Vector2(BIRD_SPEED, sin(a) * delta * 100)
	a += 0.4
	move_and_slide()
