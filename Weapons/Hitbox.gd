class_name Hitbox
extends Area3D

signal on_hit(entity_hit: Entity)

@export var damage: float = 8
@export var knockback_strength: float = 10
@export var knockback_source: NodePath

var knockback_source_node: Node3D

func _ready():
	if not area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)
	monitorable = false
	if knockback_source:
		knockback_source_node = get_node(knockback_source)
	else:
		print("No Knockbacksource found, using Hitbox owner.")
		knockback_source_node = owner

func _on_area_entered(area: Area3D) -> void:
	if not area is Hurtbox:
		return
	
	if area.owner is Entity:
		var entity: Entity = area.owner
		entity.damage(damage, owner)
		var knockback_dir = knockback_source_node.global_position.direction_to(entity.global_position)
#		knockback_dir.y = .2
		entity.knockback(knockback_dir.normalized(), knockback_strength)
		owner.hit_effect(entity)
		on_hit.emit(entity)
