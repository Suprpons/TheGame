extends CharacterBody2D


var speed = 100  # speed in pixels/sec
@onready var ap = $AnimationPlayer
@onready var sp = $Sprite2D
var health := 10
@export var vr: Node2D
signal health_changed

var timer : Timer
var modc : Color


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # Need to be called to use the HealthBar2D
    $HealthBar2D.initialize("health_changed", 100)
    
    timer = Timer.new()
    add_child(timer)
    timer.timeout.connect(flash)
    timer.wait_time = 2
    timer.start()

func flash():
    hp_change()
    if sp.modulate == Color.RED:
      sp.modulate = Color.WHITE
    else:
      sp.modulate = Color.RED

func hp_change():
    health = health + 10
    print("health", health)
    emit_signal("health_changed", health)

func _physics_process(_delta):
#  if abs(vr.position.distance_to(global_position)) < 10:
#    hp_change()  
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
  move_and_slide();
