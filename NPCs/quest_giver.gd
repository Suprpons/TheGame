extends Node2D

@export var dialogue_path: String
@export var distance: int = 20

func _ready():
  pass

func _process(delta):
    if Input.is_action_just_released("ui_use"):
        if not GameState.dialogue_active:
            if global_position.distance_to(GameState.player.global_position) < distance:
                GameState.dialogue_open(dialogue_path)
