extends CharacterBody2D


var speed = 100  # speed in pixels/sec
@onready var ap = $"../AnimationPlayer"
@onready var sp = $"Screenshot2023-10-1719111473"
@onready var vr = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

var lastPos = Vector2.ZERO

func _physics_process(_delta):
  var direction = position - lastPos
  velocity = direction * speed
  var x = direction.x
  var y = direction.y
  if direction.x > 0:
    sp.flip_h = false
    ap.play("vrag vprava")
  if direction.x < 0:
    sp.flip_h = true
    ap.play("vrag vprava")
  if direction.y > 0:
    ap.play("vrag forward")
  if direction.y < 0:
    ap.play("vrag nazad")
  lastPos = position
  move_and_slide();
