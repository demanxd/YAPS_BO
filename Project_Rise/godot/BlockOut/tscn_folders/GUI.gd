extends Node2D


onready var root
onready var lineEdit = $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_parent()
	pass # Replace with function body.


func _on_Button_button_down():
#	root.start_game()
	var num = lineEdit.text.to_int()
	if num == 0:
		get_tree().change_scene("res://tscn_folders/Tavern.tscn")
	if num == 1:
		get_tree().change_scene("res://aux_tscn/Empty_scene.tscn")
	else:
		print("Wrong number!")
