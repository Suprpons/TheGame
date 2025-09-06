extends Panel

const INCREMENTAL_STEP = "incremental_step"
const ITEMS_STEP = "items_step"
const END = "end"

func render(step):
    print("QuestStep.render ", step)
    var total_required: int
    var collected: int
    
    match step.step_type:
        INCREMENTAL_STEP:
            total_required = step.required
            collected = step.collected
        ITEMS_STEP:
            total_required = step.item_list.size()
            collected = step.item_list.filter(func (item): return item.complete).size()
        END:
            total_required = 1
            collected = 1

    var text = step.details if total_required == 1 else "%s [color=green]%s[/color]/%s" % [step.details, collected, total_required]
    var is_finished = collected == total_required
    %StepTextLabel.text = text
    $HBoxContainer/FontAwesome.visible = is_finished
