extends Sprite2D

@export var inventory_item_id: String
@export var player: Node2D
@export var distance: int = 20

func _ready():
  pass

func _process(delta):
  if Input.is_action_just_released("ui_use"):
    if global_position.distance_to(player.global_position) < distance:
        player.pick(inventory_item_id)
        self.queue_free()
