extends Node2D


onready var root

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_parent()
	pass # Replace with function body.


func _on_Button_button_down():
#	root.start_game()
	get_tree().change_scene("res://tscn_folders/Tavern.tscn")
	pass # Replace with function body.
