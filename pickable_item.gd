extends Sprite2D

@export var inventory_name: String
@export var player: Node2D
@export var distance: int = 20

func _ready():
  pass

func _process(delta):
  if global_position.distance_to(player.global_position) < distance:
    player.inv.create_and_add_item(inventory_name)
    self.queue_free()
    
