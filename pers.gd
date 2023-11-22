extends CharacterBody2D

@onready var ap = $AnimationPlayer
@onready var sp = $Sprite2D

var speed = 100  # speed in pixels/sec
var health := 100

signal health_changed
signal kryak

var timer : Timer
var modc : Color


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # Need to be called to use the HealthBar2D
    $HealthBar2D.initialize("health_changed", 100)
    emit_signal("health_changed", health)
    

func flash():
    hp_change(-10)
    if sp.modulate == Color.RED:
      sp.modulate = Color.WHITE
    else:
      sp.modulate = Color.RED

func hp_change(howmuch = 10):
    health = health + howmuch
    
    if health <= 0:
      emit_signal("kryak")
    if health > 100:
      health = 100
      
    print("health", health)
    emit_signal("health_changed", health)

func _physics_process(_delta):
  rotation += 20

  var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
  velocity = direction * speed
  var x = direction.x
  var y = direction.y
  if direction.x > 0:
    sp.flip_h = false
    ap.play("right")
  if direction.x < 0:
    sp.flip_h = true
    ap.play("right")
  if direction.y > 0:
    ap.play("down")
  if direction.y < 0:
    ap.play("up")
  if direction.x == 0 and direction.y == 0:
    ap.play("stand")
    
    
    
    
    
    
    
    
    
    
    
  if Input.is_action_just_released("ui_accept"):
    DialogueManager.show_example_dialogue_balloon(load("res://simple_dialog.dialogue"))
  move_and_slide();
