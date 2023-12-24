extends CharacterBody2D

var awarenessRadius : int = 80
var direction : Vector2
var attackDelay : float = 1.0
var attackPower : int = 1
var collision

@onready var player = get_node("/root/Main/Player")
@onready var attackDelayTimer = get_node("AttackDelayTimer")

func _ready():
	player.hit_enemy.connect(take_damage)
	
	attackDelayTimer.set_wait_time(attackDelay)
	attackDelayTimer.start()

func _physics_process (delta):
	var distanceToTarget = position.distance_to(player.position)
	
	if distanceToTarget < awarenessRadius:
		direction = (player.position - position).normalized()
		velocity = direction * 40
		collision = move_and_collide(velocity * delta)

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

func _on_attack_delay_timer_timeout ():
	if (collision):
		var collider = collision.get_collider()
		register_hit_on_player(collider)

func register_hit_on_player (collider):
	if collider is Player:
		player.take_damage(attackPower)
