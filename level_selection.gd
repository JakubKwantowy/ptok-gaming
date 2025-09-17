extends Button

func _ready() -> void:
	self.pressed.connect(_button_pressed)
	
func _button_pressed():
	get_parent().visible = false
	get_node("/root/Node2D/LevelSelection").visible = true
	
