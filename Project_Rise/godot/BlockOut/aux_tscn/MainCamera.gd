extends Camera2D


export var Is_on_character : bool

onready var topLeft = $Limits/TopLeft
onready var bottomRight = $Limits/BottomRight
onready var character


func _ready():
	if get_parent().name == "Player":
		character = get_parent()
	else:
		print_debug("Camera error! Can't find a \"Player\" node")
	self.position = character.position


#func _physics_process(delta):
#	self.position = character.position
