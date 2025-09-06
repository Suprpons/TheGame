extends Node

@onready var world = $"/root/World"
@onready var player: Node2D = $"/root/World/Pers"
@onready var inv = $"/root/World/Pers/GridInventory"

var dialogue_active = false
var choseLife = null
signal chooseLifeSignal

# Called when the node enters the scene tree for the first time.
func _ready():
  chooseLifeSignal.connect(chooseLifeHandler)
#signal quest_completed(quest_name)
#signal quest_failed(quest_name)
#signal step_complete(quest_name)
#signal step_updated(quest_name)
#signal new_quest_added(quest_name)
#signal quest_reset(quest_name)
  DialogueManager.dialogue_ended.connect(dialogue_close)
  QuestManager.step_complete.connect(_on_step_complete)
  QuestManager.quest_completed.connect(_on_quest_complete)


func _on_quest_complete(quest_name, rewards):
    print("quest complete", quest_name, "rewards", rewards)
    for key in rewards.keys():
        inv.add(key, rewards[key])

func chooseLifeHandler():
  if choseLife == true:
    print("live")
  else:
    print("dead")
    world.gameover()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass

func _on_step_complete(step, quest_name):
    print("GameState._on_step_complete", step)
    
func accept_quest(resource_name: String, quest_name: String):
    var resource_path = "res://quests/%s.quest" % resource_name
    assert(ResourceLoader.exists(resource_path), "нет такого ресурса %s" % resource_path)
        
    var resource: QuestResource = ResourceLoader.load(resource_path)
    QuestManager.load_quest_resource(resource)
    QuestManager.add_quest(quest_name)
    
func dialogue_close(_resource):
  await util.wait(0.3)
  if dialogue_active:
    dialogue_active = false

func dialogue_open(dialogue_path: String):
    DialogueManager.show_example_dialogue_balloon(load(dialogue_path))
    dialogue_active = true

func pick_item(item_id: String):
    # check quests needs item
    print("pick_item ", item_id)
    var is_consumed = false
    for quest_name in QuestManager.get_all_player_quests_names():
        var is_consumed_in_quest = QuestManager.progress_quest(quest_name, item_id)
        if is_consumed_in_quest:
            is_consumed = true
            break
    if not is_consumed:
        print("inv.add ", item_id)
        inv.add(item_id)

func game_event(action: String):
    for quest_name in QuestManager.get_all_player_quests_names():
        QuestManager.progress_quest(quest_name, action)
