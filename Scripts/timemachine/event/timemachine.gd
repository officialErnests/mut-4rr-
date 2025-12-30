extends StaticBody3D


func mele_hit(dmg: float) -> void:
	if global.statusGet() <= 0:
		global.win()