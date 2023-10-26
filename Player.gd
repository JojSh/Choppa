extends Area2D

var move_speed_px : int = 50

func _process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += direction * move_speed_px * delta
	handle_animation(direction)

func handle_animation(direction):
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
