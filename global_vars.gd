extends Node

enum PlayerColor {
	RED,
	GREEN,
	BLUE,
	NORMAL
}

enum Direction {
	LEFT,
	RIGHT
}

var main_menu_music_playing = false

var next_level_path: String = "res://levels/level_0.tscn"
