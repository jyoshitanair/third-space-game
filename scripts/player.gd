extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var dirx := Input.get_axis("left", "right")
	if dirx:
		velocity.x = dirx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var diry := Input.get_axis("up", "down")
	if diry:
		velocity.y = diry * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
