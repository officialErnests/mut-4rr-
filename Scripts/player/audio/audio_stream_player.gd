extends AudioStreamPlayer

func _ready() -> void:
	play(global.music_last_time)
	pass
	#TODO reenable

func _process(delta: float) -> void:
	pitch_scale = min(1, 1.9 - global.getLoopTimeProc())

func _exit_tree() -> void:
	looping()

func looping():
	global.music_last_time = get_playback_position()