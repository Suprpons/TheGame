extends Node

@export var grid_inventory: GridInventory

@onready var ui: GridInventoryUI = %GridInventoryUI

func _ready() -> void:
    ui.inventory = grid_inventory
