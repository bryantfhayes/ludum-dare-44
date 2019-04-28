extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var node
var player_node
var health_node
var max_health
var opacity_thresh_hold = 0.15
var opacity_percent = 0
var opacity_multiplier = 0.001

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Health_health_changed(health):
	node = self.owner
	player_node = node.get_node("Player")
	health_node = player_node.get_node("Health")
	max_health = health_node.max_health
	var opacity_threshold = max_health * opacity_thresh_hold
	if health_node.health < opacity_threshold:
		self.modulate.a = (opacity_threshold - health_node.health) * opacity_multiplier
		if health_node.health <= 0:
			$DeathSound.play()
			get_tree().change_scene("res://scenes/GameOver.tscn")
			
	
	pass # Replace with function body.
