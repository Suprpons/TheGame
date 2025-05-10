extends Panel

@export var step_name: String
@export var collected: int
@export var total_required: int



func collect():
    collected += 1
    render()
    
func render():
    var text = step_name if total_required == 1 else "%s [color=green]%s[/color]/%s" % [step_name, collected, total_required]
    var is_finished = collected == total_required
    %StepTextLabel.text = text
    %CheckBox.toggled = is_finished
