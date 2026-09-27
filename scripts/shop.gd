extends Node2D
@onready var fail: Label = $Node2D/fail
@onready var passer: Label = $Node2D/pass
@onready var pet: TextureButton = $pet/pet
@onready var cloth_1: TextureButton = $cloth1/cloth1
@onready var cloth_2: TextureButton = $cloth2/cloth2
@onready var coins: Label = $Node2D/Label
@onready var alr: Label = $Node2D/alr


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Manager.pet: 
		pet.disabled = true
	if Manager.cloth1:
		cloth_1.disabled = true 
	if Manager.cloth2:
		cloth_2.disabled = true
	coins.text = str(Manager.coins)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_pet_pressed() -> void:
	#cost 1000
	if Manager.coins >=1000 && !Manager.pet:
		passer.show()
		Manager.coins -= 1000
		Manager.pet = true
	else:
		if Manager.pet:
			alr.show()
		fail.show()
func _on_cloth_1_pressed() -> void:
	#cost 1000
	if Manager.coins >= 1000 && !Manager.cloth1:
		passer.show()
		Manager.coins -= 1000
		Manager.cloth1 = true
	else:
		if Manager.cloth1:
			alr.show()
		fail.show()

func _on_cloth_2_pressed() -> void:
	#cost 1000
	if Manager.coins >=1000 && !Manager.cloth2:
		passer.show()
		Manager.coins -= 1000
		Manager.cloth2 = true
	else:
		if Manager.cloth2:
			alr.show()
		fail.show()
