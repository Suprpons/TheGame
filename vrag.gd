extends CharacterBody2D


var speed = 100  # speed in pixels/sec
@onready var ap = $"../AnimationPlayer"
@onready var sp = $"Screenshot2023-10-1719111473"
@onready var vr = $".."


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

var lastPos = Vector2.ZERO
var Vect1 = Vector2.ONE
func anim(direction):
  var x = direction.x
  var y = direction.y
  
  var ax = abs(x)
  var ay = abs(y)
  
  if y > 0 && ax < ay:
    ap.play("vrag forward")
  if y < 0 && ax < ay:
    ap.play("vrag nazad")
  if x > 0 && ay < ax:
    sp.flip_h = false
    ap.play("vrag vprava")
  if x < 0 && ay < ax:
    sp.flip_h = true
    ap.play("vrag vprava")
  if x == 0 && y == 0:
    ap.play("vrag stand")

func _physics_process(_delta):
  var direction = vr.position - lastPos
  #print(direction, vr.position)
  var x = direction.x
  var y = direction.y
  anim(direction)
  lastPos = vr.position
  move_and_slide();
