extends CharacterBody2D

var move_speed_px : int = 50

func _physics_process (delta):
	velocity = Vector2.ZERO
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * move_speed_px
	move_and_slide()
	handle_walking_animation(direction)

	if Input.is_action_just_pressed("attack"):
		$AnimatedSprite2D.play("attack_down")

func handle_walking_animation (direction):
	if not $AnimatedSprite2D.is_playing():
		if direction.x > 0:
			$AnimatedSprite2D.play("right")
		elif direction.x < 0:
			$AnimatedSprite2D.play("left")
		elif direction.y < 0:
			$AnimatedSprite2D.play("up")
		elif direction.y > 0:
			$AnimatedSprite2D.play("down")
