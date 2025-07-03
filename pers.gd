extends CharacterBody2D

@onready var ap = $AnimationPlayer
@onready var sp = $Sprite2D
@onready var inv = $GridInventory

var dialogue_active = false
var speed = 100  # speed in pixels/sec
var health := 100
var current_quest : String = ''

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
    $HealthBar2D.initialize("health_changed", 100)
    emit_signal("health_changed", health)
    damage.connect(on_damage)
    DialogueManager.dialogue_ended.connect(dialogue_close)
    QuestManager.quest_completed.connect(_on_quest_complete)

func _on_quest_complete(quest_name, rewards):
    print("quest complete in pers", quest_name, "rewards", rewards)
    for key in rewards.keys():
        inv.add(key, rewards[key])

func dialogue_close(resource):
  await util.wait(0.3)
  print('hateuworks')
  if dialogue_active == true:
    dialogue_active = false
  

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
      emit_signal("kryak")
    if health > 100:
      health = 100
      
    print("pers.health: ", health)
    emit_signal("health_changed", health)

func _physics_process(_delta):
  if Input.is_action_just_pressed("ui_attack"):
    pass
  var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
  velocity = direction * speed
  var x = direction.x
  var y = direction.y
  if dialogue_active == false:
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

  if Input.is_action_just_released("ui_accept") && dialogue_active == false:
    DialogueManager.show_example_dialogue_balloon(load("res://simple_dialog.dialogue"))
    dialogue_active = true
  if Input.is_action_just_released("ui_accept") && dialogue_active == true:
#    DialogueManager.get_next_dialogue_line(load("res://simple_dialog.dialogue"))
    print(dialogue_active)
#  if DialogueManager.dialogue_ended:
#    dialogue_close()
  if Input.is_action_just_released("test_action"):
    #current_quest = "find da sord"
    current_quest = "get da key"
    GameState.accept_quest("first_steps", current_quest)

func pick(item_id: String):
    # check quests needs item
    QuestManager.progress_quest(current_quest, item_id)
    game_action("now you need a shield")
    inv.add(item_id)

func game_action(action: String):
    QuestManager.progress_quest(current_quest, action)
