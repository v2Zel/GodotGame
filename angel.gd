extends Area2D
@onready var Angel: Sprite2D = $Angel

signal player_died
const SPEED = 100.0
var direction = -1.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.x += direction * SPEED * delta

func _on_timer_timeout() -> void:
	direction *= -1
	Angel.flip_h = !Angel.flip_h


func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.name == "player" and body.alive:
		emit_signal("player_died", body)
