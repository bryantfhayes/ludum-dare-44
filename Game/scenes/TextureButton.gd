extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_playBtn_pressed():
	get_tree().change_scene("res://scenes/TheTown.tscn")
