extends AudioStreamPlayer

func _ready() -> void:
	pass
	#TODO reenable
	# play(global.music_last_time)

func _process(delta: float) -> void:
	pitch_scale = min(1, 1.5 - global.getLoopTimeProc())

func _exit_tree() -> void:
	looping()

func looping():
	global.music_last_time = get_playback_position()