extends Control

func _process(_delta: float) -> void:
	anchor_right = float(global.reset_timer) / global.reset_timer_max
