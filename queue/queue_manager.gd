extends Node2D

const FILE_BEGIN = "res://levels/level_queues/level_"
@onready var queue_sprite = preload("res://queue/queue_sprite.tscn")

const NORMAL = "N"

var queue: String
var is_normal_cat = false

func _ready() -> void:
	SignalBus.update_queue.connect(_on_update_queue)
	SignalBus.append_queue.connect(_on_append_queue)
	
	var cur_level = get_tree().current_scene.scene_file_path.to_int()
	var f = FileAccess.open(FILE_BEGIN + str(cur_level) + ".txt", FileAccess.READ)
	queue = f.get_as_text()
	queue = queue.substr(0, queue.length() - 1)
	f.close()
	
	
	if queue.length() > 0:
		update_player(queue[0])
		queue = queue.substr(1)
	else:
		update_player(NORMAL)
		is_normal_cat = true
	update_queue(queue)

func update_player(next: String) -> void:
	match next:
		"R":
			SignalBus.next_color.emit(GlobalVars.PlayerColor.RED)
		"G":
			SignalBus.next_color.emit(GlobalVars.PlayerColor.GREEN)
		"B":
			SignalBus.next_color.emit(GlobalVars.PlayerColor.BLUE)
		_:
			SignalBus.next_color.emit(GlobalVars.PlayerColor.NORMAL)

func update_queue(q: String) -> void:
	for n in get_children():
		n.queue_free()
	
	var cur_pos = Vector2(0, 0)
	
	for c in q:
		create_sprite(c, cur_pos)
		cur_pos.y += 15
	create_sprite(NORMAL, cur_pos)

func _on_update_queue() -> void:
	if queue.length() > 0:
		update_player(queue[0])
		queue = queue.substr(1)
		update_queue(queue)
	else:
		update_player(NORMAL)
		is_normal_cat = true

func _on_append_queue(color: GlobalVars.PlayerColor) -> void:
	match color:
		GlobalVars.PlayerColor.RED:
			queue += "R"
		GlobalVars.PlayerColor.GREEN:
			queue += "G"
		GlobalVars.PlayerColor.BLUE:
			queue += "B"
		GlobalVars.PlayerColor.NORMAL:
			pass
	if queue.length() == 1 and is_normal_cat:
		update_player(queue[0])
		queue = queue.substr(1)
		is_normal_cat = false
	update_queue(queue)

func create_sprite(c: String, pos: Vector2) -> void:
	var new_sprite = queue_sprite.instantiate()
	add_child(new_sprite)
	
	match c:
		"R":
			new_sprite.get_node("RedSprite2D").visible = true
		"G":
			new_sprite.get_node("GreenSprite2D").visible = true
		"B":
			new_sprite.get_node("BlueSprite2D").visible = true
		_:
			new_sprite.get_node("NormalSprite2D").visible = true
			
	new_sprite.position = pos
