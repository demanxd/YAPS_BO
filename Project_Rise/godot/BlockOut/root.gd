extends Node

onready var tavern
onready var GUI
onready var test_room

# Called when the node enters the scene tree for the first time.
func _ready():
	tavern = get_node("Tavern")
	GUI = get_node("GUI")
	test_room = get_node("res://aux_tscn/Empty_scene.tscn")


func start_game():
	
	pass
