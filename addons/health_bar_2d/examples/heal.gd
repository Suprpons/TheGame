extends Area2D


@export var heal_power := 10
func wth():
     print('what the hell');


func _ready() -> void:
    connect("body_entered", _heal);


func _heal(body: Node) -> void:
    if body.name == "Player":
        body.health + heal_power
        body.emit_signal("health_changed", body.health);
    else: wth()
    
