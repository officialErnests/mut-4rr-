class_name npc extends RigidBody3D

@export var interaction_hitbox: Area3D
@export var vision_hitbox: Area3D
@export var navigator: Node
@export var item_manager: Node	
signal toughUpdate

var priority_list: Array[Idea] = []
var curent_idea_index = -1
var idea_cycle_now := 0

func _ready() -> void:
	# Finds and picks up first key since funny shit XD
	navigator.done_moving.connect(update)
	priority_list.append(Idea.new(enums.Toughts.ITEM_PICKUP, enums.ItemType.KEY, {"door_key" : 1}, self))
	priority_list.append(Idea.new(enums.Toughts.ITEM_PICKUP, enums.ItemType.GUN, {}, self))

func update():
	var is_decision_made = false
	var i = -1
	idea_cycle_now += 1
	var DEBRAKER = 10
	print("START of tought\n" + global.arrToStr(priority_list, 0) + "")
	while i < priority_list.size() - 1:
		DEBRAKER -= 1
		if DEBRAKER <= 0: break
		i += 1
		print("ITER " + str(i))
		var tought = priority_list[i]
		if tought.idea_cycle >= idea_cycle_now: continue
		tought.idea_cycle = idea_cycle_now
		if tought.execute():
			print("^ DOING ^")
			curent_idea_index = i
			is_decision_made = true
			priority_list.remove_at(i)
			break
		if tought.expand():
			i = -1
			continue
	if not is_decision_made:
		curent_idea_index = -1
	print("END of tought\n" + global.arrToStr(priority_list, 0) + "")
	toughUpdate.emit()
	# if no decision then killtime() needs to be added
	# also make so that if the function can't be done it adds new element to array and tries that
	return is_decision_made

#functions return true if rest needs to be skipped
class Idea:
	var tought_types: enums.Toughts
	var object_of_intrest: enums.ItemType
	var object_params: Dictionary
	var this_node: Node
	var idea_cycle : int
	func _init(p_type: enums.Toughts, p_object_of_intrest: enums.ItemType, p_object_params: Dictionary, p_parent_node: Node) -> void:
		tought_types = p_type
		object_params = p_object_params
		object_of_intrest = p_object_of_intrest
		this_node = p_parent_node
		idea_cycle = p_parent_node.idea_cycle_now - 1
	# aka whenever the idea is prime and ready XD
	func execute() -> bool:
		print("executing: " + str(self))
		return executeIdea()
	# if it needs somthing beforehand
	func expand() -> bool:
		print(".expanding: " + str(self))
		return expandIdea()

	# returns true if the idea meets requirements
	func expandIdea() -> bool:
		match tought_types:
			enums.Toughts.KILLTIME:
				pass
			enums.Toughts.ITEM_FIND:
				pass
			enums.Toughts.ITEM_PICKUP:
				print("- expanded into ITEM_WALKTO")
				this_node.priority_list.push_front(Idea.new(enums.Toughts.ITEM_WALKTO, object_of_intrest, object_params, this_node))
				print(global.arrToStr(this_node.priority_list, 2))
			enums.Toughts.ITEM_WALKTO:
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
			enums.Toughts.ROOM_WALKTO:
				pass
			_: return false
		return true

	# returns true if idea is executed aka no other ideas
	func executeIdea() -> bool:
		match tought_types:
			enums.Toughts.ITEM_PICKUP:
				var found_item = getIteractableItems()
				if not found_item: return false
				this_node.item_manager.nbThrow()
			enums.Toughts.ITEM_WALKTO:
				var found_item = getVisableItems()
				if not found_item: return false
				this_node.navigator.runTo(found_item.global_position)

			_: return false
		return true

	#whole alot of checking if item fits description
	func getIteractableItems() -> Node3D:
		var items_inside_detection = this_node.interaction_hitbox.get_overlapping_bodies()
		return checkForMatchingItem(items_inside_detection)
		

	func getVisableItems() -> Node3D:
		var items_inside_detection = this_node.vision_hitbox.get_overlapping_bodies()
		return checkForMatchingItem(items_inside_detection)
	
	#Helper functions
	func checkForMatchingItem(p_nodes) -> Node3D:
		for detected_body : Node3D in p_nodes:
			if detected_body.is_in_group("item"):
				var script_main = detected_body.get_node("MAIN")
				if script_main.type == object_of_intrest:
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
	
	func _to_string() -> String:
		return enums.Toughts.keys()[tought_types] + " | " + enums.ItemType.keys()[object_of_intrest] + " - " + JSON.stringify(object_params)
