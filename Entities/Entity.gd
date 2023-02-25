class_name Entity
extends CharacterBody3D

signal health_changed(new_health, previous_health, max_health)

@export var max_health: float = 20

var health := max_health
var last_damage_source: Node


func knockback(direction: Vector3, strength: float):
	velocity += direction * strength

func damage(amount: float, source: Node) -> void:
	var previous_health = health
	health -= amount
	last_damage_source = source
	health_changed.emit(health, previous_health, max_health)
	if health <= 0:
		die()

func die():
	queue_free()
