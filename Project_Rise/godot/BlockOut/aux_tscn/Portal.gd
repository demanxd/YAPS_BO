tool
extends KinematicBody2D

export var In : bool
export var debug = true
export var location_self : Vector2
export var location_target : Vector2
export var color_shade : Color
export var base_color : Vector3

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#$Sprite.modulate redrawing pixels on picked color
func _ready():
	$Sprite_Out.hide()
	$Sprite_In.hide()
	
	if !debug:
		if In:
			$Sprite_In.show()
			color_shade = Color(base_color.x,base_color.y,base_color.z)
			$Sprite_In.modulate = color_shade
		else:
			$Sprite_Out.show()
			$Sprite_Out.modulate = color_shade


func _process(delta: float) -> void:
	location_self = Vector2(self.position.x, self.position.y) 
	if debug:
		if In:
			$Sprite_Out.hide()
			$Sprite_In.show()
			color_shade = Color(base_color.x,base_color.y,base_color.z)
			$Sprite_In.modulate = color_shade
		else:
			$Sprite_In.hide()
			$Sprite_Out.show()
			$Sprite_Out.modulate = color_shade
			base_color.x = color_shade.r
			base_color.y = color_shade.g
			base_color.z = color_shade.b




#func _on_Area2D_area_entered(area):
#


func _on_Area2D_body_entered(body):
	if (body.name == "Player") and In:
		body.immediatly_move(location_target)
