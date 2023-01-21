extends Control

onready var LblCoinsCollected = get_node("ChestCoins/Label")
onready var BuyManaButton = get_node("BuyMana")
onready var BuyHealthButton = get_node("BuyHealth")

var health_upgrade_value = 350
var mana_upgrade_value = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	update_treasury()
	activate_buttons()


func _process(_delta):
	update_treasury()
	activate_buttons()

func update_treasury():
	LblCoinsCollected.text = str(GameState.treasure)

func activate_buttons():
	if GameState.treasure >= health_upgrade_value && !GameState.health_drops:
		BuyHealthButton.disabled = false
		
	if GameState.treasure >= mana_upgrade_value && !GameState.large_mana:
		BuyManaButton.disabled = false


func _on_BackButton_pressed():
	get_tree().change_scene("res://src/scenes/GameOver.tscn")


func _on_BuyHealth_pressed():
	GameState.health_drops = true
	GameState.treasure -= health_upgrade_value
	BuyHealthButton.disabled = true


func _on_BuyMana_pressed():
	GameState.large_mana = true
	GameState.treasure -= mana_upgrade_value
	BuyManaButton.disabled = true
