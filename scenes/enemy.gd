extends CharacterBody2D

var speed = 100.0
var player = null

func _physics_process(delta: float) -> void:
	if player:
		var dir = (player.global_position - global_position).normalized()
		velocity = dir * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
var health = 3

func take_damage(amount: int) -> void:
	health -= amount
	modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE
	if health <= 0:
		queue_free()
