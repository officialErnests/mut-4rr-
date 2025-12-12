extends RigidBody3D

@export var params = {}

var id: int
var item: classes.Item
@onready var main = $MAIN
func _ready() -> void:
    global.declareItem(self)
    item = classes.Item.new(main.getType(), main.getParams())
