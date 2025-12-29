extends Node

@export var blinkers: Array[Panel]
var time_since_start := 0.0
func _process(delta: float) -> void:
	time_since_start += delta
	var norm_time = (float(global.reset_timer) / global.reset_timer_max)
	# var value = sin(time_since_start*0.5)*0.5
	var value = sin(time_since_start*1)*0.1 + (1-norm_time) * 0.2
	# var value = sin(time_since_start*0.5)*0.1 + (1-norm_time) * 0.2
	for blinker in blinkers:
		blinker.material.set("shader_parameter/size", value)
