extends Node2D
@onready var fail: Label = $Node2D/fail
@onready var passer: Label = $Node2D/pass
@onready var pet: TextureButton = $pet/pet
@onready var cloth_1: TextureButton = $cloth1/cloth1
@onready var cloth_2: TextureButton = $cloth2/cloth2
@onready var coins: Label = $Node2D/Label
@onready var alr: Label = $Node2D/alr
@onready var yeah1: CheckButton = $pet/yeah
@onready var yeah2: CheckButton = $cloth1/yeah
@onready var yeah3: CheckButton = $cloth2/yeah


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	yeah1.disabled = true
	yeah3.disabled = true
	yeah2.disabled = true
	yeah1.hide()
	yeah2.hide()
	yeah3.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Manager.pet: 
		yeah1.show()
		yeah1.disabled = false
	if Manager.cloth1:
		yeah2.show()
		yeah2.disabled = false
	if Manager.cloth2:
		yeah3.show()
		yeah3.disabled = false
	coins.text = str(Manager.coins)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	print("RETURN")

func _on_pet_pressed() -> void:
	#cost 1000
	if Manager.coins >=1000 && !Manager.pet:
		passer.show()
		Manager.coins -= 1000
		Manager._pet_got()
	else:
		if Manager.pet:
			alr.show()
		fail.show()
func _on_cloth_1_pressed() -> void:
	#cost 1000
	if Manager.coins >= 1000 && !Manager.cloth1:
		passer.show()
		Manager.coins -= 1000
		Manager._cloth1_got()
	else:
		if Manager.cloth1:
			alr.show()
		fail.show()

func _on_cloth_2_pressed() -> void:
	#cost 1000
	if Manager.coins >=1000 && !Manager.cloth2:
		passer.show()
		Manager.coins -= 1000
		Manager._cloth2_got()
	else:
		if Manager.cloth2:
			alr.show()
		fail.show()

#pet
func _on_yeah_toggled(toggled_on: bool) -> void:
	Manager.pet_enabled = toggled_on
#c1
func _on_c1_toggled(toggled_on: bool) -> void:
	Manager.c1_enabled = toggled_on
#c2
func _on_c2_toggled(toggled_on: bool) -> void:
	Manager.c2_enabled = toggled_on
