extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var bullet = preload("res://scenes/projectile.tscn")
@onready var sprite: Sprite2D = $PotatoMan

const SPEED = 300.0
const JUMP_VELOCITY = -850

var alive = true


func _physics_process(delta: float) -> void:

	if !alive:
		return

	# Shoot bullet
	if Input.is_action_just_pressed("ui_accept"):
		var bullet_temp = bullet.instantiate()
		bullet_temp.direction = 1
		add_child(bullet_temp)

	# Add animation
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "Idle"

	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jumping"

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Get the input direction
	var direction := Input.get_axis("left", "right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Flip sprite depending on direction
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true


func die() -> void:
	sprite.texture = preload("res://assets/images/Sprites/rock.png")
	print("dies")
	alive = false
