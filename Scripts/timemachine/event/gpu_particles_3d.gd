extends GPUParticles3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.statuesDown.connect(disableForcefield)

func disableForcefield() -> void:
	emitting = false