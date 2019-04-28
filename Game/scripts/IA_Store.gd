extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var attachedBody = null

# TODO Export these?
var bloodRestoreAmount = 1100
var foodCostAmount = 300
var drugCostAmount = 3000
var bloodRegenUpgradeAmount = 350

# Called when the node enters the scene tree for the first time.
func _ready():
	attachedBody = null
	set_process(true)
	var text = "Press 'f' to buy food (%d gold), \n'd' to buy drugs (%d gold)"
	get_node("InteractLbl").text = text % [foodCostAmount, drugCostAmount]
	get_node("InteractLbl").visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attachedBody != null:
		
		var node = self.owner
		var player_node = node.get_node("Player")
		var health_node = player_node.get_node("Health")
		var purse_node = player_node.get_node("Purse")
		var manager_node = node.get_node("/root/GameManager")
		
		if Input.is_action_just_pressed("ui_food"):
			if purse_node.gold - foodCostAmount >=0:
				health_node.heal(bloodRestoreAmount)
				player_node.get_node("Purse").remove_gold(foodCostAmount)
				$EatingSound.play()
		if Input.is_action_just_pressed("ui_drug"):
			if purse_node.gold - drugCostAmount >=0:
				$DrugSound.play()
				purse_node.remove_gold(drugCostAmount)
				manager_node.bloodRegenMlPerSecond += bloodRegenUpgradeAmount

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		attachedBody = body
		get_node("InteractLbl").visible = true

func _on_Area2D_body_exited(body):
	attachedBody = null
	get_node("InteractLbl").visible = false
