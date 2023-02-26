class_name Entity
extends CharacterBody3D

signal health_changed(new_health, previous_health, max_health)

@export var max_health: float = 20
@export var knockback_drag: float = .1

var health := max_health
var last_damage_source: Node

var stagger_timer: float = 0

func _process(delta: float) -> void:
	if stagger_timer > 0:
		stagger_timer -= delta


func calculate_stagger_velocity() -> void:
	velocity = velocity.lerp(Vector3.ZERO, knockback_drag * Engine.time_scale)

func knockback(direction: Vector3, strength: float):
	velocity += direction * strength
	stagger_timer = strength / 20

func damage(amount: float, source: Node) -> void:
	var previous_health = health
	health -= amount
	last_damage_source = source
	health_changed.emit(health, previous_health, max_health)
	if health <= 0:
		die()

func die():
	queue_free()

func is_staggered() -> bool:
	return stagger_timer > 0

func unstagger() -> void:
	stagger_timer = 0
