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
@export var text_state := Text_States.IDLE
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	renderText()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setState(p_state):
	text_state = p_state

func renderText():
	text = ""
	for i in range(floor(distance / (TEXT_SIZE[text_state] * 4))):
		text += SHOT_TEXTS[text_state]