extends CharacterBody2D

@onready var ap = $AnimationPlayer
@onready var sp = $"Screenshot2023-10-1719111473"


@export var speed = 100  # speed in pixels/sec
@export var follow: Node2D

var lastPos = Vector2.ZERO

func _ready():
  pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
  position = lerp(position, follow.global_position, 0.02)
  var direction = position - lastPos

  anim(direction)
  lastPos = position
  move_and_slide()

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
