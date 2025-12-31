extends CharacterBody3D

#id setup
var id := -1
@export var blinker: AnimationTree
func  _ready() -> void:
	id = global.declareCharecter(self)
	#TODO set thsi to 100 or better value ;PP
	var i_max: float = 20.0
	for i in range(i_max + 1):
		await get_tree().create_timer(0.05).timeout
		blinker.set("parameters/blend_position", min(cos(i * 0.2) * 0.1 + (i / i_max), 1))
	blinker.set("parameters/blend_position", 1)

#health setup and whateer the fuck  is after setup XD
var max_hp = 100
var hp = max_hp
func shot_hit(dmg: float):
	takeDmg(dmg)
func mele_hit(dmg: float):
	takeDmg(dmg)
func takeDmg(p_dmg: float) -> void:
	pass
	#TODO make so player cant hit itself
	# hp -= p_dmg
	# if hp <= 0:
	# 	global.replay()
