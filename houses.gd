extends Node2D

@onready var spr = $Sprite
@onready var ani = $AnimationPlayer
@onready var per = $"../Pers"
var isOpened = false



    


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if Input.is_action_just_released("ui_use") && (global_position.distance_to(per.global_position)) < 100:
        if isOpened == false:
            open()
        else:
            close()
        
   
  
        
    
func open():
    isOpened = true
    spr.frame = 6
    
func close():
    isOpened = false
    spr.frame = 1
