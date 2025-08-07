extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

enum QuestState {
    questing,
    quest_done
}

var queststate = QuestState.questing 
func happy():
  queststate = QuestState.quest_done





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  if queststate == QuestState.questing:
    $"../AnimationPlayer".play("questing")
  else:
    $"../AnimationPlayer".play("quest_done")
