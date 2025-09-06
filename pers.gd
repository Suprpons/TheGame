extends CharacterBody2D

@onready var ap = $AnimationPlayer
@onready var sp = $Sprite2D

#var dialogue_active = false
var speed = 100  # speed in pixels/sec
var health := 100
const MAX_HEALTH := 100

signal health_changed
signal kryak
signal damage(how_much)


var timer : Timer
var modc : Color

func hit_particles():
  $GPUParticles2D.show()
  await util.wait(1)
  $GPUParticles2D.hide()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # Need to be called to use the HealthBar2D
    $HealthBar2D.initialize("health_changed", health)
    health_changed.emit(health)
    damage.connect(on_damage)
    $GridInventoryPanel.request_transfer_to.connect(transfer_to)

#signal request_transfer_to(origin_inventory: GridInventory, origin_position: Vector2i, inventory: GridInventory, destination_position : Vector2i, amount : int, is_rotated: bool)
func transfer_to(inventory: GridInventory, origin_pos: Vector2i, destination: GridInventory, destination_pos: Vector2i, amount: int, is_rotated: bool):
    inventory.transfer_to(origin_pos, destination, destination_pos, amount, is_rotated)

func on_damage(how_much):
    print("pers.on_damage", how_much)
    hp_change(how_much)
    hit_particles()
    
    
func flash():
    hp_change(-10)
    if sp.modulate == Color.RED:
      sp.modulate = Color.WHITE
    else:
      sp.modulate = Color.RED

func hp_change(howmuch = 10):
    health = health + howmuch
    
    if health <= 0:
      kryak.emit()
    if health > MAX_HEALTH:
      health = MAX_HEALTH
      
    print("pers.health: ", health)
    health_changed.emit(health)

func _physics_process(_delta):
  if Input.is_action_just_pressed("ui_attack"):
    pass
  var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
  velocity = direction * speed

  if not GameState.dialogue_active:
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
    move_and_slide()
  if direction.x == 0 and direction.y == 0:
    ap.play("stand")

  if Input.is_action_just_released("test_action"):
    #var current_quest = "find da sord"
    var current_quest = "get da key"
    GameState.accept_quest("first_steps", current_quest)
