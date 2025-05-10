class_name Utils
extends Node

func wait(number: float):
  return get_tree().create_timer(number).timeout
