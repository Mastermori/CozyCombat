class_name Hitbox
extends Area3D

@export var damage: float = 1
@export var knockback_strength: float = 8
@export var knockback_source: NodePath

var knockback_source_node: Node3D

func _ready():
	monitorable = false
	if not knockback_source:
		print("No Knockbacksource found, using Hitbox owner.")
		knockback_source_node = owner

func _on_area_entered(area: Area3D) -> void:
	if not area is Hurtbox:
		return
	
	if area.owner is Entity:
		var entity: Entity = area.owner
		entity.damage(damage, owner)
		var knockback_dir = owner.global_position.direction_to(entity.global_position)
		knockback_dir.y = .1
		entity.knockback(knockback_dir.normalized(), knockback_strength)
