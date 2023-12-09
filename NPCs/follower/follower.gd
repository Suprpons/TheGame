extends CharacterBody2D


# exports
@export_group("follower")
@export var target: Node2D
@export var speed = 40  # speed in pixels/sec
@export var hit_cooldown = 1000
@export var texture: Texture2D
@export var is_fighter: bool = false

# private vars
var last_hit: int  # time when last hit
var last_position = Vector2.ZERO

# requires loading
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D

# signals
signal hit

# definitions
const animations = {
    stand = "animation_lib_1/stand_down",
    right = "animation_lib_1/walk_right",
    left = "animation_lib_1/walk_right",
    up = "animation_lib_1/walk_up",
    down = "animation_lib_1/walk_down"
}

enum FollowingState {following, reached}
var following_state = FollowingState.following

enum FightingState {fighting, calm}
var fighting_state = FightingState.calm

func _ready():
    last_hit = Time.get_ticks_msec()
    if texture:
        sprite.texture = texture


func animate():
  var x = velocity.x
  var y = velocity.y
  
  var ax = abs(x)
  var ay = abs(y)
  
  if y > 0 && ax < ay:
      animation_player.play(animations.down)
  if y < 0 && ax < ay:
      animation_player.play(animations.up)
  if x > 0 && ay < ax:
      sprite.flip_h = false
      animation_player.play(animations.right)
  if x < 0 && ay < ax:
      sprite.flip_h = true
      animation_player.play(animations.right)
  if x == 0 && y == 0:
      animation_player.play(animations.stand)
    
func can_hit():
    var now = Time.get_ticks_msec()
    var res = now - last_hit > hit_cooldown
    if res:
        last_hit = now
    return res

func follow():
    if following_state == FollowingState.following:
        velocity = position.direction_to(target.position) * speed
    else:
        velocity = Vector2.ZERO
    
func fight():
    if fighting_state == FightingState.fighting:
        if can_hit():
            print("hit")
            if !target.damage.is_null():
                target.damage.emit(-10)
              
    if fighting_state == FightingState.fighting:
        pass
  
    
func _physics_process(_delta):
    follow()
    fight()
    animate()
    last_position = position
    move_and_slide()


func _on_stop_area_body_entered(body):
    print("reached")
    following_state = FollowingState.reached


func _on_stop_area_body_exited(body):
    print("following")
    following_state = FollowingState.following


func _on_hit_area_body_entered(body):
    if is_fighter:
        print("fighting")
        fighting_state = FightingState.fighting

func _on_hit_area_body_exited(body):
    print("calm")
    fighting_state = FightingState.calm
