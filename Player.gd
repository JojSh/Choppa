extends CharacterBody2D

var move_speed_px : int = 50

func _physics_process (delta):
	velocity = Vector2()
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	velocity = velocity.normalized() * move_speed_px
	move_and_slide()
	handle_animation(direction)

func handle_animation (direction):
	if direction.x > 0:
		$AnimatedSprite2D.play("right")
	elif direction.x < 0:
		$AnimatedSprite2D.play("left")
	elif direction.y < 0:
		$AnimatedSprite2D.play("up")
	elif direction.y > 0:
		$AnimatedSprite2D.play("down")
	else:
		$AnimatedSprite2D.stop()
