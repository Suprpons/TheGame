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
    
    %QuestStep.step_name = step["details"]
    %QuestStep.collected = 0
    %QuestStep.total_required = 5
    %QuestStep.render()

    
