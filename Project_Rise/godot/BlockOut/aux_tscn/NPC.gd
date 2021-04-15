class_name NPC
extends Walker



func _extends_phys_process():
	if debug:
		print(self.name + ": extends phys process NPC")

func _extends_left_trig_process():
	if debug:
		print(self.name + ": left_trigger pricessing (<-)")

func _extends_right_trig_process():
	if debug:
		print(self.name + ": right_trigger processing (->)")


func end_lvl():
	
	pass
