extends CharacterBody2D

var move_speed_px : int = 50
var facing_direction : Vector2 = Vector2()

func _physics_process (delta):
	velocity = Vector2.ZERO
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * move_speed_px
	move_and_slide()
	handle_walking_animation(direction)

	if Input.is_action_just_pressed("attack"):
		handle_attack_animation()

func handle_walking_animation (direction):
	if not $AnimatedSprite2D.is_playing():
		if direction.x > 0:
			$AnimatedSprite2D.play("right")
			facing_direction = direction
		elif direction.x < 0:
			$AnimatedSprite2D.play("left")
			facing_direction = direction
		elif direction.y < 0:
			$AnimatedSprite2D.play("up")
			facing_direction = direction
		elif direction.y > 0:
			$AnimatedSprite2D.play("down")
			facing_direction = direction

func handle_attack_animation ():
	if facing_direction.x > 0:
		$AnimatedSprite2D.play("attack_right")
	elif facing_direction.x < 0:
		$AnimatedSprite2D.play("attack_left")
	elif facing_direction.y < 0:
		$AnimatedSprite2D.play("attack_up")
	elif facing_direction.y > 0:
		$AnimatedSprite2D.play("attack_down")
