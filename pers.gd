extends CharacterBody2D


var speed = 100  # speed in pixels/sec
@onready var ap = $AnimationPlayer
@onready var sp = $Sprite2D
@onready var att = $"../AudioStreamPlayer"


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.



func _physics_process(delta):
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
  if x == 0 and y == 0:
    ap.play("stand")
  move_and_slide();
