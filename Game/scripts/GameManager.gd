extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal regen_blood(amount)

# Blood drain in mL every second
var bloodRegenMlPerSecond = 100
var timeSinceLastRegen = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	start_music()
	set_process(true)
	pass # Replace with function body.

func start_music():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://assets/veins_of_gold_bg.ogg")
	player.volume_db = -25.0
	player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeSinceLastRegen = timeSinceLastRegen + delta
	if timeSinceLastRegen >= 1.0:
		emit_signal("regen_blood", bloodRegenMlPerSecond)
		timeSinceLastRegen = 0
	pass
