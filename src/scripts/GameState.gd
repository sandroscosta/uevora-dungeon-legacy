extends Node
#Global variables and game state

var player_hp: int = 100
var _player_max_hp: int = 100 setget set_max_hp, get_max_hp
var wave: int = 1
var enemies_killed: int = 0
var spawn_num_enemies: int = 5

func set_max_hp(max_hp: int):
	_player_max_hp = max_hp

func get_max_hp():
	return _player_max_hp
