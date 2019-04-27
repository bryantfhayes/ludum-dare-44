extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var attachedBody = null
var offset = Vector2(10.0, -25.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	attachedBody = null
	set_process(true)
	get_node("InteractLbl").text = "Press 'e' to Enter Store"
	get_node("InteractLbl").visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attachedBody != null:
		get_node("InteractLbl").rect_global_position = attachedBody.position + offset
		if Input.is_action_just_pressed("ui_interact"):
			print("INTERACTED WITH STORE")

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		attachedBody = body
		get_node("InteractLbl").visible = true

func _on_Area2D_body_exited(body):
	attachedBody = null
	get_node("InteractLbl").visible = false
