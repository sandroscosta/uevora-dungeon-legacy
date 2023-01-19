extends Node
#Global variables and game state

const MAX_ROUND_ENEMIES = 3

var player_hp: int = 100
var _player_max_hp: int = 100 setget set_max_hp, get_max_hp
var wave: int = 0
var max_waves: int = 6
var enemies_killed: int = 0
var spawn_num_enemies: int = MAX_ROUND_ENEMIES

var possible_titles = ["Captain", "Seaman", "King", "Sir", "Doctor", "Gunman"]
var possible_first_names = ["Smartpants", "Christ", "Phasma", "Buhuu", "Pastry", "Wineman", "Vice"]
var possible_last_names = ["the First", "The Last", "the Very Best", "the Church", "the Killer", "the Slayer"]

var character_name: String = "Captain Smartpants the Third"

var chose_proportions: Dictionary = {
	"regular": Vector2(1,1),
	"thin": Vector2(0.6, 1),
	"fat": Vector2(1.6, 1)
}

var chose_health: Dictionary = {
	"regular": 100,
	"thin": 75,
	"fat": 150
}

var chose_speed: Dictionary = {
	"regular": 75,
	"thin": 100,
	"fat": 45
}

var chose_weapons: Array = ["WeaponKnife.tscn", "WeaponAxe.tscn", "WeaponHammer.tscn"]

func set_max_hp(max_hp: int):
	_player_max_hp = max_hp

func get_max_hp():
	return _player_max_hp

func restart_game():
	player_hp = _player_max_hp
	wave = 0
	spawn_num_enemies = MAX_ROUND_ENEMIES
