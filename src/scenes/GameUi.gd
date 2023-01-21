extends CanvasLayer

onready var heart_sprite = get_node("UiHeartFull")

func _ready():
	if GameState.active_curse:
		heart_sprite.self_modulate = Color.greenyellow
