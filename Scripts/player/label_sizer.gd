extends Label3D

var curent_text = " // "
var distance = 4
@export var scroll_dir = -10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	renderText()

var scroll = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll -= delta * scroll_dir

func renderText():
	text = ""
	text.length()
	var temp_range = max(floori(distance / float(curent_text.length())*8) + 1, 2)
	for i in range(temp_range):
		if i == 0:
			text += curent_text.substr(floori(abs(scroll)) % (curent_text.length()))
		elif i == temp_range - 1:
			text += curent_text.substr(0, floori(abs(scroll)) % (curent_text.length()))
		else:
			text += curent_text
