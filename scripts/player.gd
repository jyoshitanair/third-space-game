extends CharacterBody2D

const SPEED = 250.0

@onready var attack_area: Area2D = $AttackArea
@onready var sprite: Sprite2D = $Sprite2D
var can_attack: bool = true

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		
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
