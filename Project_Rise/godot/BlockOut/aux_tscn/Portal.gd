tool
extends KinematicBody2D

export var color_shade : Color
export var In : bool
export var location_self : Vector2
export var location_target : Vector2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#$Sprite.modulate redrawing pixels on picked color
func _ready():
	if In:
		$Sprite_Out.hide()
		$Sprite_In.modulate = color_shade
	else:
		$Sprite_In.hide()
		$Sprite_Out.modulate = color_shade
	pass # Replace with function body.


func _process(delta: float) -> void:
	location_self = Vector2(self.position.x, self.position.y) 
#	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
