extends Node2D


onready var root
onready var lineEdit = $LineEdit

enum lvls {TEST_LVL, FIRST_LVL}



# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_parent()
	pass # Replace with function body.


func _on_Button_button_down():
#	root.start_game()
	var num = lineEdit.text
	if num == String(lvls.FIRST_LVL):
		get_tree().change_scene("res://tscn_folders/Tavern.tscn")
	if num == String(lvls.TEST_LVL):
		get_tree().change_scene("res://aux_tscn/Empty_scene.tscn")
	else:
		print("Wrong input! You can input only " + String(lvls) + " lvl's")
