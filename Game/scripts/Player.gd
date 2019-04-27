extends Area2D

signal hit

# How fast the player will move (pixels/sec)
export (int) var speed

# Size of the game window
var screensize

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_B:
			$Health.take_damage(100)
		if event.pressed and event.scancode == KEY_G:
			$Purse.add_gold(100)

func _ready():
	screensize = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()
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
		

	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)


func _on_Player_body_entered(body):
	print("Collided")



func _on_Player_area_entered(area):
	print("collide")
	pass # replace with function body
