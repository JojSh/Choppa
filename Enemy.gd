extends CharacterBody2D

var awarenessRadius : int = 80
var direction : Vector2
@onready var target = get_node("/root/Main/Player")

func _physics_process (delta):
	var distanceToTarget = position.distance_to(target.position)
	
	if distanceToTarget < awarenessRadius:
		direction = (target.position - position).normalized()
		velocity = direction * 40
		move_and_slide()

func _process (delta):
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
