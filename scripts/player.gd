extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 250.0
var state
@onready var attack_area: Area2D = $attack_area
var can_attack: bool = true
var direction

func _physics_process(delta: float) -> void:
	state = "normal"
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	if direction.x != 0: 
		state = "walk"
	if direction.y == 1:
		state = "up"
	if direction.y == -1:
		state = "down"
	play_animation(state)
	move_and_slide()
	
	if direction.x != 0:
		sprite.flip_h = (direction.x < 0)
		
	if Input.is_action_just_pressed("ui_accept") and can_attack:
		can_attack = false
		attack()
		await get_tree().create_timer(0.35).timeout
		can_attack = true

func attack() -> void:
	attack_area.monitoring = true
	await get_tree().create_timer(0.15).timeout
	attack_area.monitoring = false

func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().take_damage(1)
func play_animation(state) -> void: 
	sprite.play(state)
