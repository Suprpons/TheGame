extends Node

@onready var world = $"/root/World"

var choseLife = null
signal chooseLifeSignal

# Called when the node enters the scene tree for the first time.
func _ready():
  chooseLifeSignal.connect(chooseLifeHandler)

func chooseLifeHandler():
  if choseLife == true:
    print("live")
  else:
    print("dead")
    world.gameover()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  if Input.is_action_just_released("test_action"):
    accept_quest("first_steps", "find da sord")


func accept_quest(resource_name: String, quest_name: String):
    var resource_path = "res://quests/%s.quest" % resource_name
    assert(ResourceLoader.exists(resource_path), "нет такого ресурса %s" % resource_path)
        
    var resource: QuestResource = ResourceLoader.load(resource_path)
    QuestManager.load_quest_resource(resource)
    QuestManager.add_quest(quest_name)
    
