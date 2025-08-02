extends CharacterBody2D

@onready var explosion_area = $ExplosionArea/CollisionShape2D
@onready var timer = $Timer
@onready var collision = $CollisionShape2D
@onready var sprite = $NormalAnimatedSprite2D

const SPEED = 75.0
const JUMP_VELOCITY = -300.0
var frozen_scene = preload("res://frozen_player/frozen_player.tscn")
var bush_scene = preload("res://bush/bush.tscn")
var color: GlobalVars.PlayerColor
var spawnPos: Vector2
var allow_input = true
var allow_grass = false

signal update_queue

func _ready() -> void:
	spawnPos = position
	explosion_area.disabled = true
	set_color(GlobalVars.PlayerColor.GREEN)

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
			
		if direction > 0:
			sprite.flip_h = false
		elif direction < 0:
			sprite.flip_h = true
		
		if direction == 0:
			sprite.play("idle")
		else:
			sprite.play("walk")

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and allow_input and color != GlobalVars.PlayerColor.NORMAL:
		match color:
			GlobalVars.PlayerColor.RED:
				explosion_area.disabled = false
			GlobalVars.PlayerColor.GREEN:
				if (is_on_floor() or is_on_wall() or is_on_ceiling()) and allow_grass:
					collision.disabled = true
					sprite.visible = false
					var bush_instance = bush_scene.instantiate()
					bush_instance.position = position
					get_parent().add_child(bush_instance)
					position = spawnPos
				else:
					return
			GlobalVars.PlayerColor.BLUE:
				collision.disabled = true
				sprite.visible = false
				var frozen_instance = frozen_scene.instantiate()
				frozen_instance.position = position
				get_parent().add_child(frozen_instance)
				position = spawnPos

		# IF THINGS BREAK MOVE THESE BACK TO THE START OF THE FUNCTION
		allow_input = false
		velocity = Vector2(0, 0)
		timer.start()
	
	if event.is_action_pressed("retry"):
		get_tree().reload_current_scene()

func _on_timer_timeout() -> void:
	position = spawnPos
	explosion_area.disabled = true
	allow_input = true
	collision.disabled = false
	sprite.visible = true
	
	update_queue.emit()

func set_color(c: GlobalVars.PlayerColor) -> void:
	color = c
	sprite.visible = false
	match color:
		GlobalVars.PlayerColor.RED:
			sprite = $RedAnimatedSprite2D
		GlobalVars.PlayerColor.GREEN:
			sprite = $GreenAnimatedSprite2D
		GlobalVars.PlayerColor.BLUE:
			sprite = $BlueAnimatedSprite2D
		GlobalVars.PlayerColor.NORMAL:
			sprite = $NormalAnimatedSprite2D
	sprite.visible = true


func _on_queue_manager_next_color(c: GlobalVars.PlayerColor) -> void:
	set_color(c)


func _on_grass_detection_area_body_entered(_body: Node2D) -> void:
	allow_grass = true


func _on_grass_detection_area_body_exited(_body: Node2D) -> void:
	allow_grass = false


func _on_enemy_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		collision.call_deferred("set_disabled", true)
		sprite.visible = false
		allow_input = false
		timer.start()
