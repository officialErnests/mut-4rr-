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

		var ret_expand = tought.expandUpon(i)

		if ret_expand.has("removeRelative"): priority_list.remove_at(ret_expand["removeRelative"] + i)
		if ret_expand.has("removeAbsolute"): priority_list.remove_at(ret_expand["removeAbsolute"])
		
		if ret_expand.has("exit"): 
			is_decision_made = true
			break
		
		if ret_expand.has("indexAdd"): i += ret_expand["indexAdd"]
		if ret_expand.has("indexSet"): i = ret_expand["indexSet"]

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
	# if it needs somthing beforehand
	func expandUpon(i) -> Dictionary:
		print(".expanding: " + str(self))
		return expandIdea(i)

	# returns true if the idea meets requirements
	func expandIdea(i) -> Dictionary:
		match tought_types:
			enums.Toughts.ITEM_THROW:
				this_node.item_manager.nbThrow()
				return {"removeRelative": -1, "exit": true}
			enums.Toughts.KILLTIME:
				pass
			enums.Toughts.ITEM_FIND:
				pass
			enums.Toughts.ITEM_PICKUP:
				if this_node.item_manager.equiped_item:
					if itemMatch(this_node.item_manager.equiped_item):
						return {"indexSet": -1, "removeRelative": 0}

				var found_item = getIteractableItems()
				if not found_item:
					this_node.priority_list.push_front(Idea.new(enums.Toughts.ITEM_WALKTO, object_of_intrest, object_params, this_node))
					return {"indexSet": -1}
				if this_node.item_manager.equiped_item:
					this_node.priority_list.push_front(Idea.new(enums.Toughts.ITEM_THROW, object_of_intrest, object_params, this_node))
					return {"indexSet": -1}
				# DONE ^

				this_node.item_manager.nbThrow()
				if this_node.item_manager.equiped_item:
					if not itemMatch(this_node.item_manager.equiped_item):
						this_node.item_manager.nbThrow()
						return {"exit": true}
					return {"exit": true, "removeRelative": 0}
			enums.Toughts.ITEM_WALKTO:
				var found_item = getVisableItems()
				if not found_item: 
					return {"removeRelative": 0}
				this_node.navigator.runTo(found_item.global_position)
				return {"removeRelative": 0, "exit": true}
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
			_: return {}
		return {}

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
			if itemMatchPre(detected_body):
				return detected_body
		return null
	
	func itemMatchPre(p_item) -> bool:
		if p_item.is_in_group("item"):
			return itemMatch(p_item)
		return false

	func itemMatch(p_item) -> bool:
		var script_main = p_item.get_node("MAIN")
		if script_main.type == object_of_intrest:
			var does_params_fit = true
			for iter_param_key: String in object_params.keys():
				if p_item.params.has(iter_param_key):
					if p_item.params[iter_param_key] == object_params[iter_param_key]:
						continue
				does_params_fit = false
				print("..Params don't fit: " + iter_param_key)
				break
			if does_params_fit:
				print("..Found!")
				return true
		print("..Wrong type")
		return false

	func _to_string() -> String:
		return enums.Toughts.keys()[tought_types] + " | " + enums.ItemType.keys()[object_of_intrest] + " - " + JSON.stringify(object_params)
