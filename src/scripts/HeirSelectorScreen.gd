extends Control

var heirs: Array = []

onready var char1 = get_node("Char1")
onready var char2 = get_node("Char2")
onready var char3 = get_node("Char3")

func _generate_possible_heirs():
	for i in range(3):
		heirs.append(GameState.generate_next_of_kin_build())

func _ready():
	_generate_possible_heirs()
	_show_heirs()

func _show_heirs():
	char1.get_node("Sprite").scale = heirs[0]["build"]["scale"]
	char2.get_node("Sprite").scale = heirs[1]["build"]["scale"]
	char3.get_node("Sprite").scale = heirs[2]["build"]["scale"]
	
	char1.get_node("Label").text = heirs[0]["character_name"] + " \n " + _weapon_name(heirs[0])
	char2.get_node("Label").text = heirs[1]["character_name"] + " \n " + _weapon_name(heirs[1])
	char3.get_node("Label").text = heirs[2]["character_name"] + " \n " + _weapon_name(heirs[2])

func _weapon_name(heir: Dictionary):
	return heir["weapon"].right(6).substr(0, len(heir["weapon"].right(6))-5)


func _on_ButtonChose1_pressed():
	GameState.build = heirs[0]
	GameState.restart_game()
	get_tree().change_scene("res://src/scenes/Game.tscn")


func _on_ButtonChose2_pressed():
	GameState.build = heirs[1]
	GameState.restart_game()
	get_tree().change_scene("res://src/scenes/Game.tscn")


func _on_ButtonChose3_pressed():
	GameState.build = heirs[2]
	GameState.restart_game()
	get_tree().change_scene("res://src/scenes/Game.tscn")
