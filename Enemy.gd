extends CharacterBody2D

var awarenessRadius : int = 80
var direction : Vector2
@onready var player = get_node("/root/Main/Player")

func _ready():
	player.hit_enemy.connect(take_damage)

func _physics_process (delta):
	var distanceToTarget = position.distance_to(player.position)
	
	if distanceToTarget < awarenessRadius:
		direction = (player.position - position).normalized()
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

func die ():
	queue_free()

func take_damage(collider):
	if collider == self:
		die()
