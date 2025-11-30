class_name npc extends RigidBody3D

@export var detection_hitbox: Area3D
var priority_list: Array[Idea] = []

func update():
	var is_decision_made = false
	var i = -1
	while i < priority_list.size() - 1:
		i += 1
		var tought = priority_list[i]
		if tought.expand(): 
			i = -1
			continue
		if tought.execute(): 
			is_decision_made = true
			break
	# if no decision then killtime() needs to be added
	# also make so that if the function can't be done it adds new element to array and tries that
	return is_decision_made

#functions return true if rest needs to be skipped
class Idea:
	var type : enums.Toughts
	var object_of_intrest : enums.ItemType
	var exact_object_id : int
	func _init(p_type : enums.Toughts, p_object_of_intrest : enums.ItemType, p_exact_object_id : int) -> void:
		type = p_type
		exact_object_id = p_exact_object_id
		object_of_intrest = p_object_of_intrest
	# if it needs somthing beforehand
	func expand() -> bool:
		return expandIdea(type, object_of_intrest, exact_object_id)
	# aka whenever the idea is prime and ready XD
	func execute() -> bool:
		return executeIdea(type, object_of_intrest, exact_object_id)

	# returns true if the idea meets requirements
	func expandIdea(p_type : enums.Toughts, p_object_of_intrest : enums.ItemType, p_exact_object_id : int) -> bool:
		match p_type:
			enums.Toughts.KILLTIME:
				pass
			enums.Toughts.FINDITEM:
				pass
			enums.Toughts.FINDROOM:
				pass
			enums.Toughts.ATTACK:
				pass
			enums.Toughts.DEFEND:
				pass
			enums.Toughts.SURVIVE:
				pass
			enums.Toughts.ACTIVATE:
				pass
			enums.Toughts.EAT:
				pass
			enums.Toughts.DRINK:
				pass
			_: return false
		return true

	# returns true if idea is executed aka no other ideas
	func executeIdea(p_type : enums.Toughts, p_object_of_intrest : enums.ItemType, p_exact_object_id : int) -> bool:
		match p_type:
			enums.Toughts.KILLTIME:
				pass
			enums.Toughts.FINDITEM:
				pass
			enums.Toughts.FINDROOM:
				pass
			enums.Toughts.ATTACK:
				pass
			enums.Toughts.DEFEND:
				pass
			enums.Toughts.SURVIVE:
				pass
			enums.Toughts.ACTIVATE:
				pass
			enums.Toughts.EAT:
				pass
			enums.Toughts.DRINK:
				pass
			_: return false
		return true
