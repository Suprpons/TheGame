class_name QuestsPanel
extends Panel

@onready var container = $VBoxContainer/MarginContainer

func _ready():
    QuestManager.new_quest_added.connect(_on_quest_added)

#func add_quest():
    #var QuestPanelScene = load("res://quests/widgets/quest_panel.tscn")
    #var quest_panel = QuestPanelScene.instantiate()    
    #container.add_child(quest_panel)
    #
#func remove_quest():
    #pass

func _on_quest_added(quest_name):
    print("quests panel, _on_quest_added called ", quest_name)
    var QuestPanelScene = load("res://quests/widgets/QuestPanel.tscn")
    var quest = QuestManager.get_player_quest(quest_name)
    var current_step = QuestManager.get_current_step(quest_name)
    
    var quest_panel: QuestPanel = QuestPanelScene.instantiate()
    quest_panel.quest = quest
    quest_panel.step = current_step
    var container = $VBoxContainer/MarginContainer
    container.add_child(quest_panel)
    print("added quest")
    
