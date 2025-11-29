extends RigidBody3D

enum enum_toughts {
	KILLTIME,
	FINDITEM,
	FINDROOM,
	ATTACK,
	DEFEND,
	SURVIVE,
	ACTIVATE,
	EAT,
	DRINK
}

@export var detection_hitbox: Area3D
@export var priority_list: Array[enum_toughts] = []

func update():
	var is_decision_made = false
	var i = -1
	while i < priority_list.size():
		i += 1
		var tought = priority_list[i]
		if functionFromEnum(tought): 
			is_decision_made = true
			break
	# if no decision then killtime() needs to be added
	# also make so that if the function can't be done it adds new element to array and tries that
	return is_decision_made

func functionFromEnum(p_enum: enum_toughts) -> bool:
	match p_enum:
		enum_toughts.KILLTIME: return killTime()
		enum_toughts.FINDITEM: return findItem()
		enum_toughts.FINDROOM: return findRoom()
		enum_toughts.ATTACK: return attack()
		enum_toughts.DEFEND: return defend()
		enum_toughts.SURVIVE: return survive()
		enum_toughts.ACTIVATE: return activate()
		enum_toughts.EAT: return eat()
		enum_toughts.DRINK: return drink()
		_: return false

# ALL OF FUCNTIONALITY
# if function returns true it means npc has decided what to do
func killTime() -> bool:
	return false

func findItem() -> bool:
	return false

func findRoom() -> bool:
	return false

func attack() -> bool:
	return false
	
func defend() -> bool:
	return false
	
func survive() -> bool:
	return false
	
func activate() -> bool:
	return false
	
func eat() -> bool:
	return false
	
func drink() -> bool:
	return false