extends Node2D

const FILE_BEGIN = "res://levels/level_queues/level_"
@onready var queue_sprite = preload("res://queue/queue_sprite.tscn")

var queue: String
var cur_index = 0

signal next_color(color: GlobalVars.PlayerColor)

func _ready() -> void:
	var cur_level = get_tree().current_scene.scene_file_path.to_int()
	var f = FileAccess.open(FILE_BEGIN + str(cur_level) + ".txt", FileAccess.READ)
	queue = f.get_as_text()
	
	update_queue(queue)
	
func update_queue(queue: String) -> void:
	for n in get_children():
		n.queue_free()
	
	match queue[0]:
		"R":
			next_color.emit(GlobalVars.PlayerColor.RED)
		"G":
			next_color.emit(GlobalVars.PlayerColor.GREEN)
		"B":
			next_color.emit(GlobalVars.PlayerColor.BLUE)
		_:
			next_color.emit(GlobalVars.PlayerColor.NORMAL)
	
	if queue.length() > 1:
		var cur_pos = Vector2(0, 0)
		
		for c in queue.substr(1, queue.length() - 1):
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
			new_sprite.position = cur_pos
			cur_pos.y += 20

func _on_player_update_queue() -> void:
	cur_index += 1
	update_queue(queue.substr(cur_index))
	
