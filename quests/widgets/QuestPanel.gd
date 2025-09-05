class_name QuestPanel
extends Panel

var quest: Dictionary = {
    quest_name = "default quest name",
    quest_details = "default quest details"
}
var step: Dictionary = {
    details = "default step details",
    required = 1
}

func _ready():
    var quest_name_label = $VBoxContainer/QuestNameLabel
    quest_name_label.text = quest["quest_name"]
    %QuestDescriptionLabel.text = quest["quest_details"]
    print("step in QuestPanel", step)
    %QuestStep.step_name = step["details"]
    %QuestStep.collected = 0
    %QuestStep.total_required = step["required"]
    %QuestStep.render()
    
    QuestManager.step_complete.connect(_on_step_complete)
    QuestManager.quest_completed.connect(_on_quest_complete)


func _on_step_complete(step):
    print("step complete in w", step)
    %QuestStep.collect()

func _on_quest_complete(quest_name, rewards):
    print("quest complete in w", quest_name, "rewards", rewards)
    var quest_name_label = $VBoxContainer/QuestNameLabel
    quest_name_label.text = "[color=green]%s[/color]" % [quest_name_label.text]
