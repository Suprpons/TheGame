extends Sprite2D

@export var inventory_item_id: String
@export var distance: int = 20

func _ready():
  pass

func _process(_delta):
  if Input.is_action_just_released("ui_use"):
    if global_position.distance_to(GameState.player.global_position) < distance:
        GameState.pick_item(inventory_item_id)
        self.queue_free()
