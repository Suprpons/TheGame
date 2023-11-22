extends Node

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




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  pass
