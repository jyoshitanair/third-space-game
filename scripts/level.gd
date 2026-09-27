extends Node2D

var end = 5
var player = preload("res://scenes/player.tscn")
@onready var spawn: Marker2D = $spawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.is_in_group("level1"):
		Manager.level_coins = 2
	print("LOADING PLATER")
	var preal = player.instantiate()
	print(spawn)
	if Manager.first:
		get_tree().current_scene.add_child.call_deferred(preal)
		Manager.first = false
	else:
		print("HALLO?")
		get_tree().current_scene.add_child(preal)

func _change_level() -> void: 
	Manager.level += 1
	if Manager.level > end:
		get_tree().change_scene_to_file("res://scenes/treasure.tscn")
	else:
		var next_path = "res://scenes/level%d.tscn"%Manager.level
		get_tree().change_scene_to_file(next_path)

func _on_end_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Manager.level >= end:
			queue_free()
		else:
			Manager.level += 1
			var new_path = "res://scenes/level%d.tscn"%Manager.level
			var new_level = load(new_path)
			var new_node = new_level.instantiate()
			get_tree().get_first_node_in_group("player").queue_free()
			call_deferred("_change_level", new_node)
