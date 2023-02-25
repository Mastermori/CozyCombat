class_name HealthLabel
extends Label3D

@export var target: NodePath

var target_node: Entity

func _ready() -> void:
	set_target(get_node(target))

func set_target(target_node: Node) -> void:
	if self.target_node:
		self.target_node.health_changed.disconnect(update)
	
	if not target_node is Entity:
		printerr("HealthLabel target needs to be an Entity!")
		return
	
	self.target_node = target_node
	self.target_node.health_changed.connect(update)
	text = "Health: %s/%s" % [target_node.health, target_node.max_health]

func update(health: float, _previous_health: float, max_health: float) -> void:
	text = "Health: %s/%s" % [health, max_health]
