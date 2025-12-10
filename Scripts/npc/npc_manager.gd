class_name npc extends RigidBody3D

@export var interaction_hitbox: Area3D
@export var vision_hitbox: Area3D
@export var navigator: Node
@export var item_manager: Node	
signal toughUpdate

var priority_list: Array[Idea] = []
var curent_idea_index = -1
var idea_cycle_now := 0
var id

#* TODO
#* Make em cool aka make em rember the time and pos as well talk about this
#* (Each talk can only exchange specific info about that :DD)
var seen_objects: Array[Seen_object]
var seen_person: Array[Seen_person]
# var seen_people

func _ready() -> void:
	# Finds and picks up first key since funny shit XD
	id = global.declareCharecter(self)
	navigator.done_moving.connect(update)
	var temp_key = Item.new(enums.ItemType.KEY, {"door_key" : 1})
	var temp_gun = Item.new(enums.ItemType.KEY, {"door_key" : 1})
	priority_list.append(Idea.new(enums.Toughts.ITEM_PICKUP, temp_key, self))
	priority_list.append(Idea.new(enums.Toughts.ITEM_PICKUP, temp_gun, self))

	vision_hitbox.body_entered.connect(visionSignal)
	vision_hitbox.body_exited.connect(visionSignal)

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

		var ret_expand = tought.expandUpon()

		if ret_expand.has("removeRelative"): priority_list.remove_at(ret_expand["removeRelative"] + i)
		if ret_expand.has("removeAbsolute"): priority_list.remove_at(ret_expand["removeAbsolute"])
		
		if ret_expand.has("exit"): 
			is_decision_made = true
			break
		
		if ret_expand.has("indexAdd"): i += ret_expand["indexAdd"]
		if ret_expand.has("indexSet"): i = ret_expand["indexSet"]

	if not is_decision_made:
		if not navigator.is_in_action:
			priority_list.push_back(Idea.new(enums.Toughts.KILLTIME, null, self))
		curent_idea_index = -1

	print("END of tought\n" + global.arrToStr(priority_list, 0) + "")
	toughUpdate.emit()
	# if no decision then killtime() needs to be added
	# also make so that if the function can't be done it adds new element to array and tries that
	return is_decision_made

func visionSignal(body: Node3D):
	if body.is_in_group("npc"):
		pass
	elif  body.is_in_group("item"):
		pass
	elif body.is_in_group("player"):
		pass
		

func visionCanSee(object: Node3D):
	castRay(object.global_position)
	#* TODO make em work based on visible markers aka markers 3d

class Seen_object:
	var position: Vector3
	var time_seen: int 
	var item: Item
	func _init(p_position: Vector3, p_item: Item) -> void:
		position = p_position
		time_seen = global.getTime()
		item = p_item

class Seen_person:
	var position: Vector3
	var time_seen: int
	var person_id: int
	func _init(p_position: Vector3, p_person_id: int) -> void:
		position = p_position
		time_seen = global.getTime()
		person_id = p_person_id


#functions return true if rest needs to be skipped
class Idea:
	var tought_types: enums.Toughts
	var this_node: Node
	var idea_cycle : int
	var object_of_intrest
	func _init(p_type: enums.Toughts, p_object_of_intrest, p_parent_node: Node) -> void:
		tought_types = p_type
		this_node = p_parent_node
		object_of_intrest = p_object_of_intrest
		idea_cycle = p_parent_node.idea_cycle_now - 1
	# if it needs somthing beforehand
	func expandUpon() -> Dictionary:
		print(".expanding: " + str(self))
		return expandIdea()

	# returns true if the idea meets requirements
	func expandIdea() -> Dictionary:
		match tought_types:
			enums.Toughts.ITEM_THROW:
				this_node.item_manager.nbThrow()
				return {"removeRelative": -1, "exit": true}
			enums.Toughts.KILLTIME:
				#* TODO Make it semi random so seed generation can be predictable
				this_node.navigator.walkTo(this_node.global_position + Vector3(randf_range(-1,1),randf_range(-1,1),randf_range(-1,1) * 10))
				return {"exit": true, "removeRelative": 0}
			enums.Toughts.ITEM_FIND:
				pass
			enums.Toughts.ITEM_PICKUP:
				if this_node.item_manager.equiped_item:
					if this_node.itemMatch(this_node.item_manager.equiped_item, object_of_intrest):
						return {"indexSet": -1, "removeRelative": 0}

				var found_item = getIteractableItems()
				if not found_item:
					this_node.priority_list.push_front(Idea.new(enums.Toughts.ITEM_WALKTO, object_of_intrest, this_node))
					return {"indexSet": -1}
				if this_node.item_manager.equiped_item:
					this_node.priority_list.push_front(Idea.new(enums.Toughts.ITEM_THROW, object_of_intrest, this_node))
					return {"indexSet": -1}
				# DONE ^

				this_node.item_manager.nbThrow()
				if this_node.item_manager.equiped_item:
					if not this_node.itemMatch(this_node.item_manager.equiped_item, object_of_intrest):
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
		var closest_item = null
		var closest_item_distance = -1
		for detected_body : Node3D in p_nodes:
			if itemMatchPre(detected_body):
				var raycast = this_node.castRay(detected_body.global_position)
				if raycast:
					continue
				else:
					var temp_distance = detected_body.global_position.distance_to(this_node.vision_hitbox.global_position)
					if not closest_item:
						closest_item_distance = temp_distance
						closest_item = detected_body
					if temp_distance < closest_item_distance:
						closest_item_distance = temp_distance
						closest_item = detected_body
		return closest_item
	
	func itemMatchPre(p_item : Node3D) -> bool:
		if p_item.is_in_group("item"):
			return this_node.itemMatch(this_node.nodeToItem(p_item), object_of_intrest)
		return false

	func _to_string() -> String:
		return enums.Toughts.keys()[tought_types] + " | " + enums.ItemType.keys()[object_of_intrest] + " - " + JSON.stringify(object_of_intrest)

class Item:
	var type: enums.ItemType
	var params: Dictionary
	func _init(p_object_of_intrest: enums.ItemType, p_object_params: Dictionary) -> void:
		type = p_object_of_intrest
		params = p_object_params
	func _to_string() -> String:
		return enums.ItemType.keys()[type] + " | " + global.dicToString(params)
	
func nodeToItem(p_node) -> Item:
	var res_item = Item.new(p_node.getType(), p_node.getParams()) 
	#* TODO make this

func itemMatch(p_item: Item, p_item_min: Item) -> bool:
	var script_main = p_item.get_node("MAIN")
	if script_main.type == p_item_min.object_of_intrest:
		for iter_param_key: String in p_item_min.object_params.keys():
			if p_item.params.has(iter_param_key):
				if p_item.params[iter_param_key] == p_item_min.object_params[iter_param_key]:
					continue
			return false
		return true
	return false

func castRay(p_end_position :Vector3):
	var ray_point_start = vision_hitbox.global_position
	var ray_point_end = p_end_position

	var space_state = get_world_3d().direct_space_state

	var params = PhysicsRayQueryParameters3D.create(ray_point_start, ray_point_end, 4)

	return space_state.intersect_ray(params)