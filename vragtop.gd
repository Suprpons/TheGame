extends CharacterBody2D


var speed = 100  # speed in pixels/sec
var last_hit: int  # time when last hit


@onready var ap = $AnimationPlayer
@onready var sp = $"Screenshot2023-10-1719111473"
@export var per: Node2D


signal hit



# Called when the node enters the scene tree for the first time.
func _ready():
  last_hit = Time.get_ticks_msec()


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
    
func check_hit(time_delta = 1000):
    var now = Time.get_ticks_msec()
    var res = now - last_hit > time_delta
    if res:
        last_hit = now
    return res
      

func _physics_process(_delta):
  #if position.distance_to(per.position) < 10:
    #if check_hit():
      #per.hp_change(-10)
      #emit_signal("hit")
  var speed = 0.02 # put wanted speed here
  if position.distance_to(per.global_position) > 32: 
    position = lerp(position, per.global_position, speed)
    
  var direction = position - lastPos
  #print(direction, vr.position)
  var x = direction.x
  var y = direction.y
  anim(direction)
  lastPos = position
  move_and_slide();
