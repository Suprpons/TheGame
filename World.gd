extends Node2D

@onready var key = $Key
@onready var per = $Pers
@onready var inv: Inventory = $Inventory
@onready var cinv = $Pers/CtrlInventory
@onready var HPotion = $Healpotion
@onready var HPotions = $NewSprite68
@onready var sword = $NewSprite321
@onready var vr = $vrag

# Called when the node enters the scene tree for the first time.
func _ready():
    per.kryak.connect(gameover)

func gameover():
    $RichTextLabel.visible = true
    await get_tree().create_timer(3).timeout
    get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
    #print(per.health)
#    look_at(per.global_position)
    if Input.is_action_just_released("ui_inventory"):
         cinv.visible = !cinv.visible
    if Input.is_action_just_released("ui_use"): 
        if !!key:
            if (key.global_position.distance_to(per.global_position)) < 50:
              inv.create_and_add_item("key")
              key.queue_free()
        if !!HPotion:
            if (HPotion.global_position.distance_to(per.global_position)) < 50:
              inv.create_and_add_item("HPotion")
              HPotion.queue_free()
       
        if !!HPotions:
            if (HPotions.global_position.distance_to(per.global_position)) < 50:
              inv.create_and_add_item("HPotions")
              HPotions.queue_free()
            
        if !!sword:
            if (sword.global_position.distance_to(per.global_position)) < 50:
              inv.create_and_add_item("sword")
              sword.queue_free()
           
        
