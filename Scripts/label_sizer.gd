extends Label3D

enum Text_States {
	IDLE,
	SHOOT,
	AIM
}
var SHOT_TEXTS = [
	"-IDLE-",
	"-SHOOT-",
	"-AIM-"
]
var TEXT_SIZE = [
	0.345,
	0.51,
	0.325
]
var distance = 4
var scroll_dir = -10
@export var text_state := Text_States.IDLE
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	renderText()

var scroll = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll -= delta * scroll_dir

func setState(p_state):
	text_state = p_state

func renderText():
	text = ""
	var temp_range = floori(distance / (TEXT_SIZE[text_state] * 4)) - 1
	for i in range(temp_range):
		if i == 0:
			text += SHOT_TEXTS[text_state].substr(floori(scroll) % (SHOT_TEXTS[text_state].length()))
		elif i == temp_range - 1:
			text += SHOT_TEXTS[text_state].substr(0, floori(scroll) % (SHOT_TEXTS[text_state].length()))
		else:
			text += SHOT_TEXTS[text_state]
