extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		collect()

func collect() -> void:
	collision.set_deferred("disabled", true)
	Manager._coin_change()
	print("coin picked up!")
	queue_free()
