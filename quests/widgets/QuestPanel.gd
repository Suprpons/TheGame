class_name QuestPanel
extends Panel

var quest: Dictionary = {
    quest_name = "default quest name",
    quest_details = "default quest details"
}
var step: Dictionary = {
    details = "default step details"
}

func _ready():
    var quest_name_label = $VBoxContainer/QuestNameLabel
    quest_name_label.text = quest["quest_name"]
    %QuestDescriptionLabel.text = quest["quest_details"]
    
    QuestManager.step_complete.connect(_on_step_complete)
    QuestManager.step_updated.connect(_on_step_updated)

    QuestManager.quest_completed.connect(_on_quest_complete)
    
    print("step in QuestPanel", step)
    %QuestStep.render(step)


func _on_step_complete(step, quest_name):
    if quest_name != quest.quest_name:
        return
    print("QuestPanel._on_step_complete ", step)
    %QuestStep.render(step)
    
func _on_step_updated(step, quest_name):
    if quest_name != quest.quest_name:
        return
    print("QuestPanel._on_step_updated ", step)
    %QuestStep.render(step)

func _on_quest_complete(quest_name, rewards):
    if quest_name != quest.quest_name:
        return
    print("QuestPanel._on_quest_complete ", quest_name, "rewards", rewards)
    var quest_name_label = $VBoxContainer/QuestNameLabel
    quest_name_label.text = "[color=green]%s[/color]" % [quest_name_label.text]
    await util.wait(8)
    self.queue_free()
