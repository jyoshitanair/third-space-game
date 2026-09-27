extends Node2D
var left
var right
var down 
var up
var player
var target = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	left = player.get_tree().get_first_node_in_group("left")
	right = player.get_tree().get_first_node_in_group("right")
	down = player.get_tree().get_first_node_in_group("down")
	up = player.get_tree().get_first_node_in_group("up")
	target = left.global_position
	print(up)
	print(down)
	print(left)
	print(right)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.dirx == 1: 
		target = left.global_position
	if player.dirx == -1: 
		target= right.global_position
	if player.diry == -1:
		target = up.global_position
	if player.diry == 1:
		target = down.global_position
	self.global_position = lerp(self.global_position, target, delta*3)
