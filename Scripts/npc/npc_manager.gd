class_name npc extends RigidBody3D

@export var detection_hitbox: Area3D
@export var pickup_hitbox: Area3D
var priority_list: Array[Idea] = []

func _ready() -> void:
	# Finds and picks up first key since funny shit XD
	priority_list.append(Idea.new(enums.Toughts.ITEM_PICKUP, enums.ItemType.KEY, {"door_key" : 1}, self))

func update():
	var is_decision_made = false
	var i = -1
	while i < priority_list.size() - 1:
		i += 1
		var tought = priority_list[i]
		if tought.execute():
			is_decision_made = true
			break
		if tought.expand():
			i = -1
			continue
	# if no decision then killtime() needs to be added
	# also make so that if the function can't be done it adds new element to array and tries that
	return is_decision_made

#functions return true if rest needs to be skipped
class Idea:
	var type: enums.Toughts
	var object_of_intrest: enums.ItemType
	var object_params: Dictionary
	var this_node: Node
	func _init(p_type: enums.Toughts, p_object_of_intrest: enums.ItemType, p_object_params: Dictionary, p_parent_node: Node) -> void:
		type = p_type
		object_params = p_object_params
		object_of_intrest = p_object_of_intrest
		this_node = p_parent_node
	# if it needs somthing beforehand
	func expand() -> bool:
		return expandIdea()
	# aka whenever the idea is prime and ready XD
	func execute() -> bool:
		return executeIdea()

	# returns true if the idea meets requirements
	func expandIdea() -> bool:
		match type:
			enums.Toughts.KILLTIME:
				pass
			enums.Toughts.ITEM_FIND:
				pass
			enums.Toughts.ITEM_PICKUP:
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
			enums.Toughts.WALKTO:
				pass
			_: return false
		return false

	# returns true if idea is executed aka no other ideas
	func executeIdea() -> bool:
		match type:
			enums.Toughts.KILLTIME:
				pass
			enums.Toughts.ITEM_FIND:
				pass
			enums.Toughts.ITEM_PICKUP:
				var found_item = getIteractableItems()
				if not found_item: return false
				print("DO PICKUP SHITERY")
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

	#whole alot of checking if item fits description
	func getIteractableItems() -> Node3D:
		for detected_body : Node3D in this_node.detection_hitbox.get_overlapping_bodies():
			if detected_body.is_in_group("item"):
				var script_main = detected_body.get_node("MAIN")
				if script_main.type == type:
					var does_params_fit = true
					for iter_param_key: String in object_params.keys():
						if detected_body.params.has(iter_param_key):
							if detected_body.params[iter_param_key] == object_params[iter_param_key]:
								continue
						does_params_fit = false
						break
					if does_params_fit:
						return detected_body
		return null