extends CharacterBody2D

@onready var sprite = $Sprite2D

const BIRD_SPEED = 90
var a = 0
var direction: GlobalVars.Direction

func _ready() -> void:
	AudioManager.play_sfx(AudioManager.SoundEffects.BIRD_CHIRP)

func _physics_process(_delta: float) -> void:
	if direction == GlobalVars.Direction.RIGHT:
		velocity.x = BIRD_SPEED
	else:
		velocity.x = -BIRD_SPEED
		sprite.flip_h = true
	move_and_slide()

func set_direction(dir: GlobalVars.Direction) -> void:
	direction = dir


func _on_area_2d_body_entered(_body: Node2D) -> void:
	queue_free()
