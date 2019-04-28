extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var attachedBody = null
var bloodAmount = 100
var goldPerDonation = 1.7

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	var text = "Press 'e' to sell %d ml of blood\nfor $%.2f"
	get_node("InteractLbl").text = text % [bloodAmount, goldPerDonation]
	get_node("InteractLbl").visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attachedBody != null:
		
		if Input.is_action_just_pressed("ui_interact"):
			var node = self.owner
			var player_node = node.get_node("Player")
			$BloodSound.play()
			player_node.get_node("Health").take_damage(bloodAmount)
			player_node.get_node("Purse").add_gold(goldPerDonation)

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		attachedBody = body
		get_node("InteractLbl").visible = true

func _on_Area2D_body_exited(body):
	attachedBody = null
	get_node("InteractLbl").visible = false
