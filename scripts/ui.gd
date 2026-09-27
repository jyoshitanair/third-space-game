extends CanvasLayer
@onready var texture_button: TextureButton = $Control/TextureButton
@onready var texture_progress_bar: ProgressBar = $Control/TextureProgressBar
@onready var settings: Panel = $Control/settings
@onready var button: Button = $Control/settings/Button
@onready var label: Label = $Control/Label
@onready var lev_1: Sprite2D = $Control/settings/lev_1
@onready var lev_2: Sprite2D = $Control/settings/lev_2
@onready var lev_3: Sprite2D = $Control/settings/lev_3
@onready var lev_4: Sprite2D = $Control/settings/lev_4
@onready var lev_5: Sprite2D = $Control/settings/lev_5
var no_img  = preload("res://assets/images/closed-chest.PNG")
var yes_img = preload("res://assets/images/open-chest.PNG")
var levels = [false, false, false, false, false]
var level_sprites
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_sprites = [lev_1,lev_2,lev_3,lev_4,lev_5]
	texture_progress_bar.min_value = 0
	texture_progress_bar.max_value = 100
	texture_progress_bar.value = 100
	label.text = Manager.namey
	update_ui()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	texture_progress_bar.value = Manager.health
func update_ui() -> void: 
	var count = Manager.level - 1 #up to level-1
	for i in range(0,count):
		levels[i] = true
		var level = levels[i]
		print(count)
		if level == true: 
			level_sprites[i].texture = yes_img
			print("NO")
		else:
			level_sprites[i].texture = no_img
			print("Yes")
func _on_texture_button_toggled(toggled_on: bool) -> void:
	settings.visible = toggled_on
	Manager.paused = toggled_on 
	print("clicky")
	button.disabled = !toggled_on

func _on_button_pressed() -> void:
	print("log out")

func _on_check_button_toggled(toggled_on: bool) -> void:
	Manager.on = toggled_on
func _on_shiop_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop.tscn")
