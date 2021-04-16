class_name NPC
extends Walker


export var root : = NodePath()


func _extends_phys_process():
	if debug:
		print(self.name + ": extends phys process NPC")

func _extends_left_trig_process():
	if debug:
		print(self.name + ": left_trigger pricessing (<-)")
		end_lvl()

func _extends_right_trig_process():
	if debug:
		print(self.name + ": right_trigger processing (->)")
		end_lvl()


func end_lvl():
	get_tree().change_scene("res://tscn_folders/GUI.tscn")
	pass
