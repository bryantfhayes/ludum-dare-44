extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_playBtn_pressed():
	var retval = get_tree().change_scene("res://scenes/TheTown.tscn")
	print(retval)