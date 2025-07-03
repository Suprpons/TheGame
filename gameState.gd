extends Node

@onready var world = $"/root/World"

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
  QuestManager.step_complete.connect(_on_step_complete)
  QuestManager.quest_completed.connect(_on_quest_complete)

func chooseLifeHandler():
  if choseLife == true:
    print("live")
  else:
    print("dead")
    world.gameover()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _on_quest_complete(quest_name):
    print("quest complete", quest_name)

func _on_step_complete(step):
    print("step complete", step)
    
func accept_quest(resource_name: String, quest_name: String):
    var resource_path = "res://quests/%s.quest" % resource_name
    assert(ResourceLoader.exists(resource_path), "нет такого ресурса %s" % resource_path)
        
    var resource: QuestResource = ResourceLoader.load(resource_path)
    QuestManager.load_quest_resource(resource)
    QuestManager.add_quest(quest_name)
    
