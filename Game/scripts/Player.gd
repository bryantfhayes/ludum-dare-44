extends KinematicBody2D

signal hit

# How fast the player will move (pixels/sec)
export (int) var speed

# Size of the game window
var screensize

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var velocity = Vector2()
func _unhandled_input(event):
	pass

func _ready():
	screensize = get_viewport_rect().size

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.animation = "right"
		velocity.x += 1
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.animation = "left"
		velocity.x -= 1
	elif Input.is_action_pressed("ui_down"):
		$AnimatedSprite.animation = "down"
		velocity.y += 1
	elif Input.is_action_pressed("ui_up"):
		$AnimatedSprite.animation = "up"
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.frame = 0
		$AnimatedSprite.stop()
		
	#print(velocity)
		
func _on_Player_body_entered(body):
	pass

func _on_Player_area_entered(area):
	pass # replace with function body

func _physics_process(delta):
    get_input()
    move_and_collide(velocity * delta)
