extends Node

const MAX_ROUND_ENEMIES = 5
const DEFAULT_MANA_VALUE = 2
const DEFAULT_MAX_MANA_VALUE = 10
const HARDGAME_MODIFIER = 1.5
const MAX_DEFAULT_HEALTH = 100
const DEFAULT_MAX_WAVES = 6

enum Difficulty {EASY, HARD}

var random = RandomNumberGenerator.new()

var player_hp: int = MAX_DEFAULT_HEALTH
var _player_max_hp: int = MAX_DEFAULT_HEALTH setget , get_max_hp
var player_mana: int = DEFAULT_MAX_MANA_VALUE
var mana_value: int = DEFAULT_MANA_VALUE
var treasure: int = 0
var wave: int = 0
var max_waves: int = DEFAULT_MAX_WAVES
var enemies_killed: int = 0
var wave_enemy_kills: int = 0
var spawn_num_enemies: int = MAX_ROUND_ENEMIES
var game_difficulty = Difficulty.EASY
var boss_killed: bool = false
var active_curse: bool = false

# Shop upgrades
var health_drops: bool = false
var large_mana: bool = false

var heirs: Array = []


var weak_enemies: Array = ["EnemyBase.tscn", "WeakEnemy.tscn"] setget , get_basic_enemy
var boss_fights: Array = ["ZombieBoss.tscn", "LizardBoss.tscn"] setget , get_boss_fight

var possible_titles = ["Captain", "Seaman", "King", "Sir", "Doctor", "Gunman"]
var possible_first_names = ["Smartpants", "Christ", "Phasma", "Buhuu", "Pastry", "Wineman", "Vice"]
var possible_last_names = ["the First", "The Last", "the Very Best", "the Church", "the Killer", "the Slayer"]

var character_name: String

var build

var build_types = ["regular", "thin", "fat"]

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
var chose_powers: Array = ["IceBall.tscn", "FireBall.tscn"]


func get_max_hp():
	return _player_max_hp

func restart_game():
	wave = 0
	spawn_num_enemies = MAX_ROUND_ENEMIES
	player_mana = DEFAULT_MAX_MANA_VALUE
	build = generate_next_of_kin_build()
	generate_next_of_kin(build)

func _ready():
	random.randomize()
	build = generate_next_of_kin_build()
	generate_next_of_kin(build)
	
func generate_next_of_kin(heir):
	character_name = heir["character_name"]
	heirs.append(character_name)
	_player_max_hp = heir["build"]["health"]
	player_hp = _player_max_hp
	active_curse = true if random.randi_range(0,1) > 0 else false

func _get_player_name():
	var name = ""
	name += possible_titles[random.randi_range(0, len(possible_titles)-1)]
	name += " " + possible_first_names[random.randi_range(0, len(possible_first_names)-1)]
	name += " " + possible_last_names[random.randi_range(0, len(possible_last_names)-1)]
	return name
	
func _get_player_build():
	var randbuild:String = build_types[random.randi_range(0, len(build_types)-1)]
	return {
		"scale": chose_proportions[randbuild],
		"health": chose_health[randbuild],
		"speed": chose_speed[randbuild],
		}

func _get_player_weapon():
	return chose_weapons[random.randi_range(0, len(chose_weapons)-1)]
	
func _get_player_power():
	return chose_powers[random.randi_range(0, len(chose_powers)-1)]

func generate_next_wave():
	wave += 1
	if game_difficulty == Difficulty.HARD:
		spawn_num_enemies = MAX_ROUND_ENEMIES * wave * 2
	else:
		spawn_num_enemies = MAX_ROUND_ENEMIES * wave
	wave_enemy_kills = 0
	character_name = _get_player_name()
	heirs.append(character_name)

func generate_next_of_kin_build():
	# the dict should return the characteristics of the player, including weapon
	var next: Dictionary = {
		"character_name": _get_player_name(),
		"build": _get_player_build(),
		"weapon": _get_player_weapon(),
		"power": _get_player_power()
		}
	return next
	
	
func get_boss_fight():
	return "res://src/scenes/" + boss_fights[random.randi_range(0,len(boss_fights)-1)]

func get_basic_enemy():
	return "res://src/scenes/" + weak_enemies[random.randi_range(0,len(weak_enemies)-1)]
