extends Node2D

@onready var inventory_widget = $Pers/GridInventoryPanel

# Called when the node enters the scene tree for the first time.
func _ready():
    $Pers.kryak.connect(gameover)

func gameover():
    $GameOverText.visible = true
    await get_tree().create_timer(3).timeout
    get_tree().reload_current_scene()

@warning_ignore("unused_parameter")
func _process(delta):
    if Input.is_action_just_released("ui_inventory"):
         inventory_widget.visible = !inventory_widget.visible
