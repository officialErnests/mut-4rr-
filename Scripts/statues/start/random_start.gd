extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("pose" + str(randi_range(1,3)))