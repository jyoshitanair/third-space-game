extends ProgressBar
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	min_value = 0
	max_value = 100
	value = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = Manager.health
