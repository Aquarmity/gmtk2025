extends CharacterBody2D

@onready var explosion_area = $ExplosionArea/CollisionShape2D
@onready var timer = $Timer
@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -800.0
var frozen_scene = preload("res://frozen_player/frozen_player.tscn")
@export var color: GlobalVars.PlayerColor
var spawnPos: Vector2
var allow_input = true

func _ready() -> void:
	spawnPos = position
	explosion_area.disabled = true

func _physics_process(delta: float) -> void:
	if allow_input:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

	
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and allow_input:
		allow_input = false
		velocity = Vector2(0, 0)
		
		match color:
			GlobalVars.PlayerColor.RED:
				explosion_area.disabled = false
			GlobalVars.PlayerColor.GREEN:
				pass
			GlobalVars.PlayerColor.BLUE:
				collision.disabled = true
				sprite.visible = false
				var frozen_instance = frozen_scene.instantiate()
				frozen_instance.position = position
				get_parent().add_child(frozen_instance)
				position = spawnPos
				
		timer.start()
	
	if event.is_action_pressed("retry"):
		get_tree().reload_current_scene()

func _on_timer_timeout() -> void:
	position = spawnPos
	explosion_area.disabled = true
	allow_input = true
	collision.disabled = false
	sprite.visible = true
	
	color = (color + 1) % 3

func set_color(c: GlobalVars.PlayerColor) -> void:
	color = c
	print(color)
