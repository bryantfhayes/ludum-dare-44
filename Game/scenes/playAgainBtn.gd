extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_playAgainBtn_pressed():
	var retval = get_tree().change_scene("res://scenes/TheTown.tscn")
	print(retval)