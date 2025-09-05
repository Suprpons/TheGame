extends Panel

@export var step_name: String
@export var collected: int
@export var total_required: int



func collect():
    collected += 1
    render()
#func add_items_step(step_details:String, items:PackedStringArray,step_meta_data:Dictionary={}) -> void:
    #var step_data = {}
    #step_data["id"] = get_random_id()
    #step_data["next_id"] = ""
    #step_data["step_type"] = "items_step"
    #step_data["details"]= step_details
    #var arr = []
    #for item in items:
        #arr.append({
        #"name" : item,
        #"complete" : false
        #})
    #step_data["item_list"]= arr
    #step_data["complete"] = false
    #step_data["meta_data"]= step_meta_data
    #add_step(step_data)    
func render():
    var text = step_name if total_required == 1 else "%s [color=green]%s[/color]/%s" % [step_name, collected, total_required]
    var is_finished = collected == total_required
    %StepTextLabel.text = text
    $HBoxContainer/FontAwesome.visible = is_finished
