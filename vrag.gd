extends CharacterBody2D


var speed = 100  # speed in pixels/sec
@onready var ap = $"../AnimationPlayer"
@onready var sp = $"Screenshot2023-10-1719111473"
@onready var vr = $".."
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


var timer: Timer
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
  if vr.position.distance_to(vr.per.position) < 10:
    emit_signal("hit")
    vr.per.hp_change()
    timer = Timer.new()
    add_child(timer)
    timer.timeout.connect(vr.per.flash)
    timer.wait_time = 2
    timer.start()
  var speed = 0.02 # put wanted speed here
  vr.position = lerp(vr.position,vr.per.global_position,speed)
  $".".rotation += 1
  var direction = vr.position - lastPos
  #print(direction, vr.position)
  var x = direction.x
  var y = direction.y
  anim(direction)
  lastPos = vr.position
  move_and_slide();
