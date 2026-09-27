extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var state = "normal"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	state = "normal"
	if !Manager.paused:
		var dirx := Input.get_axis("left", "right")
		if dirx:
			velocity.x = dirx * SPEED
			#moving
			state = "walk"
			sprite.flip_h = true if dirx <0 else false
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		var diry := Input.get_axis("up", "down")
		if diry:
			velocity.y = diry * SPEED
			if diry == -1:
				state = "down"
			else:
				state = "up"
		else:
			velocity.y = move_toward(velocity.x, 0, SPEED)
		play_animation(state)
		move_and_slide()
func play_animation(state) -> void: 
	sprite.play(state)
