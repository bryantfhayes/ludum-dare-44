extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var attachedBody = null
var offset = Vector2(10.0, -25.0)
var bloodAmount = 300
var goldPerDonation = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	var text = "Press 'e' to sell %d ml of blood\nfor %d gold"
	get_node("InteractLbl").text = text % [bloodAmount, goldPerDonation]
	get_node("InteractLbl").visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attachedBody != null:
		
		if Input.is_action_just_pressed("ui_interact"):
			print("INTERACTED WITH BLOODBANK")
			var node = self.owner
			var player_node = node.get_node("Player")
			var health_node = player_node.get_node("Health")
			
			if health_node.health - bloodAmount >= 0:
				player_node.get_node("Health").take_damage(bloodAmount)
				player_node.get_node("Purse").add_gold(goldPerDonation)

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		print("ENTER")
		attachedBody = body
		get_node("InteractLbl").visible = true

func _on_Area2D_body_exited(body):
	attachedBody = null
	get_node("InteractLbl").visible = false
