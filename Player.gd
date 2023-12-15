extends CharacterBody2D

signal hit_enemy(collider)

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
		if colliding_with_enemy():
			register_hit_on_enemy()

func colliding_with_enemy():
	return $AttackRaycast.is_colliding() and $AttackRaycast.get_collider().is_in_group("Enemies")

func register_hit_on_enemy():
	emit_signal("hit_enemy", $AttackRaycast.get_collider())

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
