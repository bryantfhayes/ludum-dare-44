extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_howtoBtn_pressed():
	var retval = get_tree().change_scene("res://scenes/HowTo.tscn")
	print(retval)
