extends CanvasLayer
@onready var texture_button: TextureButton = $Control/TextureButton
@onready var texture_progress_bar: ProgressBar = $Control/TextureProgressBar
@onready var settings: Panel = $Control/settings
@onready var button: Button = $Control/settings/Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_progress_bar.min_value = 0
	texture_progress_bar.max_value = 100
	texture_progress_bar.value = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	texture_progress_bar.value = Manager.health
	
func _on_texture_button_toggled(toggled_on: bool) -> void:
	settings.visible = toggled_on
	Manager.paused = toggled_on 
	print("clicky")
	button.disabled = !toggled_on
