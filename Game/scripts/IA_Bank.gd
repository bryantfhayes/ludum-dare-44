extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var attachedBody = null
var offset = Vector2(10.0, -25.0)
var interest_gain = 0.01
var interest_upgrade = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	var text = "Press 'e' to increase interest \n rate (%.3f for %d gold coins)"
	get_node("InteractLbl").text = text % [interest_gain, interest_upgrade]
	get_node("InteractLbl").visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attachedBody != null:
		var node = self.owner
		var player_node = node.get_node("Player")
		var purse_node = player_node.get_node("Purse")
		if Input.is_action_just_pressed("ui_interact"):
			if purse_node.gold - interest_upgrade >= 0:
				$CashRegisterSound.play()
				purse_node.remove_gold(interest_upgrade)
				purse_node.interest_rate += interest_gain
				interest_upgrade = interest_upgrade * 2
				
				var text = "Press 'e' to increase interest \n rate (%.3f for %d gold coins)"
				get_node("InteractLbl").text = text % [interest_gain, interest_upgrade]

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		attachedBody = body
		get_node("InteractLbl").visible = true

func _on_Area2D_body_exited(body):
	attachedBody = null
	get_node("InteractLbl").visible = false
