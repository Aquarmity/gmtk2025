extends CharacterBody2D

@onready var explosion_area = $ExplosionArea/CollisionShape2D
@onready var timer = $Timer

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -800.0
var color: GlobalVars.PlayerColor
var spawnPos: Vector2
var allow_input = true

func _ready() -> void:
	color = GlobalVars.PlayerColor.RED
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
	if event.is_action_pressed("action"):
		match color:
			GlobalVars.PlayerColor.RED:
				explosion_area.disabled = false
				allow_input = false
				velocity = Vector2(0, 0)
				timer.start()
			GlobalVars.PlayerColor.GREEN:
				pass
			GlobalVars.PlayerColor.BLUE:
				pass

func _on_timer_timeout() -> void:
	position = spawnPos
	explosion_area.disabled = true
	allow_input = true

func set_color(c: GlobalVars.PlayerColor) -> void:
	color = c
	print(color)
